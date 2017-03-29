//
//  changeAddressViewController.m
//  TV
//
//  Created by HOME on 16/9/14.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "changeAddressViewController.h"
#import "AddressCell.h"
#import "AddAddressCell.h"
#import "AddressModel.h"

@interface changeAddressViewController ()<UIScrollViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
{
    int _currentHeight;
    int _height;
}
#define titleColor  RGB(51, 51, 51)
#define conColor   RGB(102, 102, 102)
#define smallColor   RGB(153, 153, 153)
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;///<<#注释#>
@property (nonatomic, assign) BOOL showIV;///< <#注释#>
@property (nonatomic, weak) UIView *toolView;///<<#注释#>
@property (nonatomic, assign) BOOL selectedAll;///< 全选
@property (nonatomic, weak) UIImageView *selectedAllIV;///<全选图片
@property (nonatomic, strong) NSMutableArray<AddressModel *> *addresses;///<地址数组
@property (nonatomic, strong) NSMutableArray<AddressModel *> *deleteArray;///<需要删除的地址
@end

@implementation changeAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    [self addRightItemWithImage:@"shanchu " action:@selector(deleteAddress)];
    [self addBackForUser];
    for (int i = 0; i < 6; i ++) {
        AddressModel *model = [[AddressModel alloc] init];
        model.address = @"天津市河西区富力中心大厦B座21层";
        model.contact = @"李先生";
        model.contactTel = @"022-85860201";
        [self.addresses addObject:model];
    }
    [self setupUI];
    self.selectIndexPath = [NSIndexPath indexPathForRow:CGFLOAT_MAX inSection:CGFLOAT_MAX];
    [self configToolView];
    [self loadData];
}
- (void)loadData {
    [[HttpRequestManager shareManager] addPOSTURL:@"/OrderShopping/showAll" person:RequestPersonWeiMing parameters:@{@"userId": [[NSUserDefaults standardUserDefaults] stringForKey:@"myUserId"]} success:^(id successResponse) {
        NSLog(@"%@", successResponse);
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
#pragma mark - 删除地址
- (void)deleteAddress {
    if (self.showIV) {
        [self addRightItemWithImage:@"shanchu " action:@selector(deleteAddress)];
        [UIView animateWithDuration:0.3 animations:^{
            self.toolView.top = kScreenHeight-64;
        } completion:^(BOOL finished) {
            NSArray *cells = [self.tableView visibleCells];
            for (UITableViewCell *cell in cells) {
                if ([cell isKindOfClass:[AddAddressCell class]]) {
//                    break;
                } else {
                    AddressCell *cel = (AddressCell *)cell;
                    cel.iv.hidden = YES;
                }
            }
            self.showIV = NO;
        }];
    } else {
        [self addRightItemWithTitle:@"完成" action:@selector(deleteAddress)];
        [UIView animateWithDuration:0.3 animations:^{
            self.toolView.top = kScreenHeight-114;
        } completion:^(BOOL finished) {
            NSArray *cells = [self.tableView visibleCells];
            for (UITableViewCell *cell in cells) {
                if ([cell isKindOfClass:[AddAddressCell class]]) {
//                    break;
                } else {
                    AddressCell *cel = (AddressCell *)cell;
                    cel.iv.hidden = NO;
                }
            }
            self.showIV = YES;
        }];
    }
}
- (void)configToolView {
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [toolView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toolViewTapped:)]];
    self.toolView = toolView;
    toolView.backgroundColor = RGBA(0, 0, 0, 0.3);
    toolView.top = kScreenHeight-64;
    [self.view addSubview:toolView];
    
    UILabel *label1 = [UILabel labelWithText:@"全选" textColor:UIColorWhite fontSize:18];
    label1.frame = CGRectMake(0, 0, kScreenWidth/2, 50);
    label1.textAlignment = NSTextAlignmentCenter;
    [toolView addSubview:label1];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(label1.right, 10, 1, 30)];
    line.backgroundColor = UIColorWhite;
    [toolView addSubview:line];
    
    UILabel *label2 = [UILabel labelWithText:@"删除" textColor:UIColorWhite fontSize:18];
    label2.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 50);
    label2.textAlignment = NSTextAlignmentCenter;
    [toolView addSubview:label2];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(rateWidth(30), 12, 25, 25)];
    iv.image = UIImageNamed(@"全选");
    iv.highlightedImage = UIImageNamed(@"全选选中");
    [toolView addSubview:iv];
    self.selectedAllIV = iv;
}
- (void)toolViewTapped:(UITapGestureRecognizer *)tap {
    CGFloat x = [tap locationInView:self.toolView].x;
    if (x < kScreenWidth/2) {
        self.selectedAll = !self.selectedAll;
        self.selectedAllIV.highlighted = !self.selectedAllIV.highlighted;
        if (self.selectedAll) {
            NSArray *cells = [self.tableView visibleCells];
            for (UITableViewCell *cell in cells) {
                if ([cell isKindOfClass:[AddAddressCell class]]) {
//                    break;
                } else {
                    AddressCell *cel = (AddressCell *)cell;
                    cel.iv.highlighted = YES;
                }
            }
        } else {
            NSArray *cells = [self.tableView visibleCells];
            for (UITableViewCell *cell in cells) {
                if ([cell isKindOfClass:[AddAddressCell class]]) {
//                    break;
                } else {
                    AddressCell *cel = (AddressCell *)cell;
                    cel.iv.highlighted = NO;
                }
            }
        }
    } else {
        if (self.selectedAll) {
            [self.addresses removeAllObjects];
        }
        if (self.deleteArray.count > 0) {
            [self.addresses removeObjectsInArray:self.deleteArray];
            [self.deleteArray removeAllObjects];
        }
        [self.tableView reloadData];
    }
}

