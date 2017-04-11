//
//  BaseViewController.m
//  TeaM
//
//  Created by 淇翔科技 on 16/4/13.
//  Copyright © 2016年 安鑫一家. All rights reserved.
//

#import "BaseViewController.h"
#import "Common.h"
@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        Class vc1 = NSClassFromString(@"MainViewController");
        Class vc2  = NSClassFromString(@"OneViewController");
        Class vc3 = NSClassFromString(@"TwoViewController");
        Class vc4 = NSClassFromString(@"ThereViewController");
        Class vc5 = NSClassFromString(@"MyViewController");
        if ([self isKindOfClass:[vc1 class]] || [self isKindOfClass:[vc2 class]]||[self isKindOfClass:[vc3 class]]||[self isKindOfClass:[vc4 class]]||[self isKindOfClass:[vc5 class]]) {
            self.hidesBottomBarWhenPushed = NO;
        }else{
            self.hidesBottomBarWhenPushed = YES;
        }
    }
    return self;
}
- (void)pushViewController:(UIViewController *)vc animation:(BOOL)animation {
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[UserUtil shareInstance] takeoutUser]) {
        self.user = [[UserUtil shareInstance] takeoutUser];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = huiseColor;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    if (self.navigationController.childViewControllers.count > 1) {
        [self addBack];
    }
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
    
}

- (void)keyboardDown:(UITextField *)tf
{
    [tf resignFirstResponder];
}
- (void)creatTableView{
    
    //创建tableview
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.bounces = NO;
    [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    _tableView.backgroundColor = huiseColor;
    self.tableView.separatorStyle = 0;
    //藏滚动条
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tableView];
//    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)] ;
//    oneTap.delegate = self;
//    [self.tableView addGestureRecognizer:oneTap];

}
- (void)hideKeyBoard
{
    
}
#pragma mark MainView
- (void)MainView
{
    
    _bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    _bgview.backgroundColor = huiseColor;
    
    _mainTF = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, 5, 200, 30)];
    _mainTF.textColor = RGB(218, 218, 218);
    _mainTF.font = [UIFont systemFontOfSize:13];
    [_bgview addSubview:_mainTF];
    
    
    
   UILabel*  lineLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-110, 35, 220, 1)];
    lineLable.backgroundColor =RGB(218, 218, 218);
    [_bgview addSubview:lineLable];
    
    UIButton  *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(kScreenWidth/2+80, 8, 25, 25);
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
    [_bgview addSubview:searchBtn];
    
    
    [self.view addSubview: _bgview];
    self.tableView.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeight-44);
 

}
- (void)MainView1
{
    
    _bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 66)];
    _bgview.backgroundColor = huiseColor;
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*0.3, 20, kScreenWidth*0.4, 44)];
        //    _titleLable.text = @"路况悬赏";
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor =RGB(60, 60, 60);
    _titleLable.font = [UIFont systemFontOfSize:18];
    [_bgview addSubview:_titleLable];
    
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(0, 20, 44, 44);
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"blackBack"] forState:UIControlStateNormal];
    
    [_leftBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_bgview addSubview:_leftBtn];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(kScreenWidth-50, 20, 44, 44);
    [_bgview addSubview:_rightBtn];
    _rightBtn.hidden = YES;
   
    
    
    UILabel*  lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 2)];
    lineLable.backgroundColor =RGB(231, 231, 231);
    [_bgview addSubview:lineLable];
    [self.view addSubview: _bgview];
    
    self.tableView.frame = CGRectMake(0, 46, kScreenWidth, kScreenHeight-46);
}
- (void)blueTitle
{
    self.bgview.backgroundColor = RGB(53, 202, 169);
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"backBlue"] forState:UIControlStateNormal];
    self.titleLable.textColor = [UIColor whiteColor];
}
- (void)addBackForUser {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonBack:self imageName:@"user-back" action:@selector(backAction)];
}
- (void)navTitleView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
//    view.backgroundColor = lanse;
    //    标题、
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*0.3, 20, kScreenWidth*0.4, 44)];
    //    _titleLable.text = @"路况悬赏";
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor =[UIColor whiteColor];
    _titleLable.font = [UIFont systemFontOfSize:20];
    [view addSubview:_titleLable];
    //    返回按钮
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(0, 20, 44, 44);
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [_leftBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
   
    [view addSubview:_leftBtn];
    
    
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(kScreenWidth-50, 20, 44, 44);
//    [_rightBtn setImage:[UIImage imageNamed:@"cemianbiao"] forState:UIControlStateNormal];
    //    btn.backgroundColor = [UIColor greenColor];
//    [_rightBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_rightBtn];
    
    
    
    
    [self.view addSubview: view];
    self.tableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
}
- (void)titleBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)titleView
{
    self.tableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 84)];
    view.backgroundColor = RGB(241, 71, 54);
    //    标题、
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*0.3, 0, kScreenWidth*0.4, 44)];
    //    _titleLable.text = @"路况悬赏";
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor =[UIColor whiteColor];
    _titleLable.font = [UIFont systemFontOfSize:15];
    [view addSubview:_titleLable];
    //    返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 28, 13, 18);
    [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    //    搜索框
    UIImageView *searchImage =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*0.15,50, kScreenWidth*0.7,25)];
    searchImage.image = [UIImage imageNamed:@"shenghuo"];
    searchImage.userInteractionEnabled = YES;
    
    [view addSubview:searchImage];
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(35, 0, kScreenWidth*0.7-22, 20)];
    tf.font = [UIFont systemFontOfSize:15];
    tf.tag = 1111;
    [searchImage addSubview:tf];
    
    [self.view addSubview: view];
}

@end

@implementation UIViewController (basicViewController)

char HTTPRequest = '0';

- (void)addBack {
    UIBarButtonItem *backItem = [UIBarButtonItem barButtonBack:self imageName:@"nav_back" action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)addBackToRootViewController {
    UIBarButtonItem *backItem = [UIBarButtonItem barButtonBack:self imageName:@"back" action:@selector(backToRootViewController)];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)addLeftItemWithImage:(NSString *)imageName action:(SEL)action {
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonLeft:self imageName:imageName acton:action];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)addRightItemWithImage:(NSString *)imageName action:(SEL)action {
    UIBarButtonItem *item = [UIBarButtonItem barButtonLeft:self imageName:imageName acton:action];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)addRightItemWithTitle:(NSString *)title action:(SEL)action{
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonRight:self title:title action:action];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backToRootViewController {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)setHUD:(UIView *)HUD {
    objc_setAssociatedObject(self, &HTTPRequest, HUD, OBJC_ASSOCIATION_RETAIN);
}
- (void)showHUDInView:(UIView *)view {
    [self setHUD:[[UIView alloc] init]];
}

@end
