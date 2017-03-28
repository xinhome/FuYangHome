//
//  UIView+customerView.h
//  haipai
//
//  Created by Tom Yin on 2016/12/9.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchedButtonBlock)();

@interface UIView (customerView)

@end

@interface UIFont (custom)
+ (UIFont *)YPFontWithSize:(CGFloat)fontSize;
@end

@interface UILabel (customerView)

+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize;

@end

@interface UIButton (customerView)

+ (UIButton *)buttonWithTitle:(NSString *)title
                     fontSize:(CGFloat)fontSize
                   titleColor:(UIColor *)titleColor
                   background:(UIColor *)background
                 cornerRadius:(CGFloat)cornerRadius;
- (void)addActionHandler:(TouchedButtonBlock)block;

@end

@interface UIBarButtonItem (customerView)

+ (UIBarButtonItem *)barButtonBack:(id)target imageName:(NSString *)imageName action:(SEL)action;

+ (UIBarButtonItem *)barButtonLeft:(id)target imageName:(NSString *)imageName acton:(SEL)action;

+ (UIBarButtonItem *)barButtonRight:(id)target title:(NSString *)title action:(SEL)action;

@end

@interface UITextField (customerView)

+ (UITextField *)textFieldLoginWithPlaceholder:(NSString *)placeholder;
+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder fontSize:(CGFloat)fontSize;

@end

@interface UIImage (customerView)

- (UIImage *)clipImageInRect:(CGRect)rect;

@end
