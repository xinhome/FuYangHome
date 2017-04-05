//
//  CustomMadeViewController.m
//  家居定制
//
//  Created by iKing on 2017/4/5.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CustomMadeViewController.h"

@interface CustomMadeViewController ()
@property (nonatomic, weak) UITextField *name;///<姓名
@property (nonatomic, weak) UITextField *telephone;///<电话
@property (nonatomic, weak) UITextField *address;///<地址

@end

@implementation CustomMadeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:UIColorWhite] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全屋订制";
    [self setupUI];
}
- (void)setupUI {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    scrollView.backgroundColor = huiseColor;
    UILabel *label1 = [UILabel labelWithText:@"姓名" textColor:UIColorBlack fontSize:16];
    [label1 sizeToFit];
    label1.origin = (CGPoint){17, 17};
    [scrollView addSubview:label1];
    
    UILabel *label2 = [UILabel labelWithText:@"电话" textColor:UIColorBlack fontSize:16];
    [label2 sizeToFit];
    label2.origin = (CGPoint){17, label1.bottom+18};
    [scrollView addSubview:label2];
    
    UILabel *label3 = [UILabel labelWithText:@"地址" textColor:UIColorBlack fontSize:16];
    [label3 sizeToFit];
    label3.origin = (CGPoint){17, label2.bottom+18};
    [scrollView addSubview:label3];
    
    UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake(label1.right+10, 0, rateWidth(220), 40)];
    name.centerY = label1.centerY;
    [scrollView addSubview:name];
    
    UITextField *telephone = [[UITextField alloc] initWithFrame:CGRectMake(label2.right+10, 0, rateWidth(220), 40)];
    telephone.centerY = label2.centerY;
    [scrollView addSubview:telephone];
    
    UITextField *address = [[UITextField alloc] initWithFrame:CGRectMake(label3.right+10, 0, rateWidth(220), 40)];
    address.centerY = label3.centerY;
    [scrollView addSubview:address];
    
    UIView *view1 = [[UIView alloc] initWithFrame:(CGRect){0, label3.bottom+20, kScreenWidth, 20}];
    view1.backgroundColor = RGBA(0, 0, 0, 0.3);
    [scrollView addSubview:view1];
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(rateWidth(16), 9.5, rateWidth(55), 1)];
    line1.backgroundColor = UIColorWhite;
    [view1 addSubview:line1];
    
//    UILabel *
}

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
