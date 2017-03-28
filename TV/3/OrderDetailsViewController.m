//
//  OrderDetailsViewController.m
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "ReturnGoodsTableViewCell.h"

@interface OrderDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation OrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的订单";
    self.view.backgroundColor = RGB(242, 242, 242);
    [self.view addSubview:self.myTableView];
}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
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
        cell.selectionStyle = NO;
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        NSArray *array1 = @[@"快递公司：", @"快递单号：", @"状态："];
        NSArray *array2 = @[@"顺丰快递", @"111111111", @"已发货"];
        for (int i = 0; i < 3; i++) {
            OrderSecondView *item = [[OrderSecondView alloc] initWithFrame:cell.contentView.frame];
            item.backgroundColor = [UIColor whiteColor];
            item.firstLB.text = array1[indexPath.section-1];
            item.secondLB.text = array2[indexPath.section-1];
            [cell.contentView addSubview:item];
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
        UILabel *priceLB = [UILabel labelWithText:@"共计：68元（含10元运费）" textColor:UIColorFromRGB(0x666666) fontSize:15];
        [priceLB sizeToFit];
        [footerView addSubview:priceLB];
        [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footerView).offset(rateHeight(15));
            make.centerX.equalTo(footerView);
        }];
        
        UIButton *shouhuoBtn = [UIButton buttonWithTitle:@"确认收货" fontSize:12 titleColor:RGB(105, 105, 105) background:[UIColor whiteColor] cornerRadius:4];
        shouhuoBtn.layer.borderWidth = 1;
        shouhuoBtn.layer.borderColor = RGB(183, 233, 225).CGColor;
        [footerView addSubview:shouhuoBtn];
        [shouhuoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(footerView).offset(-rateWidth(10));
            make.bottom.equalTo(footerView).offset(-rateHeight(30));
            make.size.mas_offset(CGSizeMake(rateWidth(65), rateHeight(25)));
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
    } else {
        return nil;
    }
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
