//
//  MyZiLiaoViewController.m
//  家居定制
//
//  Created by iking on 2017/3/25.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "MyZiLiaoViewController.h"
#import "MyZiLiaoTableViewCell.h"
#import "changeNikeNameViewController.h"
#import "changePwdViewController.h"
#import "changeAddressViewController.h"
#import "phoneChangeViewController.h"
#import "DPPhotoGroupViewController.h"

@interface MyZiLiaoViewController ()<UITableViewDelegate, UITableViewDataSource, DPPhotoGroupViewControllerDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIImage *photoImg;

@end

@implementation MyZiLiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的资料";
    [self.view addSubview:self.myTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyZiLiaoTableViewCell *cell = [[MyZiLiaoTableViewCell alloc] init];
    cell.selectionStyle = NO;
    NSArray *array = @[@"修改昵称",@"更换手机号",@"修改密码",@"管理收货地址"];
    if (indexPath.row == 0) {
        [cell.textLB removeFromSuperview];
        [cell.arrow removeFromSuperview];
        UILabel *headLB = [UILabel labelWithText:@"点击更换头像" textColor:RGB(160, 160, 159) fontSize:16];
        [headLB sizeToFit];
        [cell.contentView addSubview:headLB];
        [headLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView).offset(-rateWidth(20));
        }];
        UIImageView *headImg = [UIImageView new];
        headImg.image = self.photoImg;
        headImg.backgroundColor = RGB(102, 212, 194);
        headImg.layer.masksToBounds = YES;
        headImg.layer.cornerRadius = rateWidth(20);
        [cell.contentView addSubview:headImg];
        [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.left.equalTo(cell.contentView).offset(rateWidth(20));
            make.size.mas_offset(CGSizeMake(rateWidth(40), rateWidth(40)));
        }];
    }
    if (indexPath.row != 0) {
        cell.textLB.text = array[indexPath.row-1];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return rateHeight(80);
    } else {
        return rateHeight(50);
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self selectImages];
            break;
        case 1: {
            changeNikeNameViewController *nicheng = [[changeNikeNameViewController alloc]init];
            [self.navigationController pushViewController:nicheng animated:YES];
            break;
        }
        case 2: {
            phoneChangeViewController *nicheng = [[phoneChangeViewController alloc]init];
            [self.navigationController pushViewController:nicheng animated:YES];
            break;
        }
        case 3: {
            changePwdViewController *nicheng = [[changePwdViewController alloc]init];
            [self.navigationController pushViewController:nicheng animated:YES];
            break;
        }
        case 4: {
            changeAddressViewController *nicheng = [[changeAddressViewController alloc]init];
            [self.navigationController pushViewController:nicheng animated:YES];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 选择图片
- (void)selectImages {
    DPPhotoGroupViewController *controller = [[DPPhotoGroupViewController alloc] init];
    controller.maxSelectionCount = 1;
    controller.delegate = self;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:controller] animated:YES completion:nil];
}
#pragma mark - DPPhotoGroupViewControllerDelegate
- (void)didSelectPhotos:(NSMutableArray *)photos {
    self.photoImg = photos[0];
    [_myTableView reloadData];
}
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = NO;
        _myTableView.scrollEnabled = NO;
    }
    return _myTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
