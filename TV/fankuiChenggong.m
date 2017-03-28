//
//  fankuiChenggong.m
//  Tea
//
//  Created by HOME on 16/5/27.
//  Copyright © 2016年 安鑫一家. All rights reserved.
//

#import "fankuiChenggong.h"

@implementation fankuiChenggong

- (void)creatView{
    if (self) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.3;
        [self addSubview:view];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(20, kScreenHeight*0.5-180, kScreenWidth-40, 250)];
        image.userInteractionEnabled = YES;
        image.image = [UIImage imageNamed:@"fankuichenggong"];
        [self addSubview:image];
        
        
        _lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 135, kScreenWidth-40, 30)];
        
        _lab.textAlignment = NSTextAlignmentCenter;
        _lab.text = @"10s后自动跳转";
//        lab.backgroundColor = [UIColor yellowColor];
        [image addSubview:_lab];
        
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(kScreenWidth*0.5-20-80, 170, 160, 40);
        
        [image addSubview:_btn];
        
        
        UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)] ;
        oneTap.delegate = self;
        [view addGestureRecognizer:oneTap];
        
        
        
        
    }
    
}




-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
    
}
- (void)hideKeyBoard
{
//    self.hidden = YES;
//    
//    [self release];
    
}
- (void)nextvc
{
    
}
@end
