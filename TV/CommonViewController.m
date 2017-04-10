//
//  CommonViewController.m
//  家居定制
//
//  Created by iKing on 2017/3/21.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CommonViewController.h"
#import "CommonCell.h"
#import "CommentView.h"
#import "ScenceCommentModel.h"

@interface CommonViewController ()<CommentViewDelegate>

@property (nonatomic, strong) NSMutableArray<ScenceCommentModel *> *dataSource;///<<#注释#>

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"场景评论";
    [self setupView];
    [self loadData];
}

- (void)loadData {
    [[HttpRequestManager shareManager] addPOSTURL:@"/ScenesComments/list" person:RequestPersonWeiMing parameters:@{@"scenesId": self.scenceId} success:^(id successResponse) {
        NSLog(@"%@", successResponse[@"data"]);
        self.dataSource = [ScenceCommentModel mj_objectArrayWithKeyValuesArray:successResponse[@"data"]];
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setupView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-40) style:UITableViewStylePlain];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView registerClass:[CommonCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self setupSendView];
}

- (void)setupSendView {
    UILabel *label = [UILabel labelWithText:@"说点什么吧..." textColor:RGB(157, 157, 157) fontSize:14];
    label.frame = CGRectMake(0, self.tableView.bottom, kScreenWidth, 40);
    [self.view addSubview:label];
    [label whenTapped:^{
        CommentView *commentView = [[CommentView alloc] init];
        commentView.delegate = self;
        [commentView show];
    }];
}

#pragma mark - CommentViewDelegate
- (void)sendContent:(CommentView *)commentView content:(NSString *)content {
    if (self.user == nil) {
        [MBProgressHUD showError:@"请登录"];
        return;
    }
    NSDictionary *parameters = @{
                                 @"discussContent": content,
                                 @"scenesId": self.scenceId,
                                 @"userId": self.user.ID
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/ScenesComments/save" person:RequestPersonWeiMing parameters:parameters success:^(id successResponse) {
        if ([successResponse isSuccess]) {
            ScenceCommentModel *model = [[ScenceCommentModel alloc] init];
            model.name = self.user.nickname;
            model.url = [self.user.avatar substringFromIndex:WEIMING.length];
            model.discussContent = content;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            model.created = [formatter stringFromDate:[NSDate date]];
            [self.dataSource addObject:model];
            [self.tableView reloadData];
            self.commentSuccess();
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"网络错误"];
        NSLog(@"%@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.cellModel = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
