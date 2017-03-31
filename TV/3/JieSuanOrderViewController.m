
//
//  JieSuanOrderViewController.m
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "JieSuanOrderViewController.h"
#import "OrderFirstView.h"
#import "JieSuanView.h"
#import "JieSuanListTableViewCell.h"
#import "ReturnGoodsTableViewCell.h"
#import "ShoppingCarModel.h"
#import "changeAddressViewController.h"
#import "AddressModel.h"
#import "Order.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MyOrderViewController.h"
#import "AppDelegate.h"
#import "MyTabBarViewController.h"

@interface JieSuanOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, weak) UILabel *dizhiLabel;///<<#注释#>
@property (nonatomic, weak) JieSuanView *contactPerson;///<<#注释#>
@property (nonatomic, weak) JieSuanView *contactPhone;///<<#注释#>

@property (nonatomic, strong) NSTimer *timer;///<<#注释#>
@property (nonatomic, weak) UILabel *successLabel;///<<#注释#>
@property (nonatomic, assign) int timeCount;///< <#注释#>
@property (nonatomic, weak) UIView *cover;///<<#注释#>
@end

@implementation JieSuanOrderViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPaySuccess:) name:@"AlipaySuccess" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)aliPaySuccess:(NSNotification *)notification {
    NSLog(@"%@", notification.userInfo);
    NSDictionary *result = [notification.userInfo[@"resultDict"][@"result"] mj_JSONObject];
    if ([[result valueForKey:@"alipay_trade_app_pay_response"][@"code"] intValue] == 10000) {
        [self loadSuccessView];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"结算";
    self.view.backgroundColor = RGB(242, 242, 242);
    [self.view addSubview:self.myTableView];
    [self setUpUI];
}
- (void)setUpUI
{
    UIButton *tiJiaoBtn = [UIButton buttonWithTitle:@"提交订单" fontSize:16 titleColor:[UIColor whiteColor] background:RGB(102, 209, 191) cornerRadius:6];
    [tiJiaoBtn addActionHandler:^{
        [self doAlipayPay];
    }];
    [self.view addSubview:tiJiaoBtn];
    [tiJiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-rateHeight(30));
        make.centerX.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(rateWidth(230), rateHeight(50)));
    }];
}
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
- (void)doAlipayPay {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    float total_amount = 0.0f;
    for (int i = 0; i < self.listArray.count; i ++) {
        ShoppingCarModel *model = self.listArray[i];
        total_amount = total_amount + [model.num intValue] * [model.price floatValue];
        NSString *ID = [NSString stringWithFormat:@"order[%d].id", i];
        NSString *itemId = [NSString stringWithFormat:@"order[%d].itemId", i];
        NSString *orderId = [NSString stringWithFormat:@"order[%d].orderId", i];
        NSString *num = [NSString stringWithFormat:@"order[%d].num", i];
        NSString *price = [NSString stringWithFormat:@"order[%d].price", i];
        NSString *totalFee = [NSString stringWithFormat:@"order[%d].totalFee", i];
        NSString *picPath = [NSString stringWithFormat:@"order[%d].picPath", i];
        NSString *style = [NSString stringWithFormat:@"order[%d].style", i];
        NSString *colour = [NSString stringWithFormat:@"order[%d].colour", i];
        parameters[ID] = model.goodsId;
        parameters[itemId] = model.itemId;
        parameters[orderId] = model.orderId;
        parameters[num] = model.num;
        parameters[price] = model.price;
        parameters[totalFee] = model.totalFee;
        parameters[picPath] = model.picPath;
        parameters[style] = model.style;
        parameters[colour] = model.colour;
    }
    parameters[@"receiverId"] = self.selectAddressModel.receiverId;
    parameters[@"total_amount"] = @(0.01);
    parameters[@"userId"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"myUserId"];
    parameters[@"post_fee"] = @(0.06);
    //parameters[@"receiverName"] = self.selectAddressModel.receiverName;
    //parameters[@"receiverMobile"] = self.selectAddressModel.receiverMobile;
    //parameters[@"receiverState"] = self.selectAddressModel.receiverState;
   // parameters[@"receiverCity"] = self.selectAddressModel.receiverCity;
   // parameters[@"receiverDistrict"] = self.selectAddressModel.receiverDistrict;
   // parameters[@"receiverAddress"] = self.selectAddressModel.receiverAddress;
//    [MBProgressHUD showMessage:nil];
//    [[HttpRequestManager shareManager] addPOSTURL:@"/Order/OrderBuy" person:RequestPersonWeiMing parameters:parameters success:^(id successResponse) {
//        [MBProgressHUD hideHUD];
//        NSLog(@"%@", successResponse);
//        [[AlipaySDK defaultService] payOrder:successResponse[@"data"] fromScheme:@"fuyangjiaju" callback:^(NSDictionary *resultDic) {
//            NSLog(@"%@", resultDic);
//        }];
//    } fail:^(NSError *error) {
//        [MBProgressHUD hideHUD];
//        NSLog(@"%@", error);
//    }];
    [MBProgressHUD showMessage:nil];
    [[AFHTTPSessionManager manager] POST:@"http://xwmasd.ngrok.cc/FyHome/Order/OrderBuy" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        NSLog(@"%@", responseObject);
        [[AlipaySDK defaultService] payOrder:responseObject[@"data"] fromScheme:@"fuyangjiaju" callback:^(NSDictionary *resultDic) {
            NSLog(@"%@", resultDic);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUD];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return _listArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(260))];
        view1.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [UIImageView new];
        img.image = [UIImage imageNamed:@"矩形 7"];
        [view1 addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view1);
            make.top.equalTo(view1).offset(rateHeight(15));
            make.size.mas_offset(CGSizeMake(kScreenWidth-rateWidth(30), rateHeight(180)));
        }];
        [self.view addSubview:view1];
        
        NSArray *array = @[@"联系方式：",@"收货人："];
        NSArray *array1 = @[@"022-213124234",@"李先生"];
        for (int i = 0; i < 2; i++) {
            JieSuanView *view = [JieSuanView new];
            [img addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(img);
                make.right.equalTo(img);
                make.bottom.equalTo(img).offset(-rateHeight(50)*i);
                make.height.equalTo(@(rateHeight(50)));
            }];
            view.firstLB.text = array[i];
            view.secondLB.text = array1[i];
            if (i == 0) {
                self.contactPerson = view;
            } else {
                self.contactPhone = view;
            }
        }
        
        UILabel *dizhi = [UILabel labelWithText:@"收货地址：" textColor:RGB(156, 156, 156) fontSize:15];
        [dizhi sizeToFit];
        [view1 addSubview:dizhi];
        [dizhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img).offset(rateHeight(20));
            make.left.equalTo(img).offset(rateWidth(20));
        }];
        UILabel *dizhi1 = [UILabel labelWithText:@"天津市河西区富力中心大厦B座21层2101" textColor:RGB(156, 156, 156) fontSize:15];
        self.dizhiLabel = dizhi1;
        dizhi1.numberOfLines = 0;
        [view1 addSubview:dizhi1];
        [dizhi1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img).offset(rateHeight(20));
            make.left.equalTo(dizhi.mas_right);
            make.width.equalTo(@(rateWidth(225)));
        }];
        UIButton *xiuGaiBtn = [UIButton buttonWithTitle:@"修改" fontSize:15 titleColor:RGB(79, 79, 79) background:[UIColor whiteColor] cornerRadius:4];
        xiuGaiBtn.layer.borderWidth = 1;
        xiuGaiBtn.layer.borderColor = RGB(117, 223, 214).CGColor;
        [view1 addSubview:xiuGaiBtn];
        [xiuGaiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(img);
            make.bottom.equalTo(view1).offset(-rateHeight(10));
            make.size.mas_offset(CGSizeMake(rateWidth(75), rateHeight(37)));
        }];
        [xiuGaiBtn addTarget:self action:@selector(changeAddress:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.contentView addSubview:view1];
        cell.selectionStyle = NO;
        return cell;
    } else {
        static NSString *identifier = @"cellone";
        ReturnGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ReturnGoodsTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        cell.selectionStyle = NO;
        cell.shouHouBtn.hidden = YES;
        cell.cellModel = (ShoppingCarModel *)_listArray[indexPath.row];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return rateHeight(260);
    } else {
        return rateHeight(95);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    } else {
        return rateHeight(40);
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(40))];
        headerView.backgroundColor = [UIColor whiteColor];
        ShoppingCarModel *model = (ShoppingCarModel *)_listArray[0];
        UILabel *orderNumLB = [UILabel labelWithText:[NSString stringWithFormat:@"订单编号：%@", model.orderId] textColor:UIColorFromRGB(0x666666) fontSize:14];
        [orderNumLB sizeToFit];
        [headerView addSubview:orderNumLB];
        [orderNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(rateWidth(20));
            make.centerY.equalTo(headerView);
        }];
        return headerView;
    } else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return rateHeight(80);
    } else {
        return rateHeight(10);
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(80))];
        footerView.backgroundColor = [UIColor whiteColor];
        CGFloat sumPrice = 0.0;
        NSString *str;
        for (ShoppingCarModel *model in _listArray) {
            sumPrice = sumPrice + [model.price floatValue]*[model.num intValue];
            str = [NSString stringWithFormat:@"共计：%.2f元（含0元运费）", sumPrice];
        }
        UILabel *priceLB = [UILabel labelWithText:str textColor:UIColorFromRGB(0x666666) fontSize:15];
        [priceLB sizeToFit];
        [footerView addSubview:priceLB];
        [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footerView).offset(rateHeight(15));
            make.centerX.equalTo(footerView);
        }];
        return footerView;
    } else {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(10))];
        footerView.backgroundColor = RGB(242, 242, 242);
        return footerView;
    }
}
#pragma mark - 修改地址
- (void)changeAddress:(UIButton *)btn
{
    changeAddressViewController *changeAddressVC = [[changeAddressViewController alloc] init];
    [changeAddressVC setSelectAddress:^(AddressModel *model){
        self.selectAddressModel = model;
        self.dizhiLabel.text = model.receiverAddress;
        self.contactPerson.secondLB.text = model.receiverName;
        self.contactPhone.secondLB.text = model.receiverMobile;
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:changeAddressVC animated:YES];
}
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-rateHeight(170)) style:(UITableViewStyleGrouped)];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = NO;
    }
    return _myTableView;
}


