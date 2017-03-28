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

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *titleArray,*titleImageArray;
@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:RGB(68, 202, 181)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    [self initUI];
}

- (void)initUI
{
    [self creatTableView];
    self.tableView.separatorStyle = 0;
    
    _titleArray = [[NSArray alloc]initWithObjects:@"我的资料",@"系统消息",@"关于我们",@"意见反馈",nil];
    _titleImageArray = [[NSArray alloc]initWithObjects:@"1",@"2222",@"3",@"4",@"7",@"8",nil];
    //    self.tableView.scrollEnabled = NO;
    [self configHeaderView];
}

- (void)configHeaderView {
    UserHeaderView *headerView = [[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 190)];
    [headerView.avatar whenTapped:^{
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
    }];
    // 我的帖子
    headerView.postAction = ^{
        [self tiezi];
    };
    // 我的订单
    headerView.orderAction = ^{
        [self dingdan];
    };
    // 购物车
    headerView.shopCarAction = ^{
        [self gouwuche];
    };
    // 退换物
    headerView.goodsAction = ^{
        ReturnGoodsViewController *returnGoods = [[ReturnGoodsViewController alloc] init];
        [self.navigationController pushViewController:returnGoods animated:YES];
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
            //我的资料
            //            ziliaoViewController*zi = [[ziliaoViewController alloc]init];
            MyZiLiaoViewController*zi = [[MyZiLiaoViewController alloc]init];
            [self.navigationController pushViewController:zi animated:YES];
        }
            break;
        case 1: {
            
            [self.navigationController pushViewController:[[SystemMsgViewController alloc] init] animated:YES];
        }
            break;
        case 2: {
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
    //    if (section == 0) {
    //        return 0.01;
    //    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.section == 0) {
    //        return 180;
    //    }
    return kScreenHeight*0.08;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    if (section == 0) {
    //        return nil;
    //    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
    view.backgroundColor = RGB(224, 224, 224);
    return view;
}

@end
