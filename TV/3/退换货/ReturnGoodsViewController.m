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
    self.segmentIndex = 1;
    [self addSegment];
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
            NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"status == 3 || status == 4"];
            NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[searchPredicate]];
            self.showReturnGoodsArray = [self.returnGoodsArray filteredArrayUsingPredicate:predicate].mutableCopy;
        } else {
            NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"status == 5 || status == 6 || status == 7"];
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
//        NSLog(@"可退货列表-----%@", successResponse);
        if ([successResponse isSuccess]) {
            NSArray *orderArray = successResponse[@"data"];
            self.returnGoodsArray = [NSMutableArray array];
            for (NSDictionary *dic in orderArray) {
                ShoppingCarModel *model = [[ShoppingCarModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [_returnGoodsArray addObject:model];
            }
            NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"status == 3 || status == 4"];
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
    if (self.segmentIndex == 2) {
        cell.shouHouBtn.hidden = YES;
    } else {
        if (_showReturnGoodsArray.count != 0) {
            cell.shouHouBtn.hidden = NO;
            cell.cellModel = (ShoppingCarModel *)_showReturnGoodsArray[indexPath.section];
        }
    }
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
    if (self.segmentIndex == 1) {
        return rateHeight(60);
    } else {
        return rateHeight(80);
    }
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
        if (self.segmentIndex == 1) {
            UIView *line = [UIView new];
            line.backgroundColor = UIColorFromRGB(0xf2f2f2);
            [footerView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(footerView);
                make.left.equalTo(footerView);
                make.size.mas_offset(CGSizeMake(kScreenWidth, rateHeight(5)));
            }];
        } else {
            UIImageView *segmentImg = [UIImageView new];
            if ([model.status intValue] == 7) {
                segmentImg.image = [UIImage imageNamed:@"已完成"];
            } else {
                segmentImg.image = [UIImage imageNamed:@"审核中"];
            }
            [segmentImg sizeToFit];
            [footerView addSubview:segmentImg];
            [segmentImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(footerView).offset(-rateWidth(20));
                make.bottom.equalTo(footerView).offset(-rateHeight(10));
            }];
            UIView *line = [UIView new];
            line.backgroundColor = UIColorFromRGB(0xf2f2f2);
            [footerView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(footerView);
                make.left.equalTo(footerView);
                make.size.mas_offset(CGSizeMake(kScreenWidth, rateHeight(5)));
            }];
        }
        return footerView;
    } else {
        return nil;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentIndex == 1) {
        ReturnGoodsDetaildsViewController *detailsVC = [[ReturnGoodsDetaildsViewController alloc] init];
        ShoppingCarModel *model = (ShoppingCarModel *)_showReturnGoodsArray[indexPath.section];
        detailsVC.model = model;
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
}
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight-110) style:(UITableViewStyleGrouped)];
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
