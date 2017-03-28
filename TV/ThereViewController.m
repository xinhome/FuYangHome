//
//  ThereViewController.m
//  TV
//
//  Created by HOME on 16/7/19.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "ThereViewController.h"
#import "thereTableViewCell.h"
#import "ThereDetailViewController.h"
#import "ThereModel.h"
@interface ThereViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray<ThereModel *> *dataSource;///<<#注释#>
@end

@implementation ThereViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"社区";
    [self initUI];
    [self loadChooseBtn];
    [self loadNewData];
}
- (void)loadNewData {
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    NSDictionary *parameters = @{
                                 @"page": @0,
                                 @"type": @1
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/getall" person:RequestPersonKaiKang parameters:parameters success:^(id successResponse) {
        NSLog(@"%@", successResponse);
        [MBProgressHUD hideHUDForView:self.view];
        if ([successResponse isSuccess]) {
            NSArray *data = successResponse[@"data"];
            for (NSDictionary *dict in data) {
                [self.dataSource addObject:[[ThereModel alloc] initWithDictionary:dict]];
            }
            
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络错误"];
    }];
}

- (void)loadChooseBtn
{
     [self.zuixinBtn setTitleColor:RGB(100, 216, 170) forState:UIControlStateNormal];
    NSArray *titleArr = [[NSArray alloc]initWithObjects:@"全部",@"卧室",@"厨房",@"客厅",@"书房",@"阳台",@"卫浴",@"DIY", nil];
    NSArray *colorArr = [NSArray arrayWithObjects:RGB(247, 174, 170),RGB(218, 234, 181),RGB(223, 223, 221),RGB(173, 196, 233),RGB(180, 221, 201),RGB(246, 173, 185),RGB(186, 180, 212),RGB(168, 242, 225), nil];
    
    float wight = (kScreenWidth-10)/titleArr.count;
    for (int i=0; i<titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i==0) {
            btn.frame = CGRectMake(0, 120, wight+10, 30);
        }else
        {
            btn.frame = CGRectMake(10+wight*i, 120, wight, 30);
        }

        [btn setBackgroundColor:colorArr[i]];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:btn];
    }
}
#pragma mark initUI
- (void)initUI
{
    [self creatTableView];
    self.tableView.separatorStyle = 0;
    self.tableView.frame = CGRectMake(0, 150, kScreenWidth, kScreenHeight-150-kTabBarHeight);
}

#pragma mark cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    thereTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"thereCell"];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"thereTableViewCell" owner:nil options:nil][0];
    }
    
    cell.model = self.dataSource[indexPath.row];
    
    cell.selectionStyle = 0;
    
    return cell;
}

#pragma mark numberOf
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark  height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ThereDetailViewController *detail = [[ThereDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
- (IBAction)zuixinBtnClick:(id)sender {
    [self.zuixinBtn setTitleColor:RGB(100, 216, 170) forState:UIControlStateNormal];
    [self.tuijianBnt setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
}
- (IBAction)tuijianBtnClick:(id)sender {
    [self.tuijianBnt setTitleColor:RGB(100, 216, 170) forState:UIControlStateNormal];
    [self.zuixinBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
}
- (NSMutableArray<ThereModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
