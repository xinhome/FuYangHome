//
//  SystemMsgViewController.m
//  家居定制
//
//  Created by iKing on 2017/3/18.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "SystemMsgViewController.h"
#import "SystemMsgCell.h"

@interface SystemMsgViewController ()

@end

@implementation SystemMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统消息";
    [self addBackForUser];
    [self setupUI];
}

- (void)setupUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    [self.tableView registerClass:[SystemMsgCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.content = @"系统更新通知：尊敬的用户，为了使您更好的体验我们的产品；，我们全新退出了2.0版本，画面更加细致，使用起来更加便捷系统更新通知：尊敬的用户，为了使您更好的体验我们的产品；，我们全新退出了2.0版本，画面更加细致，使用起来更加便捷";
    cell.longPressAction = ^{
        
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SystemMsgCell heightForContent:@"系统更新通知：尊敬的用户，为了使您更好的体验我们的产品；，我们全新退出了2.0版本，画面更加细致，使用起来更加便捷系统更新通知：尊敬的用户，为了使您更好的体验我们的产品；，我们全新退出了2.0版本，画面更加细致，使用起来更加便捷"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemMsgCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.menu setMenuVisible:NO animated:YES];
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
