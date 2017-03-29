//
//  CommentView.h
//  家居定制
//
//  Created by iKing on 2017/3/29.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseTextView.h"
@class CommentView;
@protocol CommentViewDelegate <NSObject>

- (void)sendContent:(CommentView *)commentView content:(NSString *)content;

@end
/// 评论的view
@interface CommentView : UIView<EaseTextViewDelegate>
@property (nonatomic, weak) EaseTextView *textView;///
- (void)show;
@property (nonatomic, weak) id<CommentViewDelegate> delegate;
@end
