//
//  HPPhotoBrowser.h
//  haipai
//
//  Created by Tom Yin on 2016/12/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HPPhotoBrowser;

@protocol HPPhotoBrowserDelegate <NSObject>

- (void)scrolledToPositionInBrowser:(HPPhotoBrowser *)browser position:(NSInteger)position;

@end

@interface HPPhotoBrowser : UIView

@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, strong) UIButton *support;

@property (nonatomic, weak) id<HPPhotoBrowserDelegate> delegate;

+ (instancetype)showFromImageView:(UIImageView *)imageView inView:(UIView *)view withURLStrings:(NSArray *)URLStrings atIndex:(NSInteger)index;

+ (instancetype)showFromImageView:(UIImageView *)imageView inView:(UIView *)view withURLStrings:(NSArray *)URLStrings placeholderImage:(UIImage *)image atIndex:(NSInteger)index;

@end
