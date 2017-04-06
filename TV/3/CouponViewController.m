//
//  CouponViewController.m
//  家居定制
//
//  Created by iKing on 2017/4/6.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CouponViewController.h"
#import "LiuXSegmentView.h"
#import "CouponCell.h"

@interface CouponViewController ()

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠券";
    [self setupUI];
}
- (void)setupUI {
    LiuXSegmentView *segmentView = [[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) titles:@[@"未使用", @"已过期"] bgColor:UIColorFromRGB(0xf7f7f7) clickBlick:^(NSInteger index) {
        
    }];
    segmentView.titleNomalColor = UIColorFromRGB(0x666666);
    segmentView.titleSelectColor = UIColorFromRGB(0x4fd2c2);
    segmentView.titleFont = [UIFont systemFontOfSize:16];
    [self.view addSubview:segmentView];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, segmentView.bottom, kScreenWidth, kScreenHeight-50-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CouponCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
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
