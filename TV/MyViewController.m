//
//  MyViewController.m
//  TV
//
//  Created by HOME on 16/8/22.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "MyViewController.h"
#import "userTableViewCell.h"
#import "AboutViewController.h"
#import "UserHeaderView.h"
#import "MyOrderViewController.h"
#import "ShoppingCartViewController.h"
#import "MyTieZiViewController.h"
#import "MyZiLiaoViewController.h"
#import "ReturnGoodsViewController.h"
#import "CouponViewController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *titleArray,*titleImageArray;
@property (nonatomic, weak) UserHeaderView *headerView;///<<#注释#>
@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:RGB(68, 202, 181)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.headerView.avatar sd_setImageWithURL:[NSURL URLWithString:self.user.avatar]];
    self.headerView.nickname.text = self.user.nickname;
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    [self initUI];
}
- (void)loadData {
    NSArray *status = @[@"0",@"123456",@"456"];
    NSLog(@"%@",@{@"userId": self.user.ID,@"status":[status mj_JSONString]});
    [[HttpRequestManager shareManager] addPOSTURL:@"/Order/OrderNum" person:RequestPersonWeiMing parameters:@{@"userId": self.user.ID, @"status":status} success:^(id successResponse) {
        NSLog(@"%@", successResponse);
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)initUI
{
    [self creatTableView];
    self.tableView.separatorStyle = 0;
    
    _titleArray = [[NSArray alloc]initWithObjects:@"我的资料", @"我的优惠券" ,@"系统消息",@"关于我们",@"意见反馈",nil];
    _titleImageArray = [[NSArray alloc]initWithObjects:@"1",@"优惠券",@"2222",@"3",@"4",@"7",@"8",nil];
    //    self.tableView.scrollEnabled = NO;
    [self configHeaderView];
}

- (void)configHeaderView {
    UserHeaderView *headerView = [[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 190)];
    self.headerView = headerView;
    [headerView.avatar whenTapped:^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userId = [userDefaults valueForKey:@"myUserId"];
        if (userId.length == 0) {
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
        } else {
            MyZiLiaoViewController*zi = [[MyZiLiaoViewController alloc]init];
            [self.navigationController pushViewController:zi animated:YES];
        }
        
    }];
    // 我的帖子
    headerView.postAction = ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userId = [userDefaults valueForKey:@"myUserId"];
        if (userId.length == 0) {
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
        } else {
            [self tiezi];
        }
    };
    // 我的订单
    headerView.orderAction = ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userId = [userDefaults valueForKey:@"myUserId"];
        if (userId.length == 0) {
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
        } else {
            [self dingdan];
        }
    };
    // 购物车
    headerView.shopCarAction = ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userId = [userDefaults valueForKey:@"myUserId"];
        if (userId.length == 0) {
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
        } else {
            [self gouwuche];
        }
    };
    // 退换物
    headerView.goodsAction = ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userId = [userDefaults valueForKey:@"myUserId"];
        if (userId.length == 0) {
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
        } else {
            ReturnGoodsViewController *returnGoods = [[ReturnGoodsViewController alloc] init];
            [self.navigationController pushViewController:returnGoods animated:YES];
        }
    };
    self.tableView.tableHeaderView = headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    userTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"user1Cell"];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"userTableViewCell" owner:nil options:nil][0];
    }
    cell.selectionStyle = 0;
    cell.backgroundColor = [UIColor whiteColor];
    cell.image.image = [UIImage imageNamed:_titleImageArray[indexPath.row]];
    cell.lable.text = _titleArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *userId = [userDefaults valueForKey:@"myUserId"];
            if (userId.length == 0) {
                [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
            } else {
                MyZiLiaoViewController*zi = [[MyZiLiaoViewController alloc]init];
                [self.navigationController pushViewController:zi animated:YES];
            }
        }
            break;
        case 1:{
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *userId = [userDefaults valueForKey:@"myUserId"];
            if (userId.length == 0) {
                [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
            } else {
                [self pushViewController:[[CouponViewController alloc] init] animation:YES];
            }
        }
            break;
        case 2: {
            
            [self.navigationController pushViewController:[[SystemMsgViewController alloc] init] animated:YES];
        }
            break;
        case 3: {
            AboutViewController *zi = [[AboutViewController alloc]init];
            [self.navigationController pushViewController:zi animated:YES];
        }
            break;
        default: {
            YijianViewController *gfb =[[YijianViewController alloc]init];
            [self.navigationController pushViewController:gfb animated:YES];
        }
            break;
    }
}

- (void)tiezi
{
    MyTieZiViewController *ti=[[MyTieZiViewController alloc]init];
    [self.navigationController pushViewController:ti animated:YES];
}
- (void)dingdan
{
    MyOrderViewController *ti=[[MyOrderViewController alloc]init];
    [self.navigationController pushViewController:ti animated:YES];
}
- (void)gouwuche
{
    ShoppingCartViewController *ti=[[ShoppingCartViewController alloc]init];
    [self.navigationController pushViewController:ti animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight*0.08;
}


@end
