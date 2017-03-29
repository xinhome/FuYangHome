
//
//  JieSuanOrderViewController.m
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "JieSuanOrderViewController.h"
#import "OrderFirstView.h"
#import "JieSuanView.h"
#import "JieSuanListTableViewCell.h"
#import "ReturnGoodsTableViewCell.h"

@interface JieSuanOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation JieSuanOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"结算";
    self.view.backgroundColor = RGB(242, 242, 242);
    [self.view addSubview:self.myTableView];
    [self setUpUI];
}
- (void)setUpUI
{
    UIButton *tiJiaoBtn = [UIButton buttonWithTitle:@"提交订单" fontSize:16 titleColor:[UIColor whiteColor] background:RGB(102, 209, 191) cornerRadius:6];
    [self.view addSubview:tiJiaoBtn];
    [tiJiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-rateHeight(30));
        make.centerX.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(rateWidth(230), rateHeight(50)));
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 3;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(260))];
        view1.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [UIImageView new];
        img.image = [UIImage imageNamed:@"矩形 7"];
        [view1 addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view1);
            make.top.equalTo(view1).offset(rateHeight(15));
            make.size.mas_offset(CGSizeMake(kScreenWidth-rateWidth(30), rateHeight(180)));
        }];
        [self.view addSubview:view1];
        
        NSArray *array = @[@"联系方式：",@"收货人："];
        NSArray *array1 = @[@"022-213124234",@"李先生"];
        for (int i = 0; i < 2; i++) {
            JieSuanView *view = [JieSuanView new];
            [img addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(img);
                make.right.equalTo(img);
                make.bottom.equalTo(img).offset(-rateHeight(50)*i);
                make.height.equalTo(@(rateHeight(50)));
            }];
            view.firstLB.text = array[i];
            view.secondLB.text = array1[i];
        }
        
        UILabel *dizhi = [UILabel labelWithText:@"收货地址：" textColor:RGB(156, 156, 156) fontSize:15];
        [dizhi sizeToFit];
        [view1 addSubview:dizhi];
        [dizhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img).offset(rateHeight(20));
            make.left.equalTo(img).offset(rateWidth(20));
        }];
        UILabel *dizhi1 = [UILabel labelWithText:@"天津市河西区富力中心大厦B座21层2101" textColor:RGB(156, 156, 156) fontSize:15];
        dizhi1.numberOfLines = 0;
        [view1 addSubview:dizhi1];
        [dizhi1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img).offset(rateHeight(20));
            make.left.equalTo(dizhi.mas_right);
            make.width.equalTo(@(rateWidth(225)));
        }];
        UIButton *xiuGaiBtn = [UIButton buttonWithTitle:@"修改" fontSize:15 titleColor:RGB(79, 79, 79) background:[UIColor whiteColor] cornerRadius:4];
        xiuGaiBtn.layer.borderWidth = 1;
        xiuGaiBtn.layer.borderColor = RGB(117, 223, 214).CGColor;
        [view1 addSubview:xiuGaiBtn];
        [xiuGaiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(img);
            make.bottom.equalTo(view1).offset(-rateHeight(10));
            make.size.mas_offset(CGSizeMake(rateWidth(75), rateHeight(37)));
        }];
        [cell.contentView addSubview:view1];
        return cell;
    } else {
        static NSString *identifier = @"cellone";
        ReturnGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ReturnGoodsTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        cell.selectionStyle = NO;
        cell.shouHouBtn.hidden = YES;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return rateHeight(260);
    } else {
        return rateHeight(95);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    } else {
        return rateHeight(40);
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(40))];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *orderNumLB = [UILabel labelWithText:@"订单编号：111111111" textColor:UIColorFromRGB(0x666666) fontSize:14];
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
    if (section == 1) {
        return rateHeight(80);
    } else {
        return rateHeight(10);
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(80))];
        footerView.backgroundColor = [UIColor whiteColor];
        UILabel *priceLB = [UILabel labelWithText:@"共计：68元（含10元运费）" textColor:UIColorFromRGB(0x666666) fontSize:15];
        [priceLB sizeToFit];
        [footerView addSubview:priceLB];
        [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footerView).offset(rateHeight(15));
            make.centerX.equalTo(footerView);
        }];
        
        return footerView;
    } else {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(10))];
        footerView.backgroundColor = RGB(242, 242, 242);
        return footerView;
    }
}

- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-rateHeight(170)) style:(UITableViewStyleGrouped)];
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
