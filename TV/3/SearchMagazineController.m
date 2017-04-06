//
//  SearchMagazineController.m
//  家居定制
//
//  Created by iKing on 2017/4/6.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "SearchMagazineController.h"
#import "SearchResultCell.h"

@interface SearchMagazineController ()<UITextFieldDelegate>

@end

@implementation SearchMagazineController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:UIColorWhite] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonBack:self imageName:@"nav_back" action:@selector(dismiss)];
    [self configSearchBar];
    [self setupUI];
}
- (void)setupUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    [self.tableView registerClass:[SearchResultCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}
- (void)configSearchBar {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rateWidth(260), 35)];
    UITextField *searchBar = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, rateWidth(230), 35)];
    searchBar.layer.cornerRadius = 7;
    searchBar.leftView = [self leftView];
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    searchBar.layer.masksToBounds = YES;
    searchBar.placeholder = @"在此输入关键词";
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.delegate = self;
    searchBar.backgroundColor = RGB(224, 224, 224);
    [view addSubview:searchBar];
    
    UIButton *search = [UIButton buttonWithTitle:@"搜索" fontSize:17 titleColor:RGB(0, 0, 0) background:[UIColor clearColor] cornerRadius:0];
    [search addActionHandler:^{
        [self searchWithKey:searchBar.text];
    }];
    search.frame = CGRectMake(searchBar.right, 0, 50, 17);
    search.centerY = view.centerY;
    [view addSubview:search];
    self.navigationItem.titleView = view;
}
- (void)searchWithKey:(NSString *)key {
    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/search" person:RequestPersonWeiMing parameters:@{@"magazineName": key} success:^(id successResponse) {
        NSLog(@"%@", successResponse);
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIView *)leftView {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 35)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 35)];
    imageView.image = UIImageNamed(@"sousuo");
    [leftView addSubview:imageView];
    return leftView;
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
