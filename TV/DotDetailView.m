//
//  DotDetailView.m
//  家居定制
//
//  Created by iKing on 2017/4/6.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "DotDetailView.h"

@implementation DotDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        CAShapeLayer *shaperLayer = [CAShapeLayer layer];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(5, 0)];
        [path addLineToPoint:CGPointMake(self.width-5, 0)];
        [path addArcWithCenter:CGPointMake(self.width-5, 5) radius:5 startAngle:M_PI_2*3 endAngle:0 clockwise:YES];
        [path addLineToPoint:CGPointMake(self.width, self.height-11)];
        [path addArcWithCenter:CGPointMake(self.width-5, self.height-11) radius:5 startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [path addLineToPoint:CGPointMake(self.centerX+6, self.height-6)];
        [path addLineToPoint:CGPointMake(self.centerX, self.height)];
        [path addLineToPoint:CGPointMake(self.centerX-6, self.height-6)];
        [path addLineToPoint:CGPointMake(5, self.height-6)];
        [path addArcWithCenter:CGPointMake(5, self.height-11) radius:5 startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [path addLineToPoint:CGPointMake(0, 5)];
        [path addArcWithCenter:CGPointMake(5, 5) radius:5 startAngle:M_PI endAngle:M_PI_2*3 clockwise:YES];
        [path closePath];
        shaperLayer.fillColor = [RGBA(146, 146, 143, 0.9) CGColor];
        shaperLayer.path = path.CGPath;
        [self.layer addSublayer:shaperLayer];
        
        UILabel *name = [UILabel labelWithText:@"U型椅" textColor:UIColorWhite fontSize:16];
        name.frame = CGRectMake(0, 10, self.width, 16);
        name.textAlignment = NSTextAlignmentCenter;
        [self addSubview:name];
        
        UILabel *price = [UILabel labelWithText:@"￥125" textColor:UIColorWhite fontSize:16];
        price.frame = CGRectMake(0, name.bottom+10, self.width, 16);
        price.textAlignment = NSTextAlignmentCenter;
        [self addSubview:price];
        
        _name = name;
        _price = price;
    }
    return self;
}

@end
