
//
//  JieSuanOrderViewController.m
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "JieSuanOrderViewController.h"
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
#import "ConfirmOrderTableViewCell.h"
#import "ItemTableViewCell.h"
#import "JiFenDuiHuanViewController.h"
#import "CouponViewController.h"

@interface JieSuanOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, weak) UILabel *dizhiLabel;///<<#注释#>

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
    NSDictionary *result = notification.userInfo[@"resultDic"];
    if ([result[@"resultStatus"] intValue] == 9000) {
        [self loadSuccessView];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"确认订单";
    self.view.backgroundColor = RGB(242, 242, 242);
    [self.view addSubview:self.myTableView];
    [self setUpUI];
}
- (void)setUpUI
{
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(kScreenWidth, rateHeight(50)));
    }];
    
    CGFloat sumPrice = 0.0;
    NSString *str;
    for (ShoppingCarModel *model in _listArray) {
        sumPrice = sumPrice + [model.price floatValue]*[model.num intValue];
        str = [NSString stringWithFormat:@"共计：%.2f元（含0元运费）", sumPrice];
    }
    UILabel *gongJiLB = [UILabel labelWithText:str textColor:RGB(131, 131, 131) fontSize:14];
    [gongJiLB sizeToFit];
    [bottomView addSubview:gongJiLB];
    [gongJiLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).mas_offset(rateWidth(25));
        make.centerY.equalTo(bottomView);
    }];
    
    UIButton *confirmOrderBtn = [UIButton buttonWithTitle:@"确认订单" fontSize:16 titleColor:[UIColor whiteColor] background:RGB(226, 44, 50) cornerRadius:0];
    [bottomView addSubview:confirmOrderBtn];
    [confirmOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView);
        make.right.equalTo(bottomView);
        make.size.mas_offset(CGSizeMake(rateWidth(110), rateHeight(50)));
    }];
    [confirmOrderBtn addActionHandler:^{
        [self doAlipayPay];
    }];
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
    parameters[@"userId"] = self.user.ID;
    parameters[@"post_fee"] = @(0.06);
    parameters[@"couponsId"] = @"";
    parameters[@"credit"] = @"";

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
//    [[HttpRequestManager shareManager] addPOSTURL:@"/Order/OrderBuy" person:RequestPersonWeiMing parameters:parameters success:^(id successResponse) {
//        [MBProgressHUD hideHUD];
//        NSLog(@"%@", successResponse);
//        [[AlipaySDK defaultService] payOrder:successResponse[@"data"] fromScheme:@"fuyangjiaju" callback:^(NSDictionary *resultDic) {
//            NSLog(@"%@", resultDic);
//        }];
//    } fail:^(NSError *error) {
//        NSLog(@"%@", error);
//        [MBProgressHUD hideHUD];
//    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return _listArray.count;
    } else {
        return 4;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.contentView.backgroundColor = RGB(242, 242, 242);
        UIImageView *line1 = [UIImageView new];
        line1.image = [UIImage imageNamed:@"line0"];
        [cell.contentView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView);
            make.left.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView);
            make.height.equalTo(@(1));
        }];
        UIImageView *line2 = [UIImageView new];
        line2.image = [UIImage imageNamed:@"line0"];
        [cell.contentView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell.contentView);
            make.left.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView);
            make.height.equalTo(@(1));
        }];
        UIImageView *arrowImg = [UIImageView new];
        arrowImg.image = [UIImage imageNamed:@"jiantou"];
        [cell.contentView addSubview:arrowImg];
        [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView).offset(-rateWidth(20));
            make.size.mas_offset(CGSizeMake(rateWidth(8), rateWidth(13)));
        }];
        
        // 没有默认收货地址
