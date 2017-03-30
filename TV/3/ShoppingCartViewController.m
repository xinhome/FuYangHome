//
//  ShoppingCartViewController.m
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "BottomJieSuanView.h"
#import "BottomDeleteView.h"
#import "JieSuanOrderViewController.h"
#import "ShoppingCarModel.h"

@interface ShoppingCartViewController ()<ChangeGoodsNumDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) BottomJieSuanView *bottomJieSuanV;
@property (nonatomic, strong) BottomDeleteView *bottomDeleteV;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) NSMutableArray *btnStatusArr;
@property (nonatomic, assign) BOOL isBottomSelect;
@property (nonatomic, strong) NSMutableArray *shoppingArray;
@property (nonatomic, strong) NSMutableArray *deleteGoodsArray;
@property (nonatomic, assign) BOOL isRightItemSelect;
@property (nonatomic, strong) NSMutableArray *jieSuanGoodsArray;
@property (nonatomic, assign) CGFloat sumPrice;
@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    [self.view addSubview:self.myTableView];
    [self addJieSuanView];
//    [self setUpData];
    self.deleteGoodsArray = [NSMutableArray array];
    self.jieSuanGoodsArray = [NSMutableArray array];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_jieSuanGoodsArray removeAllObjects];
    self.sumPrice = 0.0;
    self.bottomJieSuanV.gongJiLB.text = [NSString stringWithFormat:@"共计：%.2f元（含0元运费）", _sumPrice];
    [self setUpData];
}

- (void)setNavigationBar
{
    self.navigationItem.title = @"我的购物车";
    [self addRightItemWithImage:@"shanchu " action:@selector(deleteGoods:)];
}
#pragma mark - SetUpData
- (void)setUpData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults valueForKey:@"myUserId"];
    if (userId != nil) {
        [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
        [[HttpRequestManager shareManager] addPOSTURL:@"/Order/showCar" person:RequestPersonWeiMing parameters:@{@"userId": userId,@"status": @0} success:^(id successResponse) {
            [MBProgressHUD hideHUDForView:self.view];
            if ([successResponse isSuccess]) {
                NSArray *data = successResponse[@"data"];
                NSLog(@"购物车：%@", data);
                if (data.count != 0) {
                    self.shoppingArray = [NSMutableArray array];
                    for (NSDictionary *dic in data) {
                        ShoppingCarModel *model = [[ShoppingCarModel alloc] init];
                        [model setValuesForKeysWithDictionary:dic];
                        [_shoppingArray addObject:model];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.btnStatusArr = [NSMutableArray array];
                        for (int i = 0; i < _shoppingArray.count; i++) {
                            [self.btnStatusArr addObject:[NSString stringWithFormat:@"0"]];
                        }
                        [_myTableView reloadData];
                    });
                }
            } else {
                [MBProgressHUD showResponseMessage:successResponse];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"网络异常"];
        }];
    }
}

