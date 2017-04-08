//
//  SystemMsgViewController.m
//  家居定制
//
//  Created by iKing on 2017/3/18.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "SystemMsgViewController.h"
#import "SystemMsgCell.h"

@interface SystemMsgViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation SystemMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统消息";
//    [self addBackForUser];
    [self setupUI];
    [self setUpData];
}
- (void)setUpData
{
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/Sys/list" person:RequestPersonWeiMing parameters:nil success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([successResponse isSuccess]) {
            NSLog(@"系统消息：%@", successResponse);
            NSArray *array = successResponse[@"data"];
            if (array.count != 0) {
                self.dataArray = [NSMutableArray array];
                for (NSDictionary *dic in successResponse[@"data"]) {
                    [_dataArray addObject:dic];
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    [self.tableView registerClass:[SystemMsgCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (_dataArray.count != 0) {
        NSDictionary *dic = _dataArray[indexPath.row];
        cell.content = dic[@"sysContent"];
        cell.time.text = [dic[@"sysTime"] substringToIndex:16];
        cell.longPressAction = ^{
            
        };
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _dataArray[indexPath.row];
    return [SystemMsgCell heightForContent:dic[@"sysContent"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemMsgCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.menu setMenuVisible:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
