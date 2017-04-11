//
//  MyOrderViewController.m
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "MyOrderViewController.h"
#import "LiuXSegmentView.h"
#import "OrderDetailsViewController.h"
#import "JieSuanOrderViewController.h"
#import "OrderTableViewCell.h"
#import "PingJiaViewController.h"
#import "PingJiaDisplayViewController.h"
#import "ShoppingCarModel.h"

#define redColor  RGB(255, 56, 65)
@interface MyOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, assign) NSInteger segmentIndex;
@property (nonatomic, strong) NSMutableArray *orderArray;
@property (nonatomic, strong) NSMutableArray *orderArray00;

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackForUser];
    [self setNavigationBar];
    self.segmentIndex = 1;
    [self addSegment];
    self.tableView.hidden = YES;
    [self.view addSubview:self.myTableView];
    if (_segmentIndex == 1) {
        [self setUpDataWithState:@"0" url:@"/Order/showAllOrder"];
    } else if (_segmentIndex == 2) {
        [self setUpDataWithState:@"1" url:@"/Order/showCar"];
    } else if (_segmentIndex == 3) {
        [self setUpDataWithState:@"2" url:@"/Order/showCar"];
    } else {
        [self setUpDataWithState:@"3" url:@"/Order/showCar"];
    }

}
- (void)setNavigationBar
{
    self.navigationItem.title = @"我的订单";
    //    [self addRightItemWithImage:@"shanchu " action:nil];
}
#pragma mark - 分段选择
- (void)addSegment
{
    LiuXSegmentView *view=[[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) titles:@[@"全部",@"待发货",@"待收货",@"待评价"] bgColor:[UIColor whiteColor] clickBlick:^void(NSInteger index) {
        self.segmentIndex = index;
        if (index == 1) {
            [self setUpDataWithState:@"0" url:@"/Order/showAllOrder"];
        } else if (index == 2) {
            [self setUpDataWithState:@"1" url:@"/Order/showCar"];
        } else if (index == 3) {
            [self setUpDataWithState:@"2" url:@"/Order/showCar"];
        } else {
            [self setUpDataWithState:@"3" url:@"/Order/showCar"];
        }
    }];
    //以下属性可以根据需求修改
    view.titleFont = [UIFont boldSystemFontOfSize:16];
    view.defaultIndex = 1;
    view.titleNomalColor = RGB(74, 74, 74);
    view.titleSelectColor = redColor;
    [self.view addSubview:view];
}
#pragma mark - SetUpData
- (void)setUpDataWithState:(NSString *)state url:(NSString *)url
{
    [_orderArray removeAllObjects];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults valueForKey:@"myUserId"];
    NSLog(@"userId:%@", userId);
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:url person:RequestPersonWeiMing parameters:@{@"userId": userId,@"status": state} success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"订单-----%@", successResponse);
        if ([successResponse isSuccess]) {
            NSArray *orderArray = successResponse[@"data"];
            
            self.orderArray = [ShoppingCarModel mj_objectArrayWithKeyValuesArray:orderArray];
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
    //        return 1;
    //    } else if (self.segmentIndex == 2) {
    //        return 1;
    //    } else if (self.segmentIndex == 3) {
    //        return 1;
    //    } else {
    return 1;
    //    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    if (self.segmentIndex == 1) {
    return _orderArray.count;
    //    } else if (self.segmentIndex == 2) {
    //        return 1;
    //    } else if (self.segmentIndex == 3) {
    //        return 2;
    //    } else {
    //        return 4;
    //    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identififer = @"ordersCell";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identififer];
    if (cell == nil) {
        cell = [[OrderTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identififer];
    }
    cell.shouHouBtn.hidden = YES;
    cell.selectionStyle = NO;
    if (_orderArray.count != 0) {
        cell.cellModel = (ShoppingCarModel *)_orderArray[indexPath.section];
    }
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
    if (_orderArray.count != 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(40))];
        headerView.backgroundColor = [UIColor whiteColor];
        ShoppingCarModel *model = _orderArray[section];
        UILabel *orderNumLB = [UILabel labelWithText:[NSString stringWithFormat:@"订单编号：%@", model.orderId] textColor:UIColorFromRGB(0x666666) fontSize:14];
        [orderNumLB sizeToFit];
        [headerView addSubview:orderNumLB];
        [orderNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(rateWidth(20));
            make.centerY.equalTo(headerView);
        }];
        NSString *str;
        if ([model.status intValue] == 1) {
            str = @"待发货";
        } else if ([model.status intValue] == 2) {
            str = @"待收货";
        } else if ([model.status intValue] == 3) {
            str = @"待评价";
        } else {
            str = @"已完成";
        }
        UILabel *stateLB = [UILabel labelWithText:str textColor:RGB(242, 0, 0) fontSize:13];
        [headerView addSubview:stateLB];
        [stateLB sizeToFit];
        [stateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headerView).offset(-rateWidth(10));
            make.centerY.equalTo(orderNumLB);
        }];
        return headerView;
    } else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return rateHeight(100);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_orderArray.count != 0) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(80))];
        footerView.backgroundColor = [UIColor whiteColor];
        ShoppingCarModel *model = _orderArray[section];
        CGFloat sumPrice = [model.num intValue]*[model.price floatValue]-[model.amount floatValue];
        UILabel *priceLB = [UILabel labelWithText:[NSString stringWithFormat:@"共计：%.2f元（含0元运费）", sumPrice] textColor:UIColorFromRGB(0x666666) fontSize:15];
        [priceLB sizeToFit];
        [footerView addSubview:priceLB];
        [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footerView).offset(rateHeight(15));
            make.centerX.equalTo(footerView);
        }];
        
        NSString *btnTitle;
        if ([model.status intValue] == 1) {
            // 提醒发货
            btnTitle = @"待发货";
        } else if ([model.status intValue] == 2) {
            // 确认收货
            btnTitle = @"确认收货";
        } else if ([model.status intValue] == 3) {
            // 评价
            btnTitle = @"评价";
        } else {
            // 查看评价
            btnTitle = @"查看评价";
        }
        
        UIButton *shouhuoBtn = [UIButton buttonWithTitle:btnTitle fontSize:12 titleColor:RGB(105, 105, 105) background:[UIColor whiteColor] cornerRadius:4];
        shouhuoBtn.layer.borderWidth = 1;
        shouhuoBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        shouhuoBtn.tag = section;
        [footerView addSubview:shouhuoBtn];
        [shouhuoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(footerView).offset(-rateWidth(10));
            make.bottom.equalTo(footerView).offset(-rateHeight(30));
            make.size.mas_offset(CGSizeMake(rateWidth(60), rateHeight(20)));
        }];
        if ([model.status intValue] == 1) {
            // 提醒发货
            shouhuoBtn.enabled = NO;
        } else if ([model.status intValue] == 2) {
            // 确认收货
            [shouhuoBtn addTarget:self action:@selector(shouHuo:) forControlEvents:(UIControlEventTouchUpInside)];
        } else if ([model.status intValue] == 3) {
            // 评价
            [shouhuoBtn addTarget:self action:@selector(pingJia:) forControlEvents:(UIControlEventTouchUpInside)];
        } else {
            // 查看评价
            [shouhuoBtn addTarget:self action:@selector(chaKanPingJia:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xf7f7f7);
        [footerView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(footerView);
            make.left.equalTo(footerView);
            make.size.mas_offset(CGSizeMake(kScreenWidth, rateHeight(15)));
        }];
        return footerView;
    } else {
        return nil;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailsViewController *orderDetailVC = [[OrderDetailsViewController alloc] init];
    orderDetailVC.refreshAction = ^{
        if (_segmentIndex == 1) {
            [self setUpDataWithState:@"0" url:@"/Order/showAllOrder"];
        } else if (_segmentIndex == 2) {
            [self setUpDataWithState:@"1" url:@"/Order/showCar"];
        } else if (_segmentIndex == 3) {
            [self setUpDataWithState:@"2" url:@"/Order/showCar"];
        } else {
            [self setUpDataWithState:@"3" url:@"/Order/showCar"];
        }
    };
    ShoppingCarModel *model = (ShoppingCarModel *)_orderArray[indexPath.section];
    orderDetailVC.model = model;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}
