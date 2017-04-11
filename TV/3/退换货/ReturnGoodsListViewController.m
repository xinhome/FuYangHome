//
//  ReturnGoodsListViewController.m
//  家居定制
//
//  Created by iking on 2017/4/1.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ReturnGoodsListViewController.h"
#import "ReturnGoodsTableViewCell.h"

@interface ReturnGoodsListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *showReturnGoodsArray;

@end

@implementation ReturnGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"退货详情";
    [self addBackForUser];
    [self.view addSubview:self.myTableView];
    [self setUpData];
}
- (void)setUpData
{
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    NSDictionary *parameters = @{
                                 @"id": @([_model.goodsId intValue])
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@Order/showReturn", WeiMingURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"退货list：%@", responseObject);
        if ([responseObject[@"msg"] isEqualToString:@"OK"]) {
            self.showReturnGoodsArray = [NSMutableArray array];
            _showReturnGoodsArray = responseObject[@"data"];
            if (_showReturnGoodsArray.count == 0) {
                [MBProgressHUD showMessage:@"暂无退货申请" toView:self.view];
            }
            [_myTableView reloadData];
        } else {
            [MBProgressHUD showMessage:@"暂无退货申请" toView:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [MBProgressHUD showError:@"网络异常"];
    }];
}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _showReturnGoodsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identififer = @"returnGoodsCell";
    ReturnGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identififer];
    if (cell == nil) {
        cell = [[ReturnGoodsTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identififer];
    }
    cell.shouHouBtn.hidden = YES;
    cell.nameLB.text = _model.title;
    cell.priceLB.text = [NSString stringWithFormat:@"单价：￥%.2f", [_model.price floatValue]];
    cell.numLB.text = [NSString stringWithFormat:@"数量：%@件", _showReturnGoodsArray[indexPath.section][@"num"]];
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WeiMingURL,_model.picPath]];
    [cell.goodsImg sd_setImageWithURL:imgUrl];
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
        UILabel *orderNumLB = [UILabel labelWithText:[NSString stringWithFormat:@"订单编号：%@", _model.orderId] textColor:UIColorFromRGB(0x666666) fontSize:14];
        [orderNumLB sizeToFit];
        [headerView addSubview:orderNumLB];
        [orderNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(rateWidth(20));
            make.centerY.equalTo(headerView);
        }];
        return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return rateHeight(80);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_showReturnGoodsArray.count != 0) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(60))];
        footerView.backgroundColor = [UIColor whiteColor];
//        CGFloat sumPrice = [_model.num intValue]*[_model.price floatValue];
        UILabel *priceLB = [UILabel labelWithText:[NSString stringWithFormat:@"退货原因：%@", _showReturnGoodsArray[section][@"reason"]] textColor:UIColorFromRGB(0x666666) fontSize:15];
        [priceLB sizeToFit];
        [footerView addSubview:priceLB];
        [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footerView).offset(rateHeight(15));
            make.left.equalTo(footerView).offset(rateWidth(20));
        }];
        
        UIImageView *segmentImg = [UIImageView new];
        if ([_model.status intValue] == 6) {
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
        
        return footerView;
    } else {
        return nil;
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
