//
//  GoodsCommentView.m
//  家居定制
//
//  Created by iKing on 2017/3/31.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "GoodsCommentView.h"

@interface GoodsCommentView ()
@property (nonatomic, strong) NSMutableArray *labels;///<<#注释#>
@end

@implementation GoodsCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorWhite;
        self.labels = [NSMutableArray array];
        UILabel *all = [UILabel labelWithText:@"全部\n(100)" textColor:UIColorFromRGB(0x4d4d4d) fontSize:16];
        all.numberOfLines = 0;
        all.highlighted = YES;
        all.userInteractionEnabled = YES;
        [all addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        all.frame = CGRectMake(0, 0, kScreenWidth/5, self.height);
        all.highlightedTextColor = UIColorFromRGB(0xfe3102);
        all.textAlignment = NSTextAlignmentCenter;
        [self addSubview:all];
        UILabel *goodComment = [UILabel labelWithText:@"好评\n(100)" textColor:UIColorFromRGB(0x4d4d4d) fontSize:16];
        goodComment.numberOfLines = 0;
        goodComment.userInteractionEnabled = YES;
        [goodComment addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        goodComment.frame = CGRectMake(all.right, 0, kScreenWidth/5, self.height);
        goodComment.highlightedTextColor = UIColorFromRGB(0xfe3102);
        goodComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:goodComment];
        UILabel *midComment = [UILabel labelWithText:@"中评\n(100)" textColor:UIColorFromRGB(0x4d4d4d) fontSize:16];
        midComment.numberOfLines = 0;
        midComment.userInteractionEnabled = YES;
        [midComment addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        midComment.frame = CGRectMake(goodComment.right, 0, kScreenWidth/5, self.height);
        midComment.highlightedTextColor = UIColorFromRGB(0xfe3102);
        midComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:midComment];
        UILabel *lastComment = [UILabel labelWithText:@"差评\n(100)" textColor:UIColorFromRGB(0x4d4d4d) fontSize:16];
        lastComment.numberOfLines = 0;
        lastComment.userInteractionEnabled = YES;
        [lastComment addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        lastComment.frame = CGRectMake(midComment.right, 0, kScreenWidth/5, self.height);
        lastComment.highlightedTextColor = UIColorFromRGB(0xfe3102);
        lastComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lastComment];
        UILabel *picture = [UILabel labelWithText:@"有图\n(100)" textColor:UIColorFromRGB(0x4d4d4d) fontSize:16];
        picture.numberOfLines = 0;
        picture.userInteractionEnabled = YES;
        [picture addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        picture.frame = CGRectMake(lastComment.right, 0, kScreenWidth/5, self.height);
        picture.highlightedTextColor = UIColorFromRGB(0xfe3102);
        picture.textAlignment = NSTextAlignmentCenter;
        [self addSubview:picture];
        all.tag = self.labels.count;
        [self.labels addObject:all];
        goodComment.tag = self.labels.count;
        [self.labels addObject:goodComment];
        midComment.tag = self.labels.count;
        [self.labels addObject:midComment];
        lastComment.tag = self.labels.count;
        [self.labels addObject:lastComment];
        picture.tag = self.labels.count;
        [self.labels addObject:picture];
    }
    return self;
}
- (void)tapAction:(UITapGestureRecognizer *)tap {
    UILabel *lbl = (UILabel *)[tap view];
    for (UILabel *label in self.labels) {
        if (lbl == label) {
            [self.delegate goodsCommentView:self didSelectIndex:label.tag];
            label.highlighted = YES;
        } else {
            label.highlighted = NO;
        }
    }
}

@end
