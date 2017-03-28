//
//  ButtonInPost.m
//  家居定制
//
//  Created by iKing on 2017/3/17.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ButtonInPost.h"

@interface ButtonInPost ()
@property (nonatomic, weak) CAShapeLayer *shaperLayer;///<<#注释#>
@end

@implementation ButtonInPost
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(self.width, self.height)];
        [path addLineToPoint:CGPointMake(self.width, self.height/3*2)];
        [path addLineToPoint:CGPointMake(self.width-self.height/3, self.height)];
        [path closePath];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.hidden = YES;
        self.shaperLayer = layer;
        layer.fillColor = [RGB(68, 202, 181) CGColor];
        layer.strokeColor = [[UIColor clearColor] CGColor];
        layer.frame = self.bounds;
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.shaperLayer.hidden = !selected;
}

- (void)drawRect:(CGRect)rect {
    
}
@end
