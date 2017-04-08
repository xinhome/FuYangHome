//
//  ThereDetailViewController.m
//  TV
//
//  Created by HOME on 16/9/14.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "ThereDetailViewController.h"
#import "EaseTextView.h"
#import "CommunityDetailCell.h"
#import "CommunityDetailView.h"
#import "CommentView.h"
#import "SocietyCommentModel.h"

@interface ThereDetailViewController ()<CommentViewDelegate>
@property (nonatomic, strong) NSMutableArray<SocietyCommentModel *> *dataSource;///<<#注释#>
@end

@implementation ThereDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社区详情";
    [self setupUI];
    [self loadData];
}
- (void)loadData {
//    [[AFHTTPSessionManager manager] POST:@"http://xwmasd.ngrok.cc/FyHome/magazines/getone" parameters:@{@"id": self.model.magazineId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//        NSArray *comments = responseObject[@"data"][@"comments"];
//        for (NSDictionary *comment in comments) {
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//            dict[@"avatar"] = comment[@""];
//            dict[@"nickname"] = comment[@""];
//            dict[@"commentContent"] = comment[@"commentContent"];
//            dict[@"commentTime"] = comment[@"generateTime"];
//            [self.dataSource addObject:[SocietyCommentModel mj_objectWithKeyValues:dict]];
//        }
//        [self.tableView reloadData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/getone" person:RequestPersonKaiKang parameters:@{@"id": self.model.magazineId} success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
//        NSLog(@"%@", successResponse);
        NSArray *comments = successResponse[@"data"][@"comments"];
        for (NSDictionary *comment in comments) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"avatar"] = comment[@"reviewer"][@"url"];
            dict[@"nickname"] = comment[@"reviewer"][@"name"];
            dict[@"commentContent"] = comment[@"commentContent"];
            dict[@"commentTime"] = comment[@"generateTime"];
            [self.dataSource addObject:[SocietyCommentModel mj_objectWithKeyValues:dict]];
        }
        [self.tableView reloadData];
//        NSLog(@"%@",comments);
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常"];
        NSLog(@"%@", error);
    }];
}
- (void)setupUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CommunityDetailCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self setupHeaderView];
}
- (void)setupHeaderView {
    CommunityDetailView *headerView = [[CommunityDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [headerView.comment whenTapped:^{
        CommentView *commentView = [[CommentView alloc] init];
        commentView.delegate = self;
        [commentView show];
    }];
    [headerView.praise whenTapped:^{
        [self praise];
    }];
    headerView.model = self.model;
    self.tableView.tableHeaderView = headerView;
}
#pragma mark - 点赞
- (void)praise {

    NSDictionary *parameters = @{
//                                 @"user.id": self.user.ID,
                                 @"magazineId": self.model.magazineId
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/like" person:RequestPersonWeiMing parameters:parameters success:^(id successResponse) {
        NSLog(@"%@", successResponse);
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
#pragma mark - CommentViewDelegate
- (void)sendContent:(CommentView *)commentView content:(NSString *)content {
    NSDictionary *parameters = @{
                                 @"reviewer.id": [[NSUserDefaults standardUserDefaults] stringForKey:@"myUserId"],
                                 @"magazine.magazineId": self.model.magazineId,
                                 @"parentComment.commentId": @0,
                                 @"commentContent": content
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/comments/add" person:RequestPersonWeiMing parameters:parameters success:^(id successResponse) {
        if ([successResponse isSuccess]) {
            [self popViewController];
            [MBProgressHUD showSuccess:@"评论成功"];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误"];
    }];
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommunityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}
#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = RGB(224, 224, 224);
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 2, 30)];
    line.backgroundColor = RGB(83, 204, 185);
    [view addSubview:line];
    UILabel *label = [UILabel labelWithText:@"评论" textColor:RGB(116, 116, 116) fontSize:16];
    [label sizeToFit];
    label.origin = CGPointMake(line.right+20, (30-label.height)/2);
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSMutableArray<SocietyCommentModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
