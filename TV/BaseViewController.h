//
//  BaseViewController.h
//  TeaM
//
//  Created by 淇翔科技 on 16/4/13.
//  Copyright © 2016年 安鑫一家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UserUtil.h"

@interface UIViewController (basicViewController)

- (void)addBack;
- (void)addBackToRootViewController;
- (void)addRightItemWithTitle:(NSString *)title action:(SEL)action;
- (void)addRightItemWithImage:(NSString *)imageName action:(SEL)action;
- (void)addLeftItemWithImage:(NSString *)imageName action:(SEL)action;
- (void)showHUDInView:(UIView *)view;
@end

//#import "ZFNavigationController.h"
@interface BaseViewController : UIViewController <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) User *user;///<<#注释#>
- (void)pushViewController:(UIViewController *)vc animation:(BOOL)animation;
- (void)popViewController;
//创建全屏的表
- (void)creatTableView;
- (void)blueTitle;

- (void)addBackForUser;

@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UIButton *leftBtn,*rightBtn;
//键盘下落
- (void)keyboardDown:(UITextField *)tf;
//nav标题名称
@property(nonatomic,strong)UILabel *titleLable;
- (void)MainView;
@property(nonatomic,copy)UIView *bgview;
////有搜索框
//- (void)titleView;
- (void)navTitleView;
- (void)MainView1;
@property(nonatomic,retain)UITextField *mainTF;

@end


