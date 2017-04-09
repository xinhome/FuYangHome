//
//  CustomIntroductionController.m
//  家居定制
//
//  Created by iKing on 2017/4/9.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CustomIntroductionController.h"

@interface CustomIntroductionController ()

@end

@implementation CustomIntroductionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订制说明";
    NSArray *array = @[@"100元为1分 不足100元不计分",
                       @"积分 会员级别 享受折扣" ,
                       @"50分 铜牌会员 9.8折",
                       @"100分 银牌会员 9.5折",
                       @"300分 金牌会员 9折",
                       @"500分 白金会员 8.8折",
                       @"800分 铂金会员 8.5折",
                       @"1200分 钻石会员 8折"];
    self.view.backgroundColor = UIColorFromRGB(0xebebeb);
    UILabel *label1 = [UILabel labelWithText:@"订制流程" textColor:UIColorFromRGB(0x4fd2c2) fontSize:17];
    [label1 sizeToFit];
    label1.left = 15;
    label1.top = 20;
    [self.view addSubview:label1];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(rateWidth(60), label1.bottom+25, kScreenWidth-rateWidth(60)*2, 100)];
    imageView.image = UIImageNamed(@"流程");
    [self.view addSubview:imageView];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, imageView.bottom+42, 22, 25)];
    imageView2.image = UIImageNamed(@"jinpai");
    [self.view addSubview:imageView2];
    
    UILabel *label2 = [UILabel labelWithText:@"会员制级别" textColor:UIColorFromRGB(0x4fd2c2) fontSize:17];
    [label2 sizeToFit];
    label2.left = imageView2.right+10;
    label2.centerY = imageView2.centerY;
    [self.view addSubview:label2];
    
    for (int i = 0; i < array.count; i ++) {
        UILabel *label = [UILabel labelWithText:array[i] textColor:UIColorFromRGB(0x808080) fontSize:15];
        [label sizeToFit];
        label.origin = CGPointMake(37.5, label2.bottom+26+i*(label.height+5));
        [self.view addSubview:label];
    }
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
