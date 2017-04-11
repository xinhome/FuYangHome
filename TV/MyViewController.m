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
    [self.headerView.avatar sd_setImageWithURL:[NSURL URLWithString:self.user.avatar] placeholderImage:UIImageNamed(@"Icon2")];
    self.headerView.nickname.text = self.user.nickname;
    
    
    if (self.user) {
        self.headerView.scoreLabel.text = [NSString stringWithFormat:@"%@分", self.user.credit];
    }
    [self loadData];
}

- (void)judgeGrade:(CGFloat)score {
    if (score < 50) {
        self.headerView.gradeLabel.text = @"普通会员";
    } else if (score>50&&score<100) { //铜牌
        self.headerView.gradeLabel.text = @"铜牌会员";
        self.headerView.gradeImageView.image = UIImageNamed(@"tongpai");
    } else if (score < 300) {// 银牌
        self.headerView.gradeLabel.text = @"银牌会员";
        self.headerView.gradeImageView.image = UIImageNamed(@"yinpai");
    } else if (score < 500) { //金牌
        self.headerView.gradeLabel.text = @"金牌会员";
        self.headerView.gradeImageView.image = UIImageNamed(@"jinpai");
    } else if (score < 800) { // 白金
        self.headerView.gradeLabel.text = @"白金会员";
        self.headerView.gradeImageView.image = UIImageNamed(@"白金");
    } else if (score < 1200) { // 铂金
        self.headerView.gradeLabel.text = @"铂金会员";
        self.headerView.gradeImageView.image = UIImageNamed(@"铂金");
    } else { // 钻石
        self.headerView.gradeLabel.text = @"钻石会员";
        self.headerView.gradeImageView.image = UIImageNamed(@"钻石");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    [self initUI];
}
- (void)loadData {
    if (self.user == nil) {
        return;
    }
    [[HttpRequestManager shareManager] addPOSTURL:@"/Order/OrderNum" person:RequestPersonWeiMing parameters:@{@"userId": self.user.ID} success:^(id successResponse) {
        NSLog(@"%@", successResponse);
        self.headerView.invitation.text = [NSString stringWithFormat:@"%@", successResponse[@"data"][@"count1"]];
        self.headerView.order.text = [NSString stringWithFormat:@"%@", successResponse[@"data"][@"count2"]];
        self.headerView.shopCar.text = [NSString stringWithFormat:@"%@", successResponse[@"data"][@"count3"]];
        self.headerView.goodsLabel.text = [NSString stringWithFormat:@"%@", successResponse[@"data"][@"count4"]];
        CGFloat credit = [successResponse[@"data"][@"credit"] floatValue];
        [self judgeGrade:credit];
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)initUI
{
    [self creatTableView];
    self.tableView.separatorStyle = 0;
    
    _titleArray = [[NSArray alloc]initWithObjects:@"我的资料", @"我的优惠券" ,@"系统消息",@"关于我们",@"意见反馈",@"退出登录",nil];
    _titleImageArray = [[NSArray alloc]initWithObjects:@"1",@"优惠券",@"2222",@"3",@"4",@"logout",nil];
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
        case 4: {
            YijianViewController *gfb =[[YijianViewController alloc]init];
            [self.navigationController pushViewController:gfb animated:YES];
            break;
        }
        default: {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出登录" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myUserId"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
                self.headerView.invitation.text = nil;
                self.headerView.order.text = nil;
                self.headerView.shopCar.text = nil;
                self.headerView.goodsLabel.text = nil;
                self.headerView.avatar.image = UIImageNamed(@"Icon2");
                self.headerView.nickname.text = nil;
                self.headerView.gradeLabel.text = nil;
                self.headerView.gradeImageView.image = nil;
                self.headerView.scoreLabel.text = nil;
                self.user = nil;
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
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
