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

@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"编辑";
    [self loadUI];
    [self addBackForUser];
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
    model.address = [NSString stringWithFormat:@"%@%@%@", self.tf1.text, self.tf2.text, self.tf3.text];
    model.contact = self.tf4.text;
    model.contactTel = self.tf5.text;
    self.callBack(model);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)diquBtn:(id)sender {
    [self.view endEditing:YES];
    TWSelectCityView *city = [[TWSelectCityView alloc] initWithTWFrame:self.view.bounds TWselectCityTitle:@"选择地区"];
    [city showCityView:^(NSString *proviceStr, NSString *cityStr, NSString *distr) {
        NSString *str    = [NSString stringWithFormat:@"%@%@%@",proviceStr,cityStr,distr];
        self.tf1.text = str;
      
    } tag:2];
}
@end
