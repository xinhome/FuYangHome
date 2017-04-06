//
//  SearchViewController.m
//  家居定制
//
//  Created by iKing on 2017/3/18.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#define SearchRecords @"SearchRecords"

#import "SearchViewController.h"
#import "SearchResultCell.h"
#import "SearchResultModel.h"
#import "AllProductCell.h"
#import "AllProductModel.h"
#import "ProductDetailController.h"

@interface SearchViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UILabel *label;///<<#注释#>
@property (nonatomic, strong) NSMutableArray *searchRecords;
@property (nonatomic, weak) UITextField *searchBar;///<<#注释#>
@property (nonatomic, weak) UICollectionView *collectionView;///<搜索结果
@property (nonatomic, strong) NSMutableArray<AllProductModel *> *dataSource;///<搜索结果data
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchRecords = [NSMutableArray array];
    NSArray *records = [[NSUserDefaults standardUserDefaults] objectForKey:SearchRecords];
    [self.searchRecords addObjectsFromArray:records];
    [self configSearchBar];
    [self setupUI];
}

- (void)setupUI {
    UILabel *label = [UILabel labelWithText:@"" textColor:RGB(181, 181, 181) fontSize:16];
    label.frame = CGRectMake(0, 0, kScreenWidth, 35);
    label.backgroundColor = RGB(234, 234, 234);
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    _label = label;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(rateWidth(165), rateWidth(165)+5+14+14);
    flowLayout.sectionInset = UIEdgeInsetsMake(17, rateWidth(15), 0, rateWidth(15));
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 35, kScreenWidth, kScreenHeight-64-35) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = UIColorWhite;
    [collectionView registerClass:[AllProductCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height-64-10)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = huiseColor;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchRecords.count+2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row < self.searchRecords.count+1) {
        cell.backgroundColor = RGB(239, 239, 239);
        if (![cell viewWithTag:1001]) {
            if ([cell.contentView viewWithTag:1002]) {
                [[cell.contentView viewWithTag:1002] removeFromSuperview];
            }
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, cell.height-2, kScreenWidth, 0.3)];
            line.backgroundColor = RGB(214, 214, 214);
            line.tag = 1001;
            [cell addSubview:line];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"最近搜索";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else {
            cell.textLabel.text = [NSString stringWithFormat:@" %@", self.searchRecords[indexPath.row-1]];
        }
        cell.textLabel.textColor = RGB(126, 126, 126);
    } else {
        cell.textLabel.text = @"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = UIColorWhite;
        if (![cell.contentView viewWithTag:1002]) {
            if ([cell viewWithTag:1001]) {
                [[cell viewWithTag:1001] removeFromSuperview];
            }
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, rateWidth(340), 35)];
            btn.centerX = kScreenWidth/2;
            btn.layer.cornerRadius = 8;
            btn.layer.masksToBounds = YES;
            [btn setTitle:@"清除搜索记录" forState:UIControlStateNormal];
            [btn setTitleColor:UIColorWhite forState:UIControlStateNormal];
            btn.backgroundColor = RGB(68, 202, 181);
            btn.tag = 1002;
            [btn addTarget:self action:@selector(deleteSearchRecords) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
        }
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row < self.searchRecords.count+1) {
        if (indexPath.row != 0) {
            [self search:[cell.textLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        }
    }
}

#pragma mark - collectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AllProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailController *detail = [[ProductDetailController alloc]init];
    detail.itemID = self.dataSource[indexPath.item].ID;
    [self pushViewController:detail animation:YES];
}

- (void)deleteSearchRecords {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"确认删除搜索记录" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.searchRecords removeAllObjects];
        [[NSUserDefaults standardUserDefaults] setObject:self.searchRecords forKey:SearchRecords];
        [self.tableView reloadData];
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)configSearchBar {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rateWidth(260), 35)];
    UITextField *searchBar = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, rateWidth(230), 35)];
    _searchBar = searchBar;
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
        [searchBar resignFirstResponder];
        [self.searchRecords addObject:searchBar.text];
        [[NSUserDefaults standardUserDefaults] setObject:self.searchRecords forKey:SearchRecords];
        [self.tableView reloadData];
        [self search:searchBar.text];
    }];
    search.frame = CGRectMake(searchBar.right, 0, 50, 17);
    search.centerY = view.centerY;
    [view addSubview:search];
    self.navigationItem.titleView = view;
}
- (void)search:(NSString *)key {
    [MBProgressHUD showMessage:@"正在搜索..."];
    [[HttpRequestManager shareManager] addPOSTURL:@"/Item/search" person:RequestPersonWeiMing parameters:@{@"title": key} success:^(id successResponse) {
        [MBProgressHUD hideHUD];
        if ([successResponse isSuccess]) {
            [self.view bringSubviewToFront:self.collectionView];
            [self.view bringSubviewToFront:self.label];
            self.dataSource = [AllProductModel mj_objectArrayWithKeyValuesArray:successResponse[@"data"]];
            self.label.text = [NSString stringWithFormat:@"共搜索出%lu条相关消息", self.dataSource.count];
            [self.collectionView reloadData];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络错误"];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self search:textField.text];
    return YES;
}

- (UIView *)leftView {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 35)];
    leftView.backgroundColor = RGB(224, 224, 224);
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
