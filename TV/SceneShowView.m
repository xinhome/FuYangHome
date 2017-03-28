//
//  SceneShowView.m
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "SceneShowView.h"

@implementation SceneShowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        UIButton *btn = [UIButton buttonWithTitle:@"全部" fontSize:14 titleColor:UIColorBlack background:RGB(237, 157, 153) cornerRadius:0];
        [btn setFrame:CGRectMake(0, 0, 60, self.height)];
        [self addSubview:btn];
        
        [btn addActionHandler:^{
            self.packup = !self.packup;
            if (self.packup) {
                self.width = 60;
            } else {
                self.width = kScreenWidth;
            }
        }];
        
        NSArray *titleArr = [[NSArray alloc] initWithObjects:@"卧室",@"厨房",@"客厅",@"书房",@"阳台",@"卫浴",@"DIY", nil];
        NSArray *colorArr = [NSArray arrayWithObjects:RGB(218, 234, 181),RGB(223, 223, 221),RGB(173, 196, 233),RGB(180, 221, 201),RGB(246, 173, 185),RGB(186, 180, 212),RGB(168, 242, 225), nil];
        
        CGFloat width = (kScreenWidth-60)/titleArr.count;
        for (int i = 0; i < titleArr.count; i ++) {
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(60+i*width, 0, width, self.height)];
            title.font = [UIFont systemFontOfSize:14];
            title.textColor = UIColorBlack;
            title.textAlignment = NSTextAlignmentCenter;
            title.text = titleArr[i];
            title.backgroundColor = colorArr[i];
            [self addSubview:title];
        }
    }
    return self;
}

@end