- (void)setupUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColorWhite;
    [self.tableView registerClass:[AddressCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[AddAddressCell class] forCellReuseIdentifier:@"cell1"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.addresses.count+1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.addresses.count) {
        AddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        [cell.addAddressBtn addActionHandler:^{
            AddAddressViewController *controller = [[AddAddressViewController alloc] init];
            controller.callBack = ^(AddressModel *model){
                [self.addresses addObject:model];
                [tableView reloadData];
            };
            [self pushViewController:controller animation:YES];
        }];
        return cell;
    }
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.contact.text = self.addresses[indexPath.section].contact;
    cell.address.text = self.addresses[indexPath.section].address;
    cell.contactTel.text = self.addresses[indexPath.section].contactTel;

    [cell.iv whenTapped:^{
        cell.iv.highlighted = !cell.iv.highlighted;
        if (cell.iv.highlighted) {
            [self.deleteArray addObject:self.addresses[indexPath.section]];
        } else {
            [self.deleteArray removeObject:self.addresses[indexPath.section]];
        }
    }];
    if (indexPath.section == self.selectIndexPath.section && indexPath.row == self.selectIndexPath.row) {
        cell.border.highlighted = YES;
    } else {
        cell.border.highlighted = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.addresses.count) {
        return 100;
    }
    return 175;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != self.addresses.count) {
        AddressCell *oldCell = [tableView cellForRowAtIndexPath:self.selectIndexPath];
        oldCell.border.highlighted = NO;
        AddressCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.border.highlighted = YES;
        self.selectIndexPath = indexPath;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != self.addresses.count) {
        AddressCell *cel = (AddressCell *)cell;
        if (self.showIV) {
            cel.iv.hidden = NO;
            if (self.selectedAll) {
                cel.iv.highlighted = YES;
            } else {
                cel.iv.highlighted = NO;
            }
        } else {
            cel.iv.hidden = YES;
        }
        if ([self.deleteArray containsObject:self.addresses[indexPath.section]]) {
            cel.iv.highlighted = YES;
        } else {
            cel.iv.highlighted = NO;
        }
    }
}

- (NSMutableArray<AddressModel *> *)addresses {
    if (!_addresses) {
        _addresses = [NSMutableArray array];
    }
    return _addresses;
}

- (NSMutableArray<AddressModel *> *)deleteArray {
    if (!_deleteArray) {
        _deleteArray = [NSMutableArray array];
    }
    return _deleteArray;
}

@end
