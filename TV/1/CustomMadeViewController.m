//
//  CustomMadeViewController.m
//  家居定制
//
//  Created by iKing on 2017/4/5.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CustomMadeViewController.h"
#import "EaseTextView.h"

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
    scrollView.backgroundColor = RGB(240, 240, 240);
    [self.view addSubview:scrollView];
    
    UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake(0, 25, rateWidth(230), 40)];
    name.backgroundColor = UIColorWhite;
    name.centerX = kScreenWidth/2;
    [scrollView addSubview:name];
    
    UITextField *telephone = [[UITextField alloc] initWithFrame:CGRectMake(0, name.bottom+17, rateWidth(230), 40)];
    telephone.placeholder = @"请填写真实号码";
    telephone.backgroundColor = UIColorWhite;
    telephone.centerX = kScreenWidth/2;
    [scrollView addSubview:telephone];

    UITextField *address = [[UITextField alloc] initWithFrame:CGRectMake(0, telephone.bottom+17, rateWidth(230), 40)];
    address.placeholder = @"请具体到小区名称";
    address.backgroundColor = UIColorWhite;
    address.centerX = kScreenWidth/2;
    [scrollView addSubview:address];
    
    UILabel *label1 = [UILabel labelWithText:@"姓名" textColor:UIColorFromRGB(0x333333) fontSize:17];
    [label1 sizeToFit];
    label1.right = name.left-rateWidth(20);
    label1.centerY = name.centerY;
    [scrollView addSubview:label1];
    
    UILabel *label2 = [UILabel labelWithText:@"电话" textColor:UIColorFromRGB(0x333333) fontSize:16];
    [label2 sizeToFit];
    label2.right = telephone.left-rateWidth(20);
    label2.centerY = telephone.centerY;
    [scrollView addSubview:label2];
    
    UILabel *label3 = [UILabel labelWithText:@"地址" textColor:UIColorFromRGB(0x333333) fontSize:16];
    [label3 sizeToFit];
    label3.right = address.left-rateWidth(20);
    label3.centerY = address.centerY;
    [scrollView addSubview:label3];
    
    UILabel *label4 = [UILabel labelWithText:@"房屋面积" textColor:UIColorFromRGB(0x333333) fontSize:16];
    label4.frame = CGRectMake(label3.left, label3.bottom+35, 0, 0);
    [label4 sizeToFit];
    [scrollView addSubview:label4];
    
    UITextField *roomArea = [[UITextField alloc] initWithFrame:CGRectMake(label4.right+rateWidth(19), address.bottom+17, rateWidth(195), 40)];
    roomArea.backgroundColor = UIColorWhite;
    [scrollView addSubview:roomArea];
    
    UILabel *label5 = [UILabel labelWithText:@"设计需求" textColor:UIColorFromRGB(0x333333) fontSize:16];
    label5.frame = CGRectMake(label4.left, label4.bottom+50, 0, 0);
    [label5 sizeToFit];
    [scrollView addSubview:label5];
    
    EaseTextView *textView = [[EaseTextView alloc] initWithFrame:CGRectMake(label5.right+rateWidth(19), roomArea.bottom+17, rateWidth(225), 100)];
    textView.placeHolder = @"注明主要功能";
    [scrollView addSubview:textView];
    
    UILabel *label6 = [UILabel labelWithText:@"俯视图" textColor:UIColorFromRGB(0x333333) fontSize:16];
    label6.frame = CGRectMake(label5.left, label5.bottom+130, 0, 0);
    [label6 sizeToFit];
    [scrollView addSubview:label6];
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
