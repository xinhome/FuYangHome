//
//  CommentView.m
//  家居定制
//
//  Created by iKing on 2017/3/29.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CommentView.h"

@interface CommentView ()
@property (nonatomic, assign) CGFloat keyboardHeight;///< <#注释#>
@end

@implementation CommentView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self whenTapped:^{
            [self removeFromSuperview];
            [self.textView resignFirstResponder];
        }];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardHide:) name: UIKeyboardWillHideNotification object:nil];
        EaseTextView *textView = [[EaseTextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        textView.returnKeyType = UIReturnKeySend;
        self.textView = textView;
        textView.bottom = kScreenHeight;
        textView.delegate = self;
        textView.placeHolder = @"说点什么吧...";
        [self addSubview:textView];
    }
    return self;
}

#pragma mark - easeview delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self removeFromSuperview];
        [textView resignFirstResponder];
        return NO;
    }
    
    float height = [self heightForTextView:textView WithText:textView.text];
    if (height >= 130) {
        height = 130;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.textView.top = kScreenHeight-height - self.keyboardHeight;
        textView.height = height;
    } completion:nil];
    
    return YES;
}


#pragma mark - EaseTextView
- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    CGSize constraint = CGSizeMake(textView.contentSize.width , CGFLOAT_MAX);
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                        context:nil];
    float textHeight = size.size.height+22.0;
    return textHeight;
}
#pragma mark - 键盘出现函数
- (void)keyboardWasShown:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    CGFloat h = keyboardSize.height;
    self.keyboardHeight = h;
    self.textView.top = kScreenHeight-self.textView.height - h;
}

#pragma mark - 键盘关闭函数
-(void)keyboardHide:(NSNotification *)notif
{
    self.textView.bottom = kScreenHeight;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)show {
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    [self.textView becomeFirstResponder];
}

@end
