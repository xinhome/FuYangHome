//
//  MyOrderViewController.m
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "MyOrderViewController.h"
#import "LiuXSegmentView.h"
#import "OrderTableViewCell.h"
#import "OrderDetailsViewController.h"
#import "JieSuanOrderViewController.h"
#define redColor  RGB(255, 56, 65)
@interface MyOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    [self addSegment];
    self.tableView.hidden = YES;
    [self.view addSubview:self.myTableView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpData];
}

- (void)setNavigationBar
{
    self.navigationItem.title = @"我的订单";
    [self addRightItemWithImage:@"shanchu " action:nil];
}
#pragma mark - 分段选择
- (void)addSegment
{
    LiuXSegmentView *view=[[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) titles:@[@"全部",@"待发货",@"待收货",@"待评价"] bgColor:[UIColor whiteColor] clickBlick:^void(NSInteger index) {
        //        self.segment = index;
        //        [self selectData];
    }];
    //以下属性可以根据需求修改
    view.titleFont = [UIFont boldSystemFontOfSize:16];
    view.defaultIndex = 1;
    view.titleNomalColor = RGB(74, 74, 74);
    view.titleSelectColor = redColor;
    [self.view addSubview:view];
}
#pragma mark - SetUpData
- (void)setUpData
{
    NSLog(@"----------%@", self.user.ID);
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/Order/showAllOrder" person:RequestPersonWeiMing parameters:@{@"userId": self.user.ID,@"status": @0} success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"订单-----%@", successResponse);
        if ([successResponse isSuccess]) {
            
            
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常"];
    }];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"orderCell";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OrderTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.selectionStyle = NO;
    cell.deleteBtn.tag = indexPath.section;
    [cell.deleteBtn addTarget:self action:@selector(deleteOrder:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rateHeight(205);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        return rateHeight(18);
    } else {
        return 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailsViewController *orderDetailVC = [[OrderDetailsViewController alloc] init];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}
#pragma mark - deleteOrder
- (void)deleteOrder:(UIButton *)btn
{
    NSLog(@"删除订单");
}

- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight-110) style:(UITableViewStylePlain)];
        _myTableView.backgroundColor = RGB(247, 247, 247);
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
    }
    return _myTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
