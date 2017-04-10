//
//  MainHeaderView.m
//  家居定制
//
//  Created by iKing on 2017/4/10.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "MainHeaderView.h"

@implementation MainHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        uicollectionview
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds];
        [self addSubview:collectionView];
    }
    return self;
}

@end
