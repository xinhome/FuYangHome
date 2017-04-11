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

@property (nonatomic, strong) NSMutableArray *pingLunArray;

@end

@implementation ProductCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品评论";
    [self setupUI];
    self.pingLunArray = [NSMutableArray arrayWithArray:self.dataSource];
    NSLog(@"%@", self.dataSource);
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
    if (index == 0) {
        // 全部
        [self.pingLunArray removeAllObjects];
        self.pingLunArray = [NSMutableArray arrayWithArray:self.dataSource];
        [self.tableView reloadData];
        
    } else if (index == 1) {
        // 好评
        [self.pingLunArray removeAllObjects];
        for (ProductCommentModel *model in self.dataSource) {
            if ([model.orderMsg.buyerStatus intValue] == 0) {
                [self.pingLunArray addObject:model];
            }
        }
//        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"OrderMsg.buyerStatus == 0"];
//        NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[searchPredicate]];
//        self.pingLunArray = [self.dataSource filteredArrayUsingPredicate:predicate].mutableCopy;
        [self.tableView reloadData];
    } else if (index == 2) {
        // 中评
        [self.pingLunArray removeAllObjects];
        for (ProductCommentModel *model in self.dataSource) {
            if ([model.orderMsg.buyerStatus intValue] == 1) {
                [self.pingLunArray addObject:model];
            }
        }
        [self.tableView reloadData];
    } else if (index == 3) {
        // 差评
        [self.pingLunArray removeAllObjects];
        for (ProductCommentModel *model in self.dataSource) {
            if ([model.orderMsg.buyerStatus intValue] == 2) {
                [self.pingLunArray addObject:model];
            }
        }
        [self.tableView reloadData];
    } else {
        // 有图
        [self.pingLunArray removeAllObjects];
        for (ProductCommentModel *model in self.dataSource) {
            if (model.orderMsg.buyerPic != nil) {
                [self.pingLunArray addObject:model];
            }
        }
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pingLunArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.pingLunArray.count != 0) {
        cell.cellModel = self.pingLunArray[indexPath.row];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
