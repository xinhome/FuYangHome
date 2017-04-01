//
//  GoodsCommentView.h
//  家居定制
//
//  Created by iKing on 2017/3/31.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsCommentView;
@protocol GoodsCommentViewDelegate <NSObject>

- (void)goodsCommentView:(GoodsCommentView *)commentView didSelectIndex:(int)index;

@end

@interface GoodsCommentView : UIView
@property (nonatomic, weak) id<GoodsCommentViewDelegate> delegate;
@end
