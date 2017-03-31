
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

@interface JieSuanOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, weak) UILabel *dizhiLabel;///<<#注释#>
@property (nonatomic, weak) JieSuanView *contactPerson;///<<#注释#>
@property (nonatomic, weak) JieSuanView *contactPhone;///<<#注释#>
@property (nonatomic, strong) AddressModel *selectAddressModel;///<<#注释#>
@end

@implementation JieSuanOrderViewController

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
    parameters[@"total_amount"] = @(0.01);
    parameters[@"userId"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"myUserId"];
    parameters[@"post_fee"] = @(0.06);
    parameters[@"receiverName"] = self.selectAddressModel.receiverName;
    parameters[@"receiverMobile"] = self.selectAddressModel.receiverMobile;
    parameters[@"receiverState"] = self.selectAddressModel.receiverState;
    parameters[@"receiverCity"] = self.selectAddressModel.receiverCity;
    parameters[@"receiverDistrict"] = self.selectAddressModel.receiverDistrict;
    parameters[@"receiverAddress"] = self.selectAddressModel.receiverAddress;
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
- (void)test {
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2017031406218438";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCJlVerCcWhgXHFCpVzshC29bIDVu8s6L4RWv5J/vxn7P+1r5rz1CjoBGt1bsU7nK5ohmMdu4DEqvJZkHJPV5A3DYHMHWcQqRH9A675IevWN3XF5EIZcN4Tr2YJ0b+yp2EWw5dDiyMIhnZFdpoIqzAW/D+7O35HaEGFj6FNPBY3dlEGg6wl8yqRFDN4e+tnCQjZzBf+Cy2O7hEhuXpZffICzuxuBSImfkgY4pLkhg4s3UOnyIgkJ+8HhKnfihLC/VsHdPWFQZT0H79L6CUO0P5DHGpy8Rmmwy51bJFcA+bHAFuj6cAqqnKoRTTWfoabXEL8+lP6YuZgs9TyytPJOzrFAgMBAAECggEAJZPwufqVTCN624Kkh1EfV5mL4XWhJfb70umzgqpubkRBI3KvM+HCunxajVyP6lRFHq916u0Hoq++OdBGKH2WGjNKPGHbgKVtEFotNEabj4reVAqgMyqsvVuu1we/ACDPV9RcQEqEaxOuwhI+yBdZry1+irkZKI/FNaGhQOMkfkketuwj4zKMqZzf2zcsxquMvQevOYMdjYRoa9qVEWJVaMiJuKpN0es/mjnVT5Tyq6j4ITrHYQ77P8oTORi9B7jCkN4CGI+W0DGc4xQ1bG/CBIoJPSXs9GhSjfFQgFc4c76PTi//utPAfFav0xpU4L391K3/SZkrxkc9/U2CAfyHAQKBgQDdQga4F4kgNyqukBdAR/yHdXETuxOh3EIL4xPRZF+WCXqi5x5rg3iwM/FZgi2/Dqc4ldJWPS67/HQTcjd65UqBDrsw/gwgxrOJz/yifoxrQUCbJePIq6vB4W/6C26jFYmL7+Rtj62OwXuyEa6attueAxTdOfj78hmQdFnOoLOEkQKBgQCfL9MCXhF8iJIkvfWwA8GwAdbsN7iTEYzCBemNGSrY+7Q+hqwKf6cfkUkZq+FmvFXpDtS4ZcRWA5vmafKvMyPNTj3QynW0ta7W2rIf32zQCuWCbUV2lud/8FH3Ogwvkj5OAUKBpWgpopvM4hI5a8FdmefsmmwDRIM1nMSqjNWc9QKBgQDC1jSygc839jx4sdw3t+xxoIKt3EyCeUIT06gM+PWPWtOKhjlsdb6ec28x4gfEufOZSZ2KYaA43CufQDII38cG9OD0WJJ3fmJ1lhijQwsGG9T3ipsWh83dElcX+l8372xLNTmTHTW5gzoY6ac3CJVGhPInibhurJfEdCDtaugKcQKBgCOkf6ieC2hI5AAaEHLSxIF2R/soFsnHOi8PR9Xx9qgS467EVK0dG/xzeVyoIZXxQYMncPXAw49Gy5dxzYbw+mkzxZ+EVYqay4UL/qooSqLibbUgZldBPqBk3NVwR9427oBkw9FnicUYxa3ASLhWqjsdBNLzWI/6vS455ccSNZopAoGAcoRGlrFJJ95puWfYx5iDxxA7MiWLdZG8cjBIgocxaWxAn+cIt/ICzxHluCLq0R1XTXRWLDOQgvp/ajeglq7Rh8EZXBhnZhifreMnuDAaFBsVizjZBSgvwG3aMbhciqZMA/V+Q24kJDv/W++TvMCebGOaA6ciE4HCQ5LfauB8C+k=";
    //NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    //if ([appID length] == 0 ||
    // ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    // {
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
    //                                                  message:@"缺少appId或者私钥。"
    //                                                 delegate:self
    //                                        cancelButtonTitle:@"确定"
    //                                       otherButtonTitles:nil];
    //  [alert show];
    // return;
    // }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = @"RSA2";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    //order.biz_content.body = @"我是测试数据";
    
    double totalFee = 0.0;
    
    for (ShoppingCarModel *model in self.listArray) {
        float price = [model.price floatValue] * [model.num intValue];
        totalFee = totalFee+price;
    }
    
    order.biz_content.subject = @"富阳家居";
    
    order.biz_content.out_trade_no = self.listArray[0].orderId; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    //order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", totalFee]; //商品价格
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01];
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:rsa2PrivateKey];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"fuyangjiaju";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        NSLog(@"%@", [orderString componentsSeparatedByString:@"&"]);
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
