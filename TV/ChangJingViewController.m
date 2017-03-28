//
//  ChangJingViewController.m
//  TV
//
//  Created by HOME on 16/9/12.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "ChangJingViewController.h"
#import "ProductViewController.h"
#import "WPWaveRippleView.h"
#import "ChangJingCell.h"
#import "ChangJingModel.h"
@interface ChangJingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)NSMutableArray<ChangJingModel *> *dataSource;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) WPWaveRippleView *waveRippleView;
@end

@implementation ChangJingViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self.view bringSubviewToFront:_buttomView];
    [self.view bringSubviewToFront:_backBtn];
    _buttomView.backgroundColor = RGB(51, 51, 51);
    _buttomView.alpha = 0.8;
    [self loadData];
}
- (void)loadData {
    [[HttpRequestManager shareManager] addPOSTURL:@"/Content/ByScenesId" person:RequestPersonWeiMing parameters:@{@"id": self.model.ID} success:^(id successResponse) {
        NSLog(@"%@", successResponse);
        NSArray *scenes = successResponse[@"data"][@"scenes"];
        self.dataSource = [ChangJingModel mj_objectArrayWithKeyValuesArray:scenes];
        
        [self.collectionView reloadData];
//        for (int i = 0; i<self.imageArr.count; i++) {
//            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
//            [image sd_setImageWithURL:[NSURL URLWithString:self.imageArr[i]]];
//            //[_scrollView addSubview:image];
//            
//            self.waveRippleView = [[WPWaveRippleView alloc] initWithTintColor:RGB(80, 197, 176) minRadius:3 waveCount:5 timeInterval:1 duration:4];
//            self.waveRippleView.frame = CGRectMake(100+kScreenWidth*i, 300, 50, 50);
//            //[_scrollView addSubview:[self waveRippleView]];
//            [[self waveRippleView] startAnimating];
//        }
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setupUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = self.view.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = huiseColor;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    [collectionView registerClass:[ChangJingCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChangJingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.item];
    return cell;
}


- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)LookAtAll:(id)sender {
    ProductViewController *Pro= [[ProductViewController alloc]init];
    Pro.categoryId = self.model.categoryId;
    [self.navigationController pushViewController:Pro animated:YES];
}

- (IBAction)comment:(id)sender {
    CommonViewController *controller = [[CommonViewController alloc]init];
    [self.navigationController pushViewController:controller    animated:YES];
}

- (IBAction)dianzan:(id)sender {
}

- (NSMutableArray<ChangJingModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
