//
//  ThereDetailViewController.h
//  TV
//
//  Created by HOME on 16/9/14.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "BaseViewController.h"

@interface ThereDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *userHeaf;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIButton *fasongBtnClick;
@property (weak, nonatomic) IBOutlet UIView *userView;
@property (weak, nonatomic) IBOutlet UILabel *nikeNameLable;
@property (weak, nonatomic) IBOutlet UIView *dianzanView;
- (IBAction)commentBtnClick:(id)sender;

@property (nonatomic,assign)int isMyself;//1---是  2--不是；


@end
