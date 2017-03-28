//
//  ScrollLayout.m
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ScrollLayout.h"

@implementation ScrollLayout

- (void)prepareLayout {
    [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerY = self.collectionView.contentOffset.y+self.collectionView.height * 0.5;
    
//    NSLog(@"%f", self.collectionView.contentOffset.y);
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        
//        CGFloat attrCenterX = attrs.center.x;
//        CGFloat attrCenterY = attrs.center.y;
//        NSLog(@"%f", attrCenterY);
        CGFloat delta = ABS(attrs.center.y - centerY);
        
        CGFloat scaleX = 1 - delta / self.collectionView.height;

        attrs.transform = CGAffineTransformMakeScale(scaleX, 1.0);
        
        attrs.center = CGPointMake(attrs.center.x*scaleX, attrs.center.y);
//        
//        attrs.zIndex = 1-scaleX;
    }
    
    return array;
}

@end
