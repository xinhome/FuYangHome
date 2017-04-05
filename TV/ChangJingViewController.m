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
#import <ShareSDKUI/ShareSDKUI.h>
@interface ChangJingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (strong, nonatomic) IBOutlet UILabel *praiseLabel;
@property (nonatomic, strong)NSMutableArray<ChangJingModel *> *dataSource;
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, copy) NSString *scenceId;
@end

@implementation ChangJingViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    NSArray *arr = [self.collectionView visibleCells];
    for (ChangJingCell *cell in arr) {
        for (WPWaveRippleView *dotView in cell.dots) {
            [dotView startAnimating];
        }
    }
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
//        NSLog(@"%@", successResponse);
        NSArray *scenes = successResponse[@"data"][@"scenes"];
        self.dataSource = [ChangJingModel mj_objectArrayWithKeyValuesArray:scenes];
        self.praiseLabel.text = self.dataSource[0].likes;
        self.commentLabel.text = [NSString stringWithFormat:@"%lu", self.dataSource[0].scenesComments.count];
        [self.collectionView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setupUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight+64+60) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = huiseColor;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    [collectionView registerClass:[ChangJingCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    [self setupToolView];
}

- (void)setupToolView {
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChangJingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.item];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f", scrollView.contentOffset.x/kScreenWidth);
    int index = (int)scrollView.contentOffset.x/kScreenWidth;
    self.scenceId = self.dataSource[index].scenesId;
    self.praiseLabel.text = self.dataSource[index].likes;
    self.commentLabel.text = [NSString stringWithFormat:@"%lu", self.dataSource[index].scenesComments.count];
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)LookAtAll:(id)sender {
    ProductViewController *Pro= [[ProductViewController alloc]init];
    Pro.categoryId = self.model.ID;
    [self.navigationController pushViewController:Pro animated:YES];
}

- (IBAction)comment:(id)sender {
    CommonViewController *controller = [[CommonViewController alloc]init];
    if (self.scenceId == nil) {
        self.scenceId = self.dataSource[0].scenesId;
    }
    controller.commentSuccess = ^{
        int value = [self.commentLabel.text intValue];
        value ++;
        self.commentLabel.text = [NSString stringWithFormat:@"%d", value];
    };
    controller.scenceId = self.scenceId;
    [self.navigationController pushViewController:controller    animated:YES];
}

/**
 分享

 @param sender
 */
- (IBAction)share:(id)sender {
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:nil
                                        url:[NSURL URLWithString:@"http://www.mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        
    }];
}

- (IBAction)dianzan:(id)sender {
    NSLog(@"*********");
    if (self.scenceId == nil) {
        self.scenceId = self.dataSource[0].scenesId;
    }
    [[HttpRequestManager shareManager] addPOSTURL:@"/Scenes/like" person:RequestPersonWeiMing parameters:@{@"id": self.scenceId} success:^(id successResponse) {
        if ([successResponse isSuccess]) {
            int value = [self.praiseLabel.text intValue];
            value ++;
            self.praiseLabel.text = [NSString stringWithFormat:@"%d", value];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD showError:@"网络错误"];
    }];
}

- (NSMutableArray<ChangJingModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
