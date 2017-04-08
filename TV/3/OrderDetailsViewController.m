//
//  OrderDetailsViewController.m
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "ReturnGoodsTableViewCell.h"
#import "PingJiaViewController.h"
#import "PingJiaDisplayViewController.h"
#import "OrderSecondView.h"

@interface OrderDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation OrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的订单";
    self.view.backgroundColor = RGB(242, 242, 242);
    [self.view addSubview:self.myTableView];
    
//    UIButton *btn = [UIButton buttonWithTitle:@"" fontSize:13 titleColor:[UIColor blackColor] background:[UIColor yellowColor] cornerRadius:1];
//    btn.frame = CGRectMake(100, 100, 100, 100);
//    [self.view addSubview:btn];
//    [btn addActionHandler:^{
//        [self.navigationController popViewControllerAnimated:YES];
//        self.refreshAction();
//    }];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ReturnGoodsTableViewCell *cell = [[ReturnGoodsTableViewCell alloc] init];
        cell.shouHouBtn.hidden = YES;
        cell.cellModel = _model;
        cell.selectionStyle = NO;
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        OrderSecondView *orderSecondView = [[OrderSecondView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(48))];
        orderSecondView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:orderSecondView];
        NSString *str;
        if ([_model.status intValue] == 1) {
            str = @"待发货";
        } else if ([_model.status intValue] == 2) {
            str = @"待收货";
        } else {
            str = @"已收货";
        }
        if (indexPath.section == 1) {
            orderSecondView.firstLB.text = @"快递公司：";
            orderSecondView.secondLB.text = _model.shippingName;
        } else if (indexPath.section == 2) {
            orderSecondView.firstLB.text = @"快递单号：";
            orderSecondView.secondLB.text = _model.shippingCode;
        } else if (indexPath.section == 3) {
            orderSecondView.firstLB.text = @"状态：";
            orderSecondView.secondLB.text = str;
        }
        cell.selectionStyle = NO;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return rateHeight(95);
    } else {
        return rateHeight(48);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return rateHeight(40);
    } else {
        return 0.01;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(40))];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *orderNumLB = [UILabel labelWithText:[NSString stringWithFormat:@"订单编号：%@", _model.orderId] textColor:UIColorFromRGB(0x666666) fontSize:14];
        [orderNumLB sizeToFit];
        [headerView addSubview:orderNumLB];
        [orderNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(rateWidth(20));
            make.centerY.equalTo(headerView);
        }];
        NSString *str;
        if ([_model.status intValue] == 1) {
            str = @"待发货";
        } else if ([_model.status intValue] == 2) {
            str = @"待收货";
        } else if ([_model.status intValue] == 3) {
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
    if (section == 0) {
        return rateHeight(100);
    } else {
        return rateHeight(8);
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(80))];
        footerView.backgroundColor = [UIColor whiteColor];
        CGFloat sumPrice = [_model.num intValue]*[_model.price floatValue];
        UILabel *priceLB = [UILabel labelWithText:[NSString stringWithFormat:@"共计：%.2f元（含0元运费）", sumPrice] textColor:UIColorFromRGB(0x666666) fontSize:15];
        [priceLB sizeToFit];
        [footerView addSubview:priceLB];
        [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footerView).offset(rateHeight(15));
            make.centerX.equalTo(footerView);
        }];
        
        NSString *btnStr;
        if ([_model.status intValue] == 1) {
            btnStr = @"待发货";
        } else if ([_model.status intValue] == 2) {
            btnStr = @"确认收货";
        } else if ([_model.status intValue] == 3) {
            btnStr = @"评价";
        } else {
            btnStr = @"查看评价";
        }
        UIButton *shouhuoBtn = [UIButton buttonWithTitle:btnStr fontSize:12 titleColor:RGB(105, 105, 105) background:[UIColor whiteColor] cornerRadius:4];
        shouhuoBtn.layer.borderWidth = 1;
        shouhuoBtn.layer.borderColor = RGB(183, 233, 225).CGColor;
        [footerView addSubview:shouhuoBtn];
        [shouhuoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(footerView).offset(-rateWidth(10));
            make.bottom.equalTo(footerView).offset(-rateHeight(30));
            make.size.mas_offset(CGSizeMake(rateWidth(65), rateHeight(25)));
        }];
        if ([_model.status intValue] == 1) {
            // 提醒发货
            shouhuoBtn.enabled = NO;
        } else if ([_model.status intValue] == 2) {
            // 确认收货
            [shouhuoBtn addTarget:self action:@selector(shouHuo:) forControlEvents:(UIControlEventTouchUpInside)];
        } else if ([_model.status intValue] == 3) {
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
// 评价
- (void)pingJia:(UIButton *)btn
{
    PingJiaViewController *pingJiaVC = [[PingJiaViewController alloc] init];
    pingJiaVC.model = _model;
    pingJiaVC.refreshAction = self.refreshAction;
    [self.navigationController pushViewController:pingJiaVC animated:YES];
}
// 查看评价
- (void)chaKanPingJia:(UIButton *)btn
{
    PingJiaDisplayViewController *pingJiaDisplayVC = [[PingJiaDisplayViewController alloc] init];
    pingJiaDisplayVC.model = self.model;
    [self.navigationController pushViewController:pingJiaDisplayVC animated:YES];
}
// 确认收货
- (void)shouHuo:(UIButton *)btn
{
    [MBProgressHUD showMessage:@"正在提交..." toView:self.view];
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:@"%@Order/doTransfer?id=%@", WeiMingURL,_model.goodsId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"确认收货：%@", responseObject);
        if ([responseObject[@"msg"] isEqualToString:@"OK"]) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showMessage:@"确认收货成功" toView:self.view];
            self.refreshAction();
            [self.navigationController popViewControllerAnimated:YES];
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
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStyleGrouped)];
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
