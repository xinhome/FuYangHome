//
//  CouponViewController.m
//  家居定制
//
//  Created by iKing on 2017/4/6.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CouponViewController.h"
#import "LiuXSegmentView.h"
#import "CouponCell.h"

#define kOrangeColor UIColorFromRGB(0xffc332)
#define kGrayColor RGB(204, 204, 204)

@interface CouponViewController ()

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSMutableArray<CouponModel *> *couponArray; // 未过期
@property (nonatomic, strong) NSMutableArray *outTimeArray; // 过期

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠券";
    [self setupUI];
    self.index = 1;
    [self setUpData];
    NSLog(@"--%@", [self getCurrentTime]);
}
- (void)setUpData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults valueForKey:@"myUserId"];
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/coupons/ById" person:RequestPersonWeiMing parameters:@{@"userId": userId} success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"优惠券-----%@", successResponse);
        if ([successResponse isSuccess]) {
            NSArray *dataArray = successResponse[@"data"];
            if (dataArray.count != 0) {
                self.couponArray = [NSMutableArray array];
                self.outTimeArray = [NSMutableArray array];
                for (NSDictionary *dic in dataArray) {
                    CouponModel *model = [[CouponModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    // 比较日期
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
                    NSDate *date1 = [dateFormatter dateFromString:[model.stopTime substringToIndex:10]];
                    if ([self compareOneDay:date1 withAnotherDay:[self getCurrentTime]] == -1) {
                        // 过期
                        [_outTimeArray addObject:model];
                    } else {
                        // 未过期
                        [_couponArray addObject:model];
                    }
                }
                [self.tableView reloadData];
            }

        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常"];
    }];
}
- (void)setupUI {
    LiuXSegmentView *segmentView = [[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) titles:@[@"未使用", @"已过期"] bgColor:UIColorFromRGB(0xf7f7f7) clickBlick:^(NSInteger index) {
        self.index = index;
        [self.tableView reloadData];
    }];
    segmentView.titleNomalColor = UIColorFromRGB(0x666666);
    segmentView.titleSelectColor = UIColorFromRGB(0x4fd2c2);
    segmentView.titleFont = [UIFont systemFontOfSize:16];
    [self.view addSubview:segmentView];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, segmentView.bottom, kScreenWidth, kScreenHeight-50-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.tableView registerClass:[CouponCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_index == 1) {
        return _couponArray.count;
    } else {
        return _outTimeArray.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (_couponArray.count != 0) {
        
        if (self.index == 1) {
            cell.bgImg.image = [UIImage imageNamed:@"立即使用"];
            cell.label.textColor = kOrangeColor;
            cell.moneyLB.textColor = kOrangeColor;
            cell.conditionLB.textColor = kOrangeColor;
            if (_couponArray.count != 0) {
                cell.cellModel = (CouponModel *)_couponArray[indexPath.section];
            }
            [cell.bgImg whenTapped:^{
                self.couponMoney(self.couponArray[indexPath.section]);
                [self popViewController];
            }];
        } else {
            cell.bgImg.image = [UIImage imageNamed:@"youhuiquanguoqi"];
            cell.label.textColor = kGrayColor;
            cell.moneyLB.textColor = kGrayColor;
            cell.conditionLB.textColor = kGrayColor;
            if (_outTimeArray.count != 0) {
                cell.cellModel = (CouponModel *)_outTimeArray[indexPath.section];
            }
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rateHeight(95);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return rateHeight(18);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
// 获取当前时间
- (NSDate *)getCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    return date;
}
// 比较日期大小
- (NSComparisonResult)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    return [dateA compare:dateB];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
