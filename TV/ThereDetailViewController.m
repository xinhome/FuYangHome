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

@interface ThereDetailViewController ()<CommentViewDelegate>

@end

@implementation ThereDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社区详情";
    [self setupUI];
    [self loadData];
}
- (void)loadData {
    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/getone" person:RequestPersonKaiKang parameters:@{@"id": self.model.magazineId} success:^(id successResponse) {
        NSLog(@"%@", successResponse);
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)setupUI {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
                                 @"user.id": [[NSUserDefaults standardUserDefaults] stringForKey:@"myUserId"],
                                 @"magazine.magazineId": self.model.magazineId
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/thumbs/add" person:RequestPersonWeiMing parameters:parameters success:^(id successResponse) {
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
    [[HttpRequestManager shareManager] addPOSTURL:@"/comments/add" person:RequestPersonKaiKang parameters:parameters success:^(id successResponse) {
        NSLog(@"%@", successResponse);
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommunityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
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

@end
