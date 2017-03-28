//
//  OneViewController.m
//  TV
//
//  Created by HOME on 16/7/19.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "OneViewController.h"
#import "OneTableViewCell.h"
#import "MagazineModel.h"
//#import "JHChartHeader.h"
@interface OneViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGPoint _panLocation;
}
@property (nonatomic, strong) NSMutableArray<MagazineModel *> *dataSource;///<<#注释#>
@property (nonatomic, assign) int currentPage;///< <#注释#>
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadNewData];
    [self loadMoreData];
}

- (void)loadNewData {
    NSDictionary *parameters = @{
                                 @"page": @0,
                                 @"type": @0
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/getall" person:RequestPersonKaiKang parameters:parameters success:^(id successResponse) {
        NSArray *data = successResponse[@"data"];
        self.currentPage = 0;
        self.dataSource = [MagazineModel mj_objectArrayWithKeyValuesArray:data];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreData {
    self.currentPage ++;
    NSDictionary *parameters = @{
                                 @"page": @(self.currentPage)
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/getall" person:RequestPersonKaiKang parameters:parameters success:^(id successResponse) {
        NSArray *data = successResponse[@"data"];
        [self.dataSource addObjectsFromArray:[MagazineModel mj_objectArrayWithKeyValuesArray:data]];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
        self.currentPage --;
        [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark initUI
- (void)initUI
{
    [self creatTableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    self.tableView.separatorStyle = 0;
    self.navigationItem.title = @"所有杂志";
    [self.view bringSubviewToFront:_dingzhiBtn];
    _panLocation = CGPointMake(kScreenWidth-85+30, kScreenHeight-128);
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(tuozhuai:)];
    pan.maximumNumberOfTouches = 1;
    pan.minimumNumberOfTouches = 1;
    [_dingzhiBtn addGestureRecognizer:pan];

}
- (void)tuozhuai:(UIPanGestureRecognizer *)paramSender
{
    if (paramSender.state != UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed){
        //通过使用 locationInView 这个方法,来获取到手势的坐标
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        paramSender.view.center = location;
        _dingzhiBtn.center = location;
        _panLocation = location;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        _dingzhiBtn.center  = CGPointMake(_panLocation.x, kScreenHeight-10);
        _dingzhiBtn.alpha = 0;
        //        _dingzhiBtn.frame = CGRectMake(kScreenWidth-65, kScreenHeight-60, 0, 0);
    } completion:^(BOOL finished) {
        //        _dingzhiBtn.hidden = YES;
    }];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [UIView animateWithDuration:1 animations:^{
        //        _dingzhiBtn.hidden = NO;
        _dingzhiBtn.alpha = 1;
        //        _dingzhiBtn.center  = CGPointMake(kScreenWidth-85+30, kScreenHeight-128);
        _dingzhiBtn.center = _panLocation;
        
        //        _dingzhiBtn.frame = CGRectMake(kScreenWidth-65, kScreenHeight-130, 50, 50);
    }];
}



#pragma mark  UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneDetailViewController *controller = [[OneDetailViewController alloc] init];
    controller.model = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"OneCell"];
    if (!cell) {
        cell= [[OneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OneCell"];
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
    return 15+rateHeight(135)+15+16+3+40+5+40+5+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

@end
