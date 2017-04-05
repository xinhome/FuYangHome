//
//  JiFenDuiHuanViewController.m
//  家居定制
//
//  Created by iking on 2017/4/5.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "JiFenDuiHuanViewController.h"

@interface JiFenDuiHuanViewController ()

@end

@implementation JiFenDuiHuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"积分兑换";
    [self setUpUI];
    
}
- (void)setUpUI
{
    self.view.backgroundColor = RGB(242, 242, 242);
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(50))];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    UILabel *label1 = [UILabel labelWithText:@"当前积分：" textColor:RGB(99, 99, 99) fontSize:14];
    [label1 sizeToFit];
    [view1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1).offset(rateWidth(20));
        make.centerY.equalTo(view1);
    }];
    
    UILabel *label2 = [UILabel labelWithText:@"345分" textColor:RGB(223, 0, 0) fontSize:15];
    [label2 sizeToFit];
    [view1 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right);
        make.bottom.equalTo(label1);
    }];
    
    UILabel *label3 = [UILabel labelWithText:@"100积分兑换10元" textColor:RGB(99, 99, 99) fontSize:14];
    [label3 sizeToFit];
    [view1 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view1).offset(-rateWidth(15));
        make.centerY.equalTo(view1);
    }];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, rateHeight(60), kScreenWidth, rateHeight(50))];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    
    UILabel *label4 = [UILabel labelWithText:@"兑换积分数：" textColor:RGB(64, 64, 64) fontSize:15];
    [label4 sizeToFit];
    [view2 addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2).offset(rateWidth(20));
        make.centerY.equalTo(view2);
    }];
    
    UITextField *textField = [UITextField new];
    textField.textColor = RGB(64, 64, 64);
    textField.font = [UIFont systemFontOfSize:16];
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 4;
    textField.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label4.mas_right).offset(rateWidth(10));
        make.centerY.equalTo(label4);
        make.size.mas_offset(CGSizeMake(rateWidth(100), rateHeight(30)));
    }];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, rateHeight(110), kScreenWidth, rateHeight(50))];
    view3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view3];
    
    UILabel *label5 = [UILabel labelWithText:@"兑换金额：" textColor:RGB(64, 64, 64) fontSize:15];
    [label5 sizeToFit];
    [view3 addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3).offset(rateWidth(20));
        make.centerY.equalTo(view3);
    }];
    
    UILabel *label6 = [UILabel labelWithText:@"20元" textColor:RGB(223, 0, 0) fontSize:14];
    [label6 sizeToFit];
    [view3 addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textField);
        make.bottom.equalTo(label5);
    }];
    
    UIButton *btn = [UIButton buttonWithTitle:@"确定" fontSize:16 titleColor:[UIColor whiteColor] background:RGB(99, 203, 185) cornerRadius:6];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(view3.mas_bottom).offset(rateHeight(180));
        make.size.mas_offset(CGSizeMake(rateWidth(315), rateHeight(50)));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
