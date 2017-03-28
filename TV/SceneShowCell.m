//
//  SceneShowCell.m
//  家居定制
//
//  Created by iKing on 2017/3/21.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "SceneShowCell.h"

@implementation SceneShowCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(arc4random()%255, arc4random()%255, arc4random()%255);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
//        imageView.backgroundColor = RGB(arc4random()%255, arc4random()%255, arc4random()%255);
        [self.contentView addSubview:imageView];
    }
    return self;
}
@end
