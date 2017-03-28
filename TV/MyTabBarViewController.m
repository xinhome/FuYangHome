//
//  MyTabBarViewController.m
//  TeaM
//
//  Created by 淇翔科技 on 16/4/12.
//  Copyright © 2016年 安鑫一家. All rights reserved.
//

#import "MyTabBarViewController.h"

#import "Common.h"
#import "MainViewController.h"
//#import "LeftViewController.h"

#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThereViewController.h"
#import "MainViewController.h"
#import "MyViewController.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSubCtrls];
    
    [self.tabBar setBackgroundImage:[UIImage createImageWithColor:UIColorWhite]];
}
//加载控制器
-(void)loadSubCtrls{
    //初始化子控制器
    //首页
    MainViewController *check = [[MainViewController alloc]init];

    [self setUpOneChildViewController:check image: [UIImage imageNamed:@"shouye2"] selectedImg:[UIImage imageNamed:@"shouye1"] title:@"首页"];
    //消息
    OneViewController*recover = [[OneViewController alloc]init];
     self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [self setUpOneChildViewController:recover image: [UIImage imageNamed:@"changjing1"] selectedImg:[UIImage imageNamed:@"changjing2"] title:@"杂志"];
    
    //点评
    TwoViewController*find = [[TwoViewController alloc]init];
    [self setUpOneChildViewController:find image: [UIImage imageNamed:@"fabu1"] selectedImg:[UIImage imageNamed:@"fabu2"] title:@"发布"];
    //我
    ThereViewController*my = [[ThereViewController alloc]init];
    [self setUpOneChildViewController:my image: [UIImage imageNamed:@"shequ1"] selectedImg:[UIImage imageNamed:@"shequ2"] title:@"社区"];
    
    MyViewController*my1 = [[MyViewController alloc]init];
    [self setUpOneChildViewController:my1 image: [UIImage imageNamed:@"geren1"] selectedImg:[UIImage imageNamed:@"geren2"] title:@"我的"];
    
    self.tabBar.tintColor = RGB(17, 131, 49);
}
- (void)setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image selectedImg:(UIImage*)selectedImg title:(NSString *)title{
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:viewController];
        
        
    navC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:[selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
        [self addChildViewController:navC];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
