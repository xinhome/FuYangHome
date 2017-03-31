//
//  ViewController2.m
//  view
//
//  Created by iKing on 2017/3/21.
//  Copyright © 2017年 iKing. All rights reserved.
//

#import "ViewController2.h"
#import "TableViewCell.h"
#import "AFNetworking.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "RSADataSigner.h"

@interface ViewController2 ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付订单";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认支付" style:UIBarButtonItemStyleDone target:self action:@selector(doAlipayPay2)];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
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

- (void)doAlipayPay2 {
    NSDictionary *parameters = @{
                                 @"subject": @"大乐透",
                                 @"out_trade_no": @"70501111111S001111115",
                                 @"total_amount": @"9.00",
                                 @"body": @"iPhone6 16G"
                                 };
    [MBProgressHUD showMessage:@"加载"];
    [[HttpRequestManager shareManager] addPOSTURL:@"/Order/OrderBuy" person:RequestPersonWeiMing parameters:parameters success:^(id successResponse) {
        [MBProgressHUD hideHUD];
        NSLog(@"%@", successResponse);
        [[AlipaySDK defaultService] payOrder:successResponse[@"data"] fromScheme:@"fuyangjiaju" callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
        NSLog(@"%@", error);
    }];
}
#pragma mark -
#pragma mark   ==============点击订单模拟支付行为==============
//
//选中商品调用支付宝极简支付
//
- (void)doAlipayPay
{
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
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
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
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA2";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@", orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
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

- (NSString*)orderItemWithKey:(NSString*)key andValue:(NSString*)value encoded:(BOOL)bEncoded
{
    if (key.length > 0 && value.length > 0) {
        if (bEncoded) {
            value = [self encodeValue:value];
        }
        return [NSString stringWithFormat:@"%@=%@", key, value];
    }
    return nil;
}

- (NSString*)encodeValue:(NSString*)value
{
    NSString* encodedValue = value;
    if (value.length > 0) {
        NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+ $,./?%#[]"] invertedSet];
        
        encodedValue = [value stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    }
    return encodedValue;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"数量";
                cell.detailTextLabel.text = @"1";
            } else {
                cell.textLabel.text = @"总价";
                cell.detailTextLabel.text = @"￥80";
            }
        } else {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"抵用券/优惠代码";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                cell.textLabel.text = @"还需支付";
                cell.detailTextLabel.text = @"￥80";
            }
        }
        return cell;
    } else {
        TableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TableViewCell class]) owner:nil options:nil].lastObject;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        return cell;
    }
}


//        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//        for (NSString *sub in subStrings) {
//            NSArray<NSString *> *dictionary = [sub componentsSeparatedByString:@"="];
//            dict[dictionary.firstObject] = dictionary.lastObject;
//        }
//        NSString *sign = [dict valueForKey:@"sign"];
//        NSString *newsign = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)sign, NULL, (CFStringRef)@"!*'();:@&=+ $,./?%#[]", kCFStringEncodingUTF8));
//        dict[@"sign"] = newsign;
//
//        NSMutableArray *arr = [NSMutableArray array];
//        for (NSString *key in dict.allKeys) {
//            [arr addObject:[NSString stringWithFormat:@"%@=%@", key, [dict valueForKey:key]]];
//        }
//        NSString *payOrder = [arr componentsJoinedByString:@"&"];
//        NSData *contentData = [NSJSONSerialization dataWithJSONObject:content options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *payOrder = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
//        NSString *payOrder = [self encodeValue:content];

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
