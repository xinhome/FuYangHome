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
#import "ReturnGoodsTableViewCell.h"
#define redColor  RGB(255, 56, 65)
@interface MyOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, assign) NSInteger segmentIndex;

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    self.segmentIndex = 1;
    [self addSegment];
    self.tableView.hidden = YES;
    [self.view addSubview:self.myTableView];
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
         self.segmentIndex = index;
         [_myTableView reloadData];
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults valueForKey:@"myUserId"];
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/Order/showAllOrder" person:RequestPersonWeiMing parameters:@{@"userId": userId,@"status": @0} success:^(id successResponse) {
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentIndex == 1) {
        return 2;
    } else if (self.segmentIndex == 2) {
        return 4;
    } else if (self.segmentIndex == 3) {
        return 3;
    } else {
        return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.segmentIndex == 1) {
        return 3;
    } else if (self.segmentIndex == 2) {
        return 1;
    } else if (self.segmentIndex == 3) {
        return 2;
    } else {
        return 4;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identififer = @"ordersCell";
    ReturnGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identififer];
    if (cell == nil) {
        cell = [[ReturnGoodsTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identififer];
    }
    cell.shouHouBtn.hidden = YES;
    cell.selectionStyle = NO;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rateHeight(95);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return rateHeight(40);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(40))];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *orderNumLB = [UILabel labelWithText:@"订单编号：111111111" textColor:UIColorFromRGB(0x666666) fontSize:14];
    [orderNumLB sizeToFit];
    [headerView addSubview:orderNumLB];
    [orderNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(rateWidth(20));
        make.centerY.equalTo(headerView);
    }];
    UILabel *stateLB = [UILabel labelWithText:@"交易成功" textColor:RGB(242, 0, 0) fontSize:13];
    [headerView addSubview:stateLB];
    [stateLB sizeToFit];
    [stateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).offset(-rateWidth(10));
        make.centerY.equalTo(orderNumLB);
    }];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
        return rateHeight(100);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(80))];
        footerView.backgroundColor = [UIColor whiteColor];
        UILabel *priceLB = [UILabel labelWithText:@"共计：68元（含10元运费）" textColor:UIColorFromRGB(0x666666) fontSize:15];
        [priceLB sizeToFit];
        [footerView addSubview:priceLB];
        [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footerView).offset(rateHeight(15));
            make.centerX.equalTo(footerView);
        }];
        
        UIButton *shouhuoBtn = [UIButton buttonWithTitle:@"删除" fontSize:12 titleColor:RGB(105, 105, 105) background:[UIColor whiteColor] cornerRadius:4];
        shouhuoBtn.layer.borderWidth = 1;
        shouhuoBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [footerView addSubview:shouhuoBtn];
        [shouhuoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(footerView).offset(-rateWidth(10));
            make.bottom.equalTo(footerView).offset(-rateHeight(30));
            make.size.mas_offset(CGSizeMake(rateWidth(60), rateHeight(20)));
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xf7f7f7);
        [footerView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(footerView);
            make.left.equalTo(footerView);
            make.size.mas_offset(CGSizeMake(kScreenWidth, rateHeight(15)));
        }];
        return footerView;
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
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight-110) style:(UITableViewStyleGrouped)];
        _myTableView.backgroundColor = RGB(247, 247, 247);
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = NO;
    }
    return _myTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