- (void)loadSuccessView {
    self.timeCount = 3;
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.cover = coverView;
    coverView.backgroundColor = RGBA(0, 0, 0, 0.3);
    [[UIApplication sharedApplication].keyWindow addSubview:coverView];
    
    UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rateWidth(330), rateHeight(270))];
    tipView.center = coverView.center;
    tipView.backgroundColor = UIColorWhite;
    tipView.layer.cornerRadius = 7;
    tipView.layer.masksToBounds = YES;
    [coverView addSubview:tipView];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tipView.width, rateHeight(85))];
    iv.image = UIImageNamed(@"圆角矩形 2");
    [tipView addSubview:iv];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((tipView.width-rateWidth(58))/2, rateWidth(58), rateWidth(58), rateWidth(58))];
    //imageView.centerX = kScreenWidth/2;
    NSLog(@"%f", imageView.centerX);
    imageView.image = UIImageNamed(@"duihao");
    [tipView addSubview:imageView];
    
    UILabel *successLabel = [UILabel labelWithText:@"付款成功" textColor:UIColorFromRGB(0xf24d4d) fontSize:17];
    [successLabel sizeToFit];
    successLabel.top = imageView.bottom+rateHeight(20);
    successLabel.left = (tipView.width-successLabel.width)/2;
    [tipView addSubview:successLabel];
    
    UILabel *label = [UILabel labelWithText:@"" textColor:UIColorFromRGB(0x666666) fontSize:13];
    self.successLabel = label;
    label.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d秒后跳转到 我的订单", self.timeCount]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x666666) range:NSMakeRange(0, 5)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xf24d4d) range:NSMakeRange(7, attrStr.string.length-7)];
    label.attributedText = attrStr;
    label.frame = CGRectMake(0, successLabel.bottom+rateHeight(23), tipView.width, 13);
    [tipView addSubview:label];
    
    UILabel *lbl = [UILabel labelWithText:@"手动跳转到" textColor:UIColorFromRGB(0xa6a6a6) fontSize:13];
    [lbl sizeToFit];
    lbl.right = kScreenWidth/2-10;
    lbl.top = label.bottom+rateHeight(25);
    [tipView addSubview:lbl];
    
    UIButton *btn = [UIButton buttonWithTitle:@"首页" fontSize:12 titleColor:UIColorWhite background:UIColorFromRGB(0xf24d4d) cornerRadius:7];
    [btn addActionHandler:^{
        [self.timer invalidate];
        self.timer = nil;
        [self.cover removeFromSuperview];
        [self.navigationController popToRootViewControllerAnimated:NO];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        MyTabBarViewController *rootVC = (MyTabBarViewController *)app.window.rootViewController;
        rootVC.selectedIndex = 0;
    }];
    btn.frame = CGRectMake(lbl.right+10, 0, 50, 20);
    btn.centerY = lbl.centerY;
    [tipView addSubview:btn];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeIncreament) userInfo:nil repeats:YES];
}
- (void)timeIncreament {
    if (self.timeCount == 0) {
        [self dismiss];
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    self.timeCount --;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d秒后跳转到 我的订单", self.timeCount]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x666666) range:NSMakeRange(0, 5)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xf24d4d) range:NSMakeRange(7, attrStr.string.length-7)];
    self.successLabel.attributedText = attrStr;
}
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.cover.alpha = 0;
    } completion:^(BOOL finished) {
        [self.cover removeFromSuperview];
        [self.navigationController popToRootViewControllerAnimated:NO];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        MyTabBarViewController *rootVC = (MyTabBarViewController *)app.window.rootViewController;
        [rootVC.selectedViewController pushViewController:[[MyOrderViewController alloc] init] animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
