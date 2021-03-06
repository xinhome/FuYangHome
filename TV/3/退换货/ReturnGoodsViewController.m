//
//  ReturnGoodsViewController.m
//  家居定制
//
//  Created by iking on 2017/3/25.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ReturnGoodsViewController.h"
#import "LiuXSegmentView.h"
#import "ReturnGoodsTableViewCell.h"
#import "ReturnGoodsDetaildsViewController.h"
#import "ReturnGoodsListViewController.h"

@interface ReturnGoodsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, assign) NSInteger segmentIndex;
@property (nonatomic, strong) NSMutableArray *returnGoodsArray;
@property (nonatomic, strong) NSMutableArray *showReturnGoodsArray;

@end

@implementation ReturnGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"退换货";
    [self addBackForUser];
    self.segmentIndex = 1;
//    [self addSegment];
    [self.view addSubview:self.myTableView];
    self.showReturnGoodsArray = [NSMutableArray array];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpData];
}
#pragma mark - 分段选择
- (void)addSegment
{
    LiuXSegmentView *view=[[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) titles:@[@"售后申请",@"进度查询"] bgColor:UIColorFromRGB(0xf2f2f2) clickBlick:^void(NSInteger index) {
        self.segmentIndex = index;
        [self.showReturnGoodsArray removeAllObjects];
        if (index == 1) {
            NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"status == 4 || status == 5"];
            NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[searchPredicate]];
            self.showReturnGoodsArray = [self.returnGoodsArray filteredArrayUsingPredicate:predicate].mutableCopy;
        } else {
            NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"status == 5 || status == 6"];
            NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[searchPredicate]];
            self.showReturnGoodsArray = [self.returnGoodsArray filteredArrayUsingPredicate:predicate].mutableCopy;
        }
        [_myTableView reloadData];
    }];
    //以下属性可以根据需求修改
    view.titleFont = [UIFont boldSystemFontOfSize:16];
    view.defaultIndex = 1;
    view.titleNomalColor = UIColorFromRGB(0x4d4d4d);
    view.titleSelectColor = UIColorFromRGB(0xff0000);
    [self.view addSubview:view];
}
#pragma mark - setUpData
- (void)setUpData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults valueForKey:@"myUserId"];
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/Order/showAllOrder" person:RequestPersonWeiMing parameters:@{@"userId": userId,@"status": @0} success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"可退货列表-----%@", successResponse);
        if ([successResponse isSuccess]) {
            NSArray *orderArray = successResponse[@"data"];
            self.returnGoodsArray = [NSMutableArray array];
            self.returnGoodsArray = [ShoppingCarModel mj_objectArrayWithKeyValuesArray:orderArray];
            NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"status == 4 || status == 5 || status == 6"];
            NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[searchPredicate]];
            self.showReturnGoodsArray = [self.returnGoodsArray filteredArrayUsingPredicate:predicate].mutableCopy;
            [_myTableView reloadData];
            
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
//    if (self.segmentIndex == 1) {
//        return 2;
//    } else {
//        return 1;
//    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.segmentIndex == 1) {
        return _showReturnGoodsArray.count;
    } else {
        return _showReturnGoodsArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identififer = @"returnGoodsCell";
    ReturnGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identififer];
    if (cell == nil) {
        cell = [[ReturnGoodsTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identififer];
    }

        if (_showReturnGoodsArray.count != 0) {
            cell.shouHouBtn.hidden = YES;

            cell.cellModel = (ShoppingCarModel *)_showReturnGoodsArray[indexPath.section];
        }

    cell.selectionStyle = NO;
    return cell;
}
#pragma mark - 退货订单列表详情
- (void)actionList:(UIButton *)btn
{
    ReturnGoodsListViewController *returnListVC = [[ReturnGoodsListViewController alloc] init];
    ShoppingCarModel *model = (ShoppingCarModel *)_showReturnGoodsArray[btn.tag];
    returnListVC.model = model;
    [self.navigationController pushViewController:returnListVC animated:YES];
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
    if (_showReturnGoodsArray.count != 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(40))];
        headerView.backgroundColor = [UIColor whiteColor];
        ShoppingCarModel *model = (ShoppingCarModel *)_showReturnGoodsArray[section];
        UILabel *orderNumLB = [UILabel labelWithText:[NSString stringWithFormat:@"订单编号：%@", model.orderId] textColor:UIColorFromRGB(0x666666) fontSize:14];
        [orderNumLB sizeToFit];
        [headerView addSubview:orderNumLB];
        [orderNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(rateWidth(20));
            make.centerY.equalTo(headerView);
        }];
        return headerView;
    } else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (self.segmentIndex == 1) {
//        return rateHeight(60);
//    } else {
        return rateHeight(80);
//    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_showReturnGoodsArray.count != 0) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(60))];
        footerView.backgroundColor = [UIColor whiteColor];
        ShoppingCarModel *model = (ShoppingCarModel *)_returnGoodsArray[section];
        CGFloat sumPrice = [model.num intValue]*[model.price floatValue];
        UILabel *priceLB = [UILabel labelWithText:[NSString stringWithFormat:@"共计：%.2f元（含0元运费）", sumPrice] textColor:UIColorFromRGB(0x666666) fontSize:15];
        [priceLB sizeToFit];
        [footerView addSubview:priceLB];
        [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footerView).offset(rateHeight(15));
            make.centerX.equalTo(footerView);
        }];
        UIButton *btn1 = [UIButton buttonWithTitle:@"进度查询" fontSize:12 titleColor:UIColorFromRGB(0x4fd2c2) background:[UIColor clearColor] cornerRadius:4];
        btn1.layer.masksToBounds = YES;
        btn1.layer.borderColor = UIColorFromRGB(0x4fd2c2).CGColor;
        btn1.layer.borderWidth = 1;
        [footerView addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(footerView).offset(-rateWidth(20));
            make.bottom.equalTo(footerView).offset(-rateHeight(10));
            make.size.mas_offset(CGSizeMake(rateWidth(70), rateHeight(24)));
        }];
        btn1.tag = section;
        [btn1 addTarget:self action:@selector(actionList:) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIButton *btn2 = [UIButton buttonWithTitle:@"申请售后" fontSize:12 titleColor:UIColorFromRGB(0x4fd2c2) background:[UIColor clearColor] cornerRadius:4];
        btn2.layer.masksToBounds = YES;
        btn2.layer.borderColor = UIColorFromRGB(0x4fd2c2).CGColor;
        btn2.layer.borderWidth = 1;
        [footerView addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(btn1.mas_left).offset(-rateWidth(10));
            make.bottom.equalTo(footerView).offset(-rateHeight(10));
            make.size.mas_offset(CGSizeMake(rateWidth(70), rateHeight(24)));
        }];
        btn2.tag = section;
        [btn2 addTarget:self action:@selector(shenQingShouHou:) forControlEvents:(UIControlEventTouchUpInside)];


            UIView *line = [UIView new];
            line.backgroundColor = UIColorFromRGB(0xf2f2f2);
            [footerView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(footerView);
                make.left.equalTo(footerView);
                make.size.mas_offset(CGSizeMake(kScreenWidth, rateHeight(5)));
            }];

        return footerView;
    } else {
        return nil;
    }
}
- (void)shenQingShouHou:(UIButton *)btn
{
    if (_showReturnGoodsArray.count != 0) {
        ShoppingCarModel *model = (ShoppingCarModel *)_showReturnGoodsArray[btn.tag];
        if ([model.num intValue] > 0) {
            ReturnGoodsDetaildsViewController *detailsVC = [[ReturnGoodsDetaildsViewController alloc] init];
            detailsVC.model = model;
            [self.navigationController pushViewController:detailsVC animated:YES];
        } else {
            [MBProgressHUD showError:@"商品数量为0不能退货"];
        }
    }
}
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStyleGrouped)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = NO;
    }
    return _myTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