// 底部view
- (void)addJieSuanView
{
    self.bottomJieSuanV = [BottomJieSuanView new];
    self.bottomJieSuanV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomJieSuanV];
    [self.bottomJieSuanV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(kScreenWidth, rateHeight(50)));
    }];
    [self.bottomJieSuanV.selectAllBtn addTarget:self action:@selector(actionSelectAll:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.bottomJieSuanV.jieSuanBtn addTarget:self action:@selector(actionJieSuan:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.bottomDeleteV = [BottomDeleteView new];
    self.bottomDeleteV.backgroundColor = RGB(127, 127, 127);
    [self.view addSubview:self.bottomDeleteV];
    [self.bottomDeleteV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(kScreenWidth, rateHeight(50)));
    }];
    [self.bottomDeleteV.selectAllBtn addTarget:self action:@selector(actionSelectAll:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.bottomDeleteV.deleteBtn addTarget:self action:@selector(actionDeleteGoods:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.bottomDeleteV.hidden = YES;
}
#pragma mark - 删除按钮
- (void)actionDeleteGoods:(UIButton *)btn
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults valueForKey:@"myUserId"];
    if (userId != nil && _deleteGoodsArray.count != 0) {
        [MBProgressHUD showMessage:@"正在删除数据..." toView:self.view];
        [[HttpRequestManager shareManager] addPOSTURL:@"/Order/deleteOrder" person:RequestPersonWeiMing parameters:@{@"userId": userId,@"id": _deleteGoodsArray[0]} success:^(id successResponse) {
            [MBProgressHUD hideHUDForView:self.view];
            if ([successResponse isSuccess]) {
                NSArray *data = successResponse[@"data"];
                if (data.count != 0) {
                    NSMutableArray *orderArr = [NSMutableArray arrayWithArray:data[0][@"order"][@"orders"]];
                    [orderArr removeObjectAtIndex:0];
                    [self.shoppingArray removeAllObjects];
                    [self.btnStatusArr removeAllObjects];
                    for (NSDictionary *dic in orderArr) {
                        ShoppingCarModel *model = [[ShoppingCarModel alloc] init];
                        [model setValuesForKeysWithDictionary:dic];
                        [_shoppingArray addObject:model];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        for (int i = 0; i < _shoppingArray.count; i++) {
                            [self.btnStatusArr addObject:[NSString stringWithFormat:@"0"]];
                        }
                        [_myTableView reloadData];
                    });
                }
            } else {
                [MBProgressHUD showResponseMessage:successResponse];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"网络异常"];
        }];
    }
}
#pragma mark - 全选按钮
- (void)actionSelectAll:(UIButton *)btn
{
    btn.selected = !btn.selected;
    self.isBottomSelect = !_isBottomSelect;
    if (_isBottomSelect) {
        [self.btnStatusArr removeAllObjects];
        for (int i = 0; i < _shoppingArray.count; i++) {
            [self.btnStatusArr addObject:[NSString stringWithFormat:@"1"]];
        }
        if (_isRightItemSelect) {
            [_deleteGoodsArray removeAllObjects];
            for (ShoppingCarModel *model in _shoppingArray) {
                [_deleteGoodsArray addObject:[NSString stringWithFormat:@"%@", model.goodsId]];
            }
        } else {
            [_jieSuanGoodsArray removeAllObjects];
            for (ShoppingCarModel *model in _shoppingArray) {
                [_jieSuanGoodsArray addObject:model];
            }
            self.sumPrice = 0.0;
            for (ShoppingCarModel *model in _jieSuanGoodsArray) {
                _sumPrice = _sumPrice + [model.num intValue]*[model.price floatValue];
            }
            self.bottomJieSuanV.gongJiLB.text = [NSString stringWithFormat:@"共计：%.2f元（含0元运费）", _sumPrice];
        }
        [self.bottomJieSuanV.selectAllBtn setImage:[UIImage imageNamed:@"灰选中"] forState:(UIControlStateNormal)];
        [self.bottomDeleteV.selectAllBtn setImage:[UIImage imageNamed:@"全选选中"] forState:(UIControlStateNormal)];
        [_myTableView reloadData];
    } else {
        [self.btnStatusArr removeAllObjects];
        for (int i = 0; i < _shoppingArray.count; i++) {
            [self.btnStatusArr addObject:[NSString stringWithFormat:@"0"]];
        }
        if (_isRightItemSelect) {
            [_deleteGoodsArray removeAllObjects];
        } else {
            [_jieSuanGoodsArray removeAllObjects];
            self.sumPrice = 0.0;
//            for (ShoppingCarModel *model in _jieSuanGoodsArray) {
//                _sumPrice = _sumPrice + [model.num intValue]*[model.price floatValue];
//            }
            self.bottomJieSuanV.gongJiLB.text = [NSString stringWithFormat:@"共计：%.2f元（含0元运费）", _sumPrice];
        }
        [self.bottomJieSuanV.selectAllBtn setImage:[UIImage imageNamed:@"椭圆 4"] forState:(UIControlStateNormal)];
        [self.bottomDeleteV.selectAllBtn setImage:[UIImage imageNamed:@"全选"] forState:(UIControlStateNormal)];
        [_myTableView reloadData];
    }
}
#pragma mark - 导航栏删除按钮
- (void)deleteGoods:(UIButton *)btn
{
    self.isRightItemSelect = !_isRightItemSelect;
    self.isBottomSelect = NO;
    [self.bottomJieSuanV.selectAllBtn setImage:[UIImage imageNamed:@"椭圆 4"] forState:(UIControlStateNormal)];
    [self.bottomDeleteV.selectAllBtn setImage:[UIImage imageNamed:@"全选"] forState:(UIControlStateNormal)];
    [self.btnStatusArr removeAllObjects];
    [_jieSuanGoodsArray removeAllObjects];
    for (int i = 0; i < _shoppingArray.count; i++) {
        [self.btnStatusArr addObject:[NSString stringWithFormat:@"0"]];
    }
    [_myTableView reloadData];
    btn.adjustsImageWhenHighlighted = NO;
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        [btn setImage:nil forState:(UIControlStateNormal)];
        [btn setTitle:@"取消" forState:(UIControlStateNormal)];
        self.bottomJieSuanV.hidden = YES;
        self.bottomDeleteV.hidden = NO;
    } else {
        [btn setImage:[UIImage imageNamed:@"shanchu "] forState:(UIControlStateNormal)];
        self.bottomJieSuanV.hidden = NO;
        self.bottomDeleteV.hidden = YES;
    }
}
#pragma mark - 单选按钮
- (void)actionDanXuan:(UIButton *)btn
{
    if ([_btnStatusArr[btn.tag] intValue] == 0) {
        _btnStatusArr[btn.tag] = @"1";
        if (_isRightItemSelect) {
            ShoppingCarModel *model = _shoppingArray[btn.tag];
            [_deleteGoodsArray addObject:[NSString stringWithFormat:@"%@", model.goodsId]];
        } else {
            ShoppingCarModel *model = _shoppingArray[btn.tag];
            [_jieSuanGoodsArray addObject:model];
            self.sumPrice = 0.0;
            for (ShoppingCarModel *model in _jieSuanGoodsArray) {
                _sumPrice = _sumPrice + [model.num intValue]*[model.price floatValue];
            }
            self.bottomJieSuanV.gongJiLB.text = [NSString stringWithFormat:@"共计：%.2f元（含0元运费）", _sumPrice];
        }
    } else if ([_btnStatusArr[btn.tag] intValue] == 1) {
        _btnStatusArr[btn.tag] = @"0";
        if (_isRightItemSelect) {
            ShoppingCarModel *model = _shoppingArray[btn.tag];
            [_deleteGoodsArray removeObject:model.goodsId];
//            for (NSString *str in _deleteGoodsArray) {
//                if ([str isEqualToString:[NSString stringWithFormat:@"%@", model.goodsId]]) {
//                    [_deleteGoodsArray removeObject:str];
//                }
//            }
        } else {
            ShoppingCarModel *model = _shoppingArray[btn.tag];
            [_jieSuanGoodsArray removeObject:model];
            self.sumPrice = 0.0;
            for (ShoppingCarModel *model in _jieSuanGoodsArray) {
                _sumPrice = _sumPrice + [model.num intValue]*[model.price floatValue];
            }
            self.bottomJieSuanV.gongJiLB.text = [NSString stringWithFormat:@"共计：%.2f元（含0元运费）", _sumPrice];
        }
    }
    [_myTableView reloadData];
}
#pragma mark - 结算按钮
- (void)actionJieSuan:(UIButton *)btn
{
    if (_jieSuanGoodsArray.count != 0) {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        for (int i = 0; i < _jieSuanGoodsArray.count; i ++) {
            NSString *ID = [NSString stringWithFormat:@"order[%d].id", i];
            NSString *itemId = [NSString stringWithFormat:@"order[%d].itemId", i];
            NSString *orderId = [NSString stringWithFormat:@"order[%d].orderId", i];
            NSString *num = [NSString stringWithFormat:@"order[%d].num", i];
            NSString *price = [NSString stringWithFormat:@"order[%d].price", i];
            NSString *totalFee = [NSString stringWithFormat:@"order[%d].totalFee", i];
            NSString *picPath = [NSString stringWithFormat:@"order[%d].picPath", i];
            NSString *title = [NSString stringWithFormat:@"order[%d].title", i];
            ShoppingCarModel *model = (ShoppingCarModel *)_jieSuanGoodsArray[i];
            parameters[ID] = model.goodsId;
            parameters[itemId] = model.itemId;
            parameters[orderId] = model.orderId;
            parameters[num] = model.num;
            parameters[price] = model.price;
            parameters[totalFee] = [NSString stringWithFormat:@"%.2f", [model.num intValue]*[model.price floatValue]];
            parameters[picPath] = model.picPath;
            parameters[title] = model.title;
        }
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userId = [userDefaults valueForKey:@"myUserId"];
        parameters[@"userId"] = userId;
        NSLog(@"-------%@", parameters);
            [MBProgressHUD showMessage:@"正在提交..." toView:self.view];
            [[HttpRequestManager shareManager] addPOSTURL:@"/Order/showCarById" person:RequestPersonWeiMing parameters:parameters success:^(id successResponse) {
                [MBProgressHUD hideHUDForView:self.view];
                if ([successResponse isSuccess]) {
                    NSLog(@"结算：%@", successResponse);
                    self.listArray = [NSMutableArray array];
                    NSArray *listArr = successResponse[@"data"][@"list"];
                    for (NSDictionary *dic in listArr) {
                        ShoppingCarModel *model = [[ShoppingCarModel alloc] init];
                        [model setValuesForKeysWithDictionary:dic];
                        [_listArray addObject:model];
                    }
                    JieSuanOrderViewController *jieSuanVC = [[JieSuanOrderViewController alloc] init];
                    jieSuanVC.listArray = _listArray;
                    [self.navigationController pushViewController:jieSuanVC animated:YES];
                }
            } fail:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showError:@"网络异常"];
            }];
    }
}
#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _shoppingArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"orderCarCell";
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ShoppingCartTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        cell.delegate = self;
    }
    cell.selectionStyle = NO;
    if (_shoppingArray.count != 0) {
        cell.cellModel = (ShoppingCarModel *)_shoppingArray[indexPath.section];
        cell.selectBtn.tag = indexPath.section;
        [cell.selectBtn addTarget:self action:@selector(actionDanXuan:) forControlEvents:(UIControlEventTouchUpInside)];
        if ([_btnStatusArr[indexPath.section] intValue] == 0) {
            [cell.selectBtn setImage:[UIImage imageNamed:@"没选中"] forState:(UIControlStateNormal)];
        } else if ([_btnStatusArr[indexPath.section] intValue] == 1) {
            [cell.selectBtn setImage:[UIImage imageNamed:@"选中"] forState:(UIControlStateNormal)];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rateHeight(130);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return rateHeight(18);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)changeGoodsNum:(ShoppingCarModel *)model
{
    NSInteger index = [self.shoppingArray indexOfObject:model];
    [self.shoppingArray replaceObjectAtIndex:index withObject:model];
}

- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-114) style:(UITableViewStyleGrouped)];
        _myTableView.backgroundColor = [UIColor whiteColor];
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
