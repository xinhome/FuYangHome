//
//  ProductCommentController.m
//  家居定制
//
//  Created by iKing on 2017/3/31.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ProductCommentController.h"
#import "GoodsCommentCell.h"
#import "GoodsCommentView.h"

@interface ProductCommentController ()<GoodsCommentViewDelegate>

@end

@implementation ProductCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品评论";
    [self setupUI];
}
- (void)setupUI {
    GoodsCommentView *commentView = [[GoodsCommentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    commentView.delegate = self;
    [self.view addSubview:commentView];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, commentView.bottom, kScreenWidth, kScreenHeight-64-60) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[GoodsCommentCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mrak - GoodsCommentViewDelegate 
- (void)goodsCommentView:(GoodsCommentView *)commentView didSelectIndex:(int)index {
    NSLog(@"%d", index);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
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
