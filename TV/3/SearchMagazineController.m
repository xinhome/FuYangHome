//
//  SearchMagazineController.m
//  家居定制
//
//  Created by iKing on 2017/4/6.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "SearchMagazineController.h"
#import "SearchResultCell.h"
#import "ThereModel.h"
#import "ThereDetailViewController.h"

@interface SearchMagazineController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray<ThereModel *> *dataSource;///<<#注释#>
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
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[SearchResultCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.cellModel = self.dataSource[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ThereDetailViewController *controller = [[ThereDetailViewController alloc] init];
    controller.model = self.dataSource[indexPath.row];
    [self pushViewController:controller animation:YES];
}
- (void)configSearchBar {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rateWidth(260), 35)];
    UITextField *searchBar = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, rateWidth(230), 35)];
    searchBar.delegate = self;
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
        if ([successResponse isSuccess]) {
            self.dataSource = [ThereModel mj_objectArrayWithKeyValuesArray:successResponse[@"data"]];
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD showError:@"网络异常"];
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchWithKey:textField.text];
    return YES;
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
