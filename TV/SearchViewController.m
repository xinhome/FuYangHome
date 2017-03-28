//
//  SearchViewController.m
//  家居定制
//
//  Created by iKing on 2017/3/18.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#define SearchRecords @"SearchRecords"

#import "SearchViewController.h"

@interface SearchViewController ()
@property (nonatomic, strong) NSMutableArray *searchRecords;
@property (nonatomic, weak) UITableView *searchResultTableView;///<搜索结果
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
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
        } else {
            cell.textLabel.text = [NSString stringWithFormat:@" %@", self.searchRecords[indexPath.row-1]];
        }
        cell.textLabel.textColor = RGB(126, 126, 126);
    } else {
        cell.textLabel.text = @"";
        cell.backgroundColor = UIColorWhite;
        if (![cell.contentView viewWithTag:1002]) {
            if ([cell viewWithTag:1001]) {
                [[cell viewWithTag:1001] removeFromSuperview];
            }
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, rateWidth(340), 35)];
            btn.center = cell.contentView.center;
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

- (void)deleteSearchRecords {
    [self.searchRecords removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setObject:self.searchRecords forKey:SearchRecords];
    [self.tableView reloadData];
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
        [searchBar resignFirstResponder];
        [self.searchRecords addObject:searchBar.text];
        [[NSUserDefaults standardUserDefaults] setObject:self.searchRecords forKey:SearchRecords];
        [self.tableView reloadData];
    }];
    search.frame = CGRectMake(searchBar.right, 0, 50, 17);
    search.centerY = view.centerY;
    [view addSubview:search];
    self.navigationItem.titleView = view;
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
