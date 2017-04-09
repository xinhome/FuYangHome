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
        
        NSArray *titleArr = [[NSArray alloc] initWithObjects:@"全部", @"卧室",@"厨房",@"客厅",@"书房",@"阳台",@"卫浴",@"DIY", nil];
        NSArray *colorArr = [NSArray arrayWithObjects:RGB(237, 157, 153),RGB(218, 234, 181),RGB(223, 223, 221),RGB(173, 196, 233),RGB(180, 221, 201),RGB(246, 173, 185),RGB(186, 180, 212),RGB(168, 242, 225), nil];
        
        CGFloat width = kScreenWidth/titleArr.count;
        for (int i = 0; i < titleArr.count; i ++) {
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(i*width, 0, width, self.height)];
            [title whenTapped:^{
                [self.delegate sceneShow:self didSelectIndex:i];
            }];
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
