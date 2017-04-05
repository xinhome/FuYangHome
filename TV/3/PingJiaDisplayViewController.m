//
//  PingJiaDisplayViewController.m
//  家居定制
//
//  Created by iking on 2017/4/5.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "PingJiaDisplayViewController.h"

@interface PingJiaDisplayViewController ()

@property (nonatomic, strong) NSDictionary *dataDic;

@end

@implementation PingJiaDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评价详情";
    
    [self setUpData];
//    [self setUpUI];
}
- (void)setUpData
{
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/Order/showMsg" person:RequestPersonWeiMing parameters:@{@"id": @([_model.goodsId intValue])} success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([successResponse isSuccess]) {
            self.dataDic = successResponse[@"data"][0];
            NSLog(@"评价详情%@", _dataDic);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setUpUI];
            });
            [self setUpUI];
            
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常"];
    }];

}
- (void)setUpUI
{
    UIImageView *goodsImg = [UIImageView new];
    [goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WeiMingURL,_model.picPath]]];
    [self.view addSubview:goodsImg];
    [goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(rateWidth(39), rateWidth(39)));
        make.top.equalTo(self.view).offset(rateHeight(10));
        make.left.equalTo(self.view).offset(rateWidth(15));
    }];
    
    NSArray *arrayTitle = @[@"好评",@"中评",@"差评"];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithTitle:arrayTitle[i] fontSize:15 titleColor:[UIColor whiteColor] background:UIColorFromRGB(0xc1bfc7) cornerRadius:rateHeight(14)];
        btn.enabled = NO;
        btn.tag = i+10;
        btn.frame = CGRectMake(rateWidth(80)+rateWidth(100)*i, rateHeight(15), rateWidth(55), rateHeight(28));
        [self.view addSubview:btn];
    }
    UIButton *firstBtn;
    if (_dataDic[@"buyerStatus"] == nil) {
        firstBtn = (UIButton *)[self.view viewWithTag:10];
    } else {
        firstBtn = (UIButton *)[self.view viewWithTag:[_dataDic[@"buyerStatus"] intValue] +10];
    }
    [firstBtn setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xfe3102)] forState:UIControlStateNormal];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0xdfdce6);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(goodsImg.mas_bottom).offset(rateHeight(10));
        make.height.equalTo(@(0.5));
    }];
    
    UILabel *textLB = [UILabel labelWithText:_dataDic[@"buyerMsg"] textColor:UIColorFromRGB(0xa7a7a7) fontSize:13];
    textLB.numberOfLines = 0;
    [self.view addSubview:textLB];
    [textLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line).with.offset(rateHeight(10));
        make.left.equalTo(line).offset(rateWidth(20));
        make.width.equalTo(@(kScreenWidth-rateWidth(40)));
    }];
    
    NSArray *imgArray;
    if (_dataDic[@"buyerPic"] != nil) {
        
        if ([_dataDic[@"buyerPic"] rangeOfString:@","].location != NSNotFound) {
            NSLog(@"yes");
            imgArray = [_dataDic[@"buyerPic"] componentsSeparatedByString:@","];
            
        } else {
            imgArray = @[_dataDic[@"buyerPic"]];
            NSLog(@"no");
        }
        for (int i = 0; i < imgArray.count; i ++) {
            UIImageView *img = [UIImageView new];
            img.backgroundColor = [UIColor lightGrayColor];
            img.tag = i + 100;
            [self.view addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(rateWidth(60), rateHeight(50)));
                make.left.equalTo(self.view).offset(rateWidth(20)+rateWidth(65)*i);
                make.top.equalTo(textLB.mas_bottom).offset(rateHeight(10));
            }];
        }
    } else {
        
    }
    
    
    UIImageView *img = (UIImageView *)[self.view viewWithTag:100];
    UIView *line1 = [UIView new];
    line1.backgroundColor = UIColorFromRGB(0xdfdce6);
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(img.mas_bottom).offset(rateHeight(10));
        make.height.equalTo(@(0.5));
    }];
    
    UIButton *niMingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    NSString *niMingStr;
    if (_dataDic[@"buyerNm"] == nil) {
        niMingStr = @"匿名选中";
    } else {
        if ([_dataDic[@"buyerNm"] intValue] == 0) {
            niMingStr = @"匿名未选";
        } else {
            niMingStr = @"匿名选中";
        }
    }
    [niMingBtn setImage:[UIImage imageNamed:niMingStr] forState:(UIControlStateNormal)];
    niMingBtn.enabled = NO;
    [self.view addSubview:niMingBtn];
    [niMingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(rateWidth(25));
        make.top.equalTo(line1.mas_bottom).offset(rateHeight(20));
        make.size.mas_offset(CGSizeMake(rateWidth(15), rateWidth(15)));
    }];
    
    UILabel *label = [UILabel labelWithText:@"匿名评价" textColor:UIColorFromRGB(0x333333) fontSize:14];
    [label sizeToFit];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(niMingBtn);
        make.left.equalTo(niMingBtn.mas_right).offset(rateWidth(15));
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