//        UIImageView *editDiZhi = [UIImageView new];
//        editDiZhi.image = [UIImage imageNamed:@"dizhi"];
//        [cell.contentView addSubview:editDiZhi];
//        [editDiZhi mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(cell.contentView);
//            make.left.equalTo(cell.contentView).offset(rateWidth(20));
//            make.size.mas_offset(CGSizeMake(rateWidth(25), rateWidth(25)));
//            
//        }];
//        
//        UILabel *diZhiLB = [UILabel labelWithText:@"填写收货地址" textColor:RGB(72, 72, 72) fontSize:15];
//        [diZhiLB sizeToFit];
//        [cell.contentView addSubview:diZhiLB];
//        [diZhiLB mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(cell.contentView);
//            make.left.equalTo(editDiZhi.mas_right).offset(rateWidth(15));
//        }];
        
        // 有默认地址
        UILabel *label1 = [UILabel labelWithText:[NSString stringWithFormat:@"收货人:%@", self.selectAddressModel.receiverName] textColor:RGB(0, 0, 0) fontSize:15];
        [label1 sizeToFit];
        [cell.contentView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(rateWidth(20));
            make.top.equalTo(cell.contentView).offset(rateHeight(20));
        }];
        
        UILabel *label2 = [UILabel labelWithText:[NSString stringWithFormat:@"地址:%@", self.selectAddressModel.receiverAddress] textColor:RGB(163, 162, 163) fontSize:14];
        [label2 sizeToFit];
        [cell.contentView addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(rateWidth(20));
            make.top.equalTo(label1.mas_bottom).offset(rateHeight(10));
        }];
        
        UILabel *label3 = [UILabel labelWithText:[NSString stringWithFormat:@"电话:%@", self.selectAddressModel.receiverMobile] textColor:RGB(163, 162, 163) fontSize:14];
        [label3 sizeToFit];
        [cell.contentView addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(rateWidth(20));
            make.top.equalTo(label2.mas_bottom).offset(rateHeight(5));
        }];

        cell.selectionStyle = NO;
        return cell;
    } else if (indexPath.section == 1) {
        ConfirmOrderTableViewCell *cell = [[ConfirmOrderTableViewCell alloc] init];
        cell.selectionStyle = NO;
        cell.cellModel = (ShoppingCarModel *)_listArray[indexPath.row];
        return cell;
    } else {
        ItemTableViewCell *cell = [[ItemTableViewCell alloc] init];
        cell.selectionStyle = NO;
        NSArray *array = @[@"快递运费：",@"使用优惠券：",@"积分抵现：",@"价格合计："];
        cell.firstLB.text = array[indexPath.row];
        if (indexPath.row == 0 || indexPath.row == 3) {
            cell.arrow.hidden = YES;
        }
        if (indexPath.row == 0) {
            cell.arrow.hidden = YES;
        } else if (indexPath.row == 1) {
            cell.secondLB.text = @"无可用";
        } else if (indexPath.row == 2) {
            cell.secondLB.text = @"100积分抵10元";
            cell.secondLB.textColor = RGB(140, 140, 140);
        } else {
            CGFloat sumPrice = 0.0;
            NSString *str;
            for (ShoppingCarModel *model in _listArray) {
                sumPrice = sumPrice + [model.price floatValue]*[model.num intValue];
                str = [NSString stringWithFormat:@"%.2f", sumPrice];
            }
            cell.arrow.hidden = YES;
            cell.secondLB.text = [NSString stringWithFormat:@"￥%@", str];
        }
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 没有默认收货地址
//        return rateHeight(60);
        // 有默认收货地址
        return rateHeight(100);
    } else if (indexPath.section == 1) {
        return rateHeight(95);
    } else {
        return rateHeight(45);
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 修改地址
        changeAddressViewController *changeAddressVC = [[changeAddressViewController alloc] init];
        [changeAddressVC setSelectAddress:^(AddressModel *model){
            self.selectAddressModel = model;
            self.dizhiLabel.text = model.receiverAddress;
            
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:changeAddressVC animated:YES];
    } else if (indexPath.section == 2 && indexPath.row == 2) {
        JiFenDuiHuanViewController *jiFenVC = [[JiFenDuiHuanViewController alloc] init];
        [self.navigationController pushViewController:jiFenVC animated:YES];
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        [self pushViewController:[[CouponViewController alloc] init] animation:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return rateHeight(10);
    } else {
        return 0.01;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(10))];
    footerView.backgroundColor = RGB(242, 242, 242);
    return footerView;
}
#pragma mark - 修改地址
//- (void)changeAddress:(UIButton *)btn
//{
//    changeAddressViewController *changeAddressVC = [[changeAddressViewController alloc] init];
//    [changeAddressVC setSelectAddress:^(AddressModel *model){
//        self.selectAddressModel = model;
//        self.dizhiLabel.text = model.receiverAddress;
//       
//        [self.tableView reloadData];
//    }];
//    [self.navigationController pushViewController:changeAddressVC animated:YES];
//}
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
