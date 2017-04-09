//
//  SceneShowView.h
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SceneShowView;
@protocol SceneShowViewDelegate <NSObject>

- (void)sceneShow:(SceneShowView *)view didSelectIndex:(NSInteger)index;

@end

/// 场景展示上面的view
@interface SceneShowView : UIView
@property (nonatomic, assign) BOOL packup;///< 是否收起
@property (nonatomic, weak) id<SceneShowViewDelegate> delegate;///<<#注释#>
@end
