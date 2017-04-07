//
//  AddAddressViewController.m
//  TV
//
//  Created by HOME on 16/9/15.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AddressModel.h"

@interface AddAddressViewController ()
@property (nonatomic, copy) NSString *provience;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *distr;
@end

@implementation AddAddressViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑";
    [self loadUI];
//    [self addBackForUser];
    NSLog(@"%@", self.user);
}
- (void)loadUI
{
    self.Btn.layer.cornerRadius = 4;
    self.Btn.layer.masksToBounds = YES;
    
    self.tf1.textColor = RGB(102, 102, 102);
    self.tf1.delegate = self;
    self.tf2.textColor = RGB(102, 102, 102);
    self.tf2.delegate = self;
    self.tf3.textColor = RGB(102, 102, 102);
    self.tf3.delegate = self;
    self.tf4.textColor = RGB(102, 102, 102);
    self.tf4.delegate = self;
    self.tf5.textColor = RGB(102, 102, 102);
    self.tf5.delegate = self;
    
    self.lab1.textColor = RGB(51, 51, 51);
    self.lab2.textColor = RGB(51, 51, 51);
    self.lab3.textColor = RGB(51, 51, 51);
    self.lab4.textColor = RGB(51, 51, 51);
    self.lab5.textColor = RGB(51, 51, 51);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)xiugaiBtnClick:(id)sender {
    AddressModel *model = [[AddressModel alloc] init];
    model.receiverAddress = [NSString stringWithFormat:@"%@%@%@", self.tf1.text, self.tf2.text, self.tf3.text];
    model.receiverName = self.tf4.text;
    model.receiverMobile = self.tf5.text;
    if (self.provience == nil || self.city == nil || self.distr == nil) {
        [MBProgressHUD showError:@"请选择地区"];
        return;
    }
    NSDictionary *parameters = @{
                                 @"userId": self.user.ID,
                                 @"receiverName": self.tf4.text,
                                 @"receiverMobile": self.tf5.text,
                                 @"receiverState": self.provience,
                                 @"receiverCity": self.city,
                                 @"receiverDistrict": self.distr,
                                 @"receiverAddress": model.receiverAddress
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/OrderShopping/save" person:RequestPersonWeiMing parameters:parameters success:^(id successResponse) {
        if ([successResponse isSuccess]) {
            self.callBack(model);
        } else {
            [MBProgressHUD showError:@"添加失败"];
        }
        NSLog(@"%@", successResponse);
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD showError:@"添加失败"];
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)diquBtn:(id)sender {
    [self.view endEditing:YES];
    TWSelectCityView *city = [[TWSelectCityView alloc] initWithTWFrame:self.view.bounds TWselectCityTitle:@"选择地区"];
    [city showCityView:^(NSString *proviceStr, NSString *cityStr, NSString *distr) {
        self.provience = proviceStr;
        self.city = cityStr;
        self.distr = distr;
        NSString *str    = [NSString stringWithFormat:@"%@%@%@",proviceStr,cityStr,distr];
        self.tf1.text = str;
    } tag:2];
}
@end
