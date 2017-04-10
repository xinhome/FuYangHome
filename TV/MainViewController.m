//
//  MainViewController.m
//  TV
//
//  Created by HOME on 16/7/19.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "MainViewController.h"
#import "main1TableViewCell.h"
#import "main2TableViewCell.h"
#import "SDCycleScrollView.h"
#import "ShowSceneViewController.h"
#import "Main5TableViewCell.h"
#import "HomeContentModel.h"
#import "HomeCell.h"
#import "MagazineModel.h"
#import "OneDetailViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource, SDCycleScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray * images;
@property (nonatomic, strong) NSMutableArray<HomeContentModel *> *dataSource;///<<#注释#>
@property (nonatomic, strong) SDCycleScrollView *cycleView;///<<#注释#>
@property (nonatomic, strong) NSMutableArray<MagazineModel *> *magazines;///<<#注释#>
@property (nonatomic, assign) int currentPage;///< <#注释#>
@end

@implementation MainViewController
-(NSMutableArray*)images
{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:UIColorWhite] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    self.tableView.height = kScreenHeight-64-49;
    [self addRightItemWithImage:@"sousuo2" action:@selector(rightRight)];
    self.navigationItem.title = @"富阳家具";
    [self.tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self configHeaderView];
    [self loadData];
}

- (void)loadData {
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/Content/list" person:RequestPersonYuChuan parameters:@{@"type": @0, @"page": @1} success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
//        NSLog(@"%@", successResponse);
        [self.tableView.mj_header endRefreshing];
        if ([successResponse isSuccess]) {
            NSArray *data = successResponse[@"data"];
            self.dataSource = [HomeContentModel mj_objectArrayWithKeyValuesArray:data];
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常"];
    }];
    
    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/getall" person:RequestPersonWeiMing parameters:@{@"page":@0,@"type":@0} success:^(id successResponse) {
        [self.tableView.mj_header endRefreshing];
        NSArray *data = successResponse;
        self.magazines = [MagazineModel mj_objectArrayWithKeyValuesArray:data];
        
        NSInteger count = self.magazines.count;
        if (count > 5) {
            count = 5;
        }
        NSMutableArray *urls = [NSMutableArray array];
        for (int i = 0; i < count; i ++) {
            [urls addObject:[NSString stringWithFormat:@"%@%@", WEIMING, [self.magazines[i].magazineUrlContent componentsSeparatedByString:@","].firstObject]];
        }
        self.cycleView.imageURLStringsGroup = urls;
    } fail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@", error);
    }];
}

- (void)rightRight
{
    SearchViewController *search = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}

- (void)configHeaderView {
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(150)) delegate:self placeholderImage:nil];
    self.cycleView = cycleView;
    cycleView.currentPageDotColor = RGB(82, 182, 157);
    self.tableView.tableHeaderView = cycleView;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    OneDetailViewController *controller = [[OneDetailViewController alloc] init];
    controller.model = self.magazines[index];
    [self pushViewController:controller animation:YES];
    NSLog(@"%ld", index);
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
    //return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.section];
    [cell.moreImageView whenTapped:^{
        ShowSceneViewController *controller = [[ShowSceneViewController alloc] init];
        controller.model = self.dataSource[indexPath.section];
        [self pushViewController:controller animation:YES];
    }];
    [cell.backgroundImageView whenTapped:^{
        ChangJingViewController *controller = [[ChangJingViewController alloc] init];
        controller.model = self.dataSource[indexPath.section];
        [self pushViewController:controller animation:YES];
    }];
    cell.itemTapped = ^(NSNumber *item){
        NSLog(@"%@", item);
        ProductDetailController *controller = [[ProductDetailController alloc] init];
        controller.itemID = self.dataSource[indexPath.section].items[[item intValue]].ID;
        [self pushViewController:controller animation:YES];
    };
    return cell;
}
#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rateHeight(150)+rateHeight(150)*2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *sectionTitle = [UILabel labelWithText:@"" textColor:RGB(213, 213, 213) fontSize:13];
    sectionTitle.text = self.dataSource[section].title;
    [sectionTitle sizeToFit];
    sectionTitle.center = view.center;
    [view addSubview:sectionTitle];
    
    UILabel *leftLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rateWidth(85), 1)];
    leftLine.backgroundColor = RGB(188, 223, 215);
    leftLine.right = sectionTitle.left-15;
    leftLine.centerY = view.centerY;
    [view addSubview:leftLine];
    
    UILabel *rightLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rateWidth(85), 1)];
    rightLine.backgroundColor = RGB(188, 223, 215);
    rightLine.left = sectionTitle.right+15;
    rightLine.centerY = view.centerY;
    [view addSubview:rightLine];
    return view;
}

@end
