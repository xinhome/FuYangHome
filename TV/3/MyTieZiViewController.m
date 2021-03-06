//
//  MyTieZiViewController.m
//  家居定制
//
//  Created by iking on 2017/3/24.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "MyTieZiViewController.h"
#import "MyTieZiTableViewCell.h"
#import "BottomDeleteView.h"
#import "ThereDetailViewController.h"
#import "ThereModel.h"

@interface MyTieZiViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) BottomDeleteView *bottomDeleteV;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) BOOL selectIsShow;
@property (nonatomic, strong) NSMutableArray *btnStatusArr;
@property (nonatomic, strong) NSMutableArray<ThereModel *> *tieZiArray;
@property (nonatomic, strong) NSMutableArray<ThereModel *> *deleteSelectArray;

@end

@implementation MyTieZiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.btnStatusArr = [NSMutableArray array];
//    for (int i = 0; i < 10; i++) {
//        [self.btnStatusArr addObject:[NSString stringWithFormat:@"0"]];
//    }
    [self setNavigationBar];
    [self.view addSubview:self.myTableView];
    [self setUpUI];
    [self setUpData];
    self.deleteSelectArray = [NSMutableArray array];
}
- (void)setNavigationBar
{
    self.navigationItem.title = @"我的帖子";
    [self addRightItemWithImage:@"shanchu " action:@selector(deleteTieZi:)];
    [self addBackForUser];
}
- (void)setUpData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults valueForKey:@"myUserId"];
    NSLog(@"%@", userId);
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/getall" person:RequestPersonWeiMing parameters:@{@"user.id": userId, @"page": @(1)} success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"帖子列表-----%@", successResponse);
        NSArray *data = successResponse;
        self.tieZiArray = [ThereModel mj_objectArrayWithKeyValuesArray:data];
        self.btnStatusArr = [NSMutableArray array];
        [_btnStatusArr removeAllObjects];
        for (int i = 0; i < _tieZiArray.count; i++) {
            [self.btnStatusArr addObject:[NSString stringWithFormat:@"0"]];
        }
        [_myTableView reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常"];
    }];
}
- (void)setUpUI
{
    self.bottomDeleteV = [BottomDeleteView new];
    self.bottomDeleteV.backgroundColor = RGB(127, 127, 127);
    [self.view addSubview:self.bottomDeleteV];
    [self.bottomDeleteV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(kScreenWidth, rateHeight(50)));
    }];
    [self.bottomDeleteV.selectAllBtn addTarget:self action:@selector(actionSelectAll:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.bottomDeleteV.deleteBtn addTarget:self action:@selector(deleteSelectTieZi) forControlEvents:(UIControlEventTouchUpInside)];
    self.bottomDeleteV.hidden = YES;
}
#pragma mark - 删除帖子
- (void)deleteTieZi:(UIButton *)btn
{
    self.selectIsShow = !_selectIsShow;
    btn.adjustsImageWhenHighlighted = NO;
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        [btn setImage:nil forState:(UIControlStateNormal)];
        [btn setTitle:@"取消" forState:(UIControlStateNormal)];
        self.bottomDeleteV.hidden = NO;
    } else {
        [btn setImage:[UIImage imageNamed:@"shanchu "] forState:(UIControlStateNormal)];
        self.bottomDeleteV.hidden = YES;
    }
    [_myTableView reloadData];
}
#pragma mark - 帖子删除
- (void)deleteSelectTieZi
{
    if (_deleteSelectArray.count != 0) {
        [MBProgressHUD showMessage:@"正在删除数据..." toView:self.view];
        NSMutableArray *array = [NSMutableArray array];
        for (ThereModel *model in _deleteSelectArray) {
            NSString *newStr = [NSString stringWithFormat:@"id=%@", model.magazineId];
            [array addObject:newStr];
        }
        NSString *idStr = [array componentsJoinedByString:@"&"];
        NSString *url = [NSString stringWithFormat:@"%@magazines/deletemany?%@", WeiMingURL,idStr];
        NSLog(@"url:%@", url);
        [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUDForView:self.view];
            if ([responseObject[@"result"] intValue] == 0) {
                [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
//                [self.tieZiArray removeObjectsInArray:self.deleteSelectArray];
                [_tieZiArray removeAllObjects];
                [_deleteSelectArray removeAllObjects];
                [self setUpData];
                
            } else {
                [MBProgressHUD showMessage:@"删除失败" toView:self.view];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"网络异常"];
        }];
    }
}
#pragma mark - 全选
- (void)actionSelectAll:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        [self.btnStatusArr removeAllObjects];
        for (int i = 0; i < 10; i++) {
            [self.btnStatusArr addObject:[NSString stringWithFormat:@"1"]];
        }
        [_deleteSelectArray removeAllObjects];
        for (ThereModel *model in _tieZiArray) {
            [_deleteSelectArray addObject:model];
        }
        [self.bottomDeleteV.selectAllBtn setImage:[UIImage imageNamed:@"全选选中"] forState:(UIControlStateNormal)];
        [_myTableView reloadData];
    } else {
        [self.btnStatusArr removeAllObjects];
        for (int i = 0; i < 10; i++) {
            [self.btnStatusArr addObject:[NSString stringWithFormat:@"0"]];
        }
        [_deleteSelectArray removeAllObjects];
        [self.bottomDeleteV.selectAllBtn setImage:[UIImage imageNamed:@"全选"] forState:(UIControlStateNormal)];
        [_myTableView reloadData];
    }
}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tieZiArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"orderCarCell";
    MyTieZiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyTieZiTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.selectionStyle = NO;
    cell.selectBtn.tag = indexPath.row;
    if (self.selectIsShow == YES) {
        cell.selectBtn.hidden = NO;
    } else {
        cell.selectBtn.hidden = YES;
    }
    if ([self.btnStatusArr[indexPath.row] intValue] == 0) {
        [cell.selectBtn setImage:[UIImage imageNamed:@"没选中"] forState:(UIControlStateNormal)];
    } else if ([self.btnStatusArr[indexPath.row] intValue] == 1) {
        [cell.selectBtn setImage:[UIImage imageNamed:@"选中"] forState:(UIControlStateNormal)];
    }
    [cell.selectBtn addTarget:self action:@selector(actionDanXuan:) forControlEvents:(UIControlEventTouchUpInside)];
    if (_tieZiArray.count != 0) {
        cell.model = _tieZiArray[indexPath.row];
    }
    return cell;
}
#pragma mark - 单选按钮
- (void)actionDanXuan:(UIButton *)btn
{
    if ([_btnStatusArr[btn.tag] intValue] == 0) {
        _btnStatusArr[btn.tag] = @"1";
        ThereModel *model = _tieZiArray[btn.tag];
        [_deleteSelectArray addObject:model];
    } else if ([_btnStatusArr[btn.tag] intValue] == 1) {
        _btnStatusArr[btn.tag] = @"0";
        ThereModel *model = _tieZiArray[btn.tag];
        [_deleteSelectArray removeObject:model];
    }
    [_myTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rateHeight(150);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tieZiArray.count != 0) {
        ThereDetailViewController *detail = [[ThereDetailViewController alloc]init];
        detail.selfIndex = 1;
        detail.refreshAction = ^{
            ThereModel *model = self.tieZiArray[indexPath.row];
            int count = [model.count intValue];
            model.count = [NSString stringWithFormat:@"%d", ++count];
            [self.tieZiArray replaceObjectAtIndex:indexPath.row withObject:model];
            [tableView reloadData];
        };
        detail.praiseAction = ^{
            ThereModel *model = self.tieZiArray[indexPath.row];
//            int count = [model.likes intValue];
//            model.likes = [NSString stringWithFormat:@"%d", ++count];
            [self.tieZiArray replaceObjectAtIndex:indexPath.row withObject:model];
            [tableView reloadData];
        };
        detail.model = self.tieZiArray[indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
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