// 评价
- (void)pingJia:(UIButton *)btn
{
    PingJiaViewController *pingJiaVC = [[PingJiaViewController alloc] init];
    ShoppingCarModel *model = (ShoppingCarModel *)_orderArray[btn.tag];
    pingJiaVC.model = model;
    pingJiaVC.refreshAction = ^{
        if (_segmentIndex == 1) {
            [self setUpDataWithState:@"0" url:@"/Order/showAllOrder"];
        } else if (_segmentIndex == 2) {
            [self setUpDataWithState:@"1" url:@"/Order/showCar"];
        } else if (_segmentIndex == 3) {
            [self setUpDataWithState:@"2" url:@"/Order/showCar"];
        } else {
            [self setUpDataWithState:@"3" url:@"/Order/showCar"];
        }
    };
    [self.navigationController pushViewController:pingJiaVC animated:YES];
}
// 查看评价
- (void)chaKanPingJia:(UIButton *)btn
{
    PingJiaDisplayViewController *pingJiaDisplayVC = [[PingJiaDisplayViewController alloc] init];
    ShoppingCarModel *model = (ShoppingCarModel *)_orderArray[btn.tag];
    pingJiaDisplayVC.model = model;
    [self.navigationController pushViewController:pingJiaDisplayVC animated:YES];
}
// 确认收货
- (void)shouHuo:(UIButton *)btn
{
    [MBProgressHUD showMessage:@"正在提交..." toView:self.view];
    ShoppingCarModel *model = (ShoppingCarModel *)_orderArray[btn.tag];
    NSString *url = [NSString stringWithFormat:@"%@Order/doTransfer?id=%@", WeiMingURL,model.goodsId];
    NSLog(@"url:%@", url);
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"确认收货：%@", responseObject);
        if ([responseObject[@"msg"] isEqualToString:@"OK"]) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showMessage:@"确认收货成功" toView:self.view];
            if (_segmentIndex == 1) {
                [self setUpDataWithState:@"0" url:@"/Order/showAllOrder"];
            } else if (_segmentIndex == 2) {
                [self setUpDataWithState:@"1" url:@"/Order/showCar"];
            } else if (_segmentIndex == 3) {
                [self setUpDataWithState:@"2" url:@"/Order/showCar"];
            } else {
                [self setUpDataWithState:@"3" url:@"/Order/showCar"];
            }
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"提交失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常"];
    }];
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
