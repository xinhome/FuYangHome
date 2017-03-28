//
//  ProductViewController.m
//  TV
//
//  Created by HOME on 16/9/12.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "ProductViewController.h"
#import "AllProductModel.h"
#import "AllProductCell.h"

@interface ProductViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;///<<#注释#>
@property (nonatomic, strong) NSMutableArray<AllProductModel *> *dataSource;///<<#注释#>
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"所有产品";
    [self loadData];
    
    [self setupUI];
}

- (void)loadData {
    [MBProgressHUD showMessage:@"正在加载.." toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/Content/ById" person:RequestPersonWeiMing parameters:@{@"id": self.categoryId} success:^(id successResponse) {
        NSLog(@"%@", successResponse);
        [MBProgressHUD hideHUDForView:self.view];
        self.dataSource = [AllProductModel mj_objectArrayWithKeyValuesArray:successResponse[@"data"][@"items"]];
        [self.collectionView reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络错误"];
    }];
}

- (void)setupUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(rateWidth(165), rateWidth(165)+5+14+14);
    flowLayout.sectionInset = UIEdgeInsetsMake(17, rateWidth(15), 0, rateWidth(15));
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = UIColorWhite;
    [collectionView registerClass:[AllProductCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
}

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

@end
