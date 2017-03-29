//
//  ShowSceneViewController.m
//  TV
//
//  Created by HOME on 16/10/17.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "ShowSceneViewController.h"
#import "SceneShowView.h"
#import "SceneLeftCell.h"
#import "ScrollLayout.h"
#import "SceneShowCell.h"
#import "iCarousel.h"

@interface ShowSceneViewController ()<iCarouselDataSource, iCarouselDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSArray *months;///<<#注释#>
@end

@implementation ShowSceneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"场景展示";
    self.view.backgroundColor = RGB(224, 249, 246);
    self.months = @[@"1月", @"2月", @"3月", @"4月", @"5月", @"6月", @"7月", @"8月", @"9月", @"10月", @"11月", @"12月"];
    [self setupUI];
//    [self loadData];
}
- (void)loadData {
    [[HttpRequestManager shareManager] addPOSTURL:@"/Content/ById" person:RequestPersonYuChuan parameters:@{@"category_id": self.model.categoryId} success:^(id successResponse) {
//        NSLog(@"%@", successResponse);
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setupUI {
    SceneShowView *sceneView = [[SceneShowView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    [self.view addSubview:sceneView];
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, sceneView.bottom, 60, kScreenHeight-64-35) style:UITableViewStyleGrouped];
    self.tableView = leftTableView;
    leftTableView.showsVerticalScrollIndicator = NO;
    [leftTableView registerClass:[SceneLeftCell class] forCellReuseIdentifier:@"cell"];
    leftTableView.dataSource = self;
    leftTableView.delegate = self;
    leftTableView.backgroundColor = [UIColor clearColor];
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:leftTableView];
    
    /*
    iCarousel *carousel = [[iCarousel alloc] initWithFrame:CGRectMake(leftTableView.right+20, sceneView.bottom, kScreenWidth-leftTableView.right-20, kScreenHeight-64-35)];
    carousel.type = iCarouselTypeRotary;
    carousel.vertical = YES;
    carousel.delegate = self;
    carousel.dataSource = self;
//    carousel.backgroundColor = [UIColor redColor];
    [self.view addSubview:carousel];
     */
    
//    ScrollLayout *flowLayout = [[ScrollLayout alloc] init];
//    flowLayout.itemSize = CGSizeMake(kScreenWidth-leftTableView.right-20, rateHeight(175));
//    flowLayout.minimumInteritemSpacing = 0;
//    flowLayout.minimumLineSpacing = -50;
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(leftTableView.right+20, sceneView.bottom, kScreenWidth-leftTableView.right-20, kScreenHeight-64-35) collectionViewLayout:flowLayout];
//    collectionView.backgroundColor = [UIColor whiteColor];
//    [collectionView registerClass:[SceneShowCell class] forCellWithReuseIdentifier:@"cell"];
//    collectionView.dataSource = self;
//    collectionView.delegate = self;
//    [self.view addSubview:collectionView];
    
    self.items = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        [self.items addObject:@(i)];
    }
    iCarousel *icarouse = [[iCarousel alloc] initWithFrame:CGRectMake(leftTableView.right+20, sceneView.bottom, kScreenWidth-leftTableView.right-20, kScreenHeight-64-35)];
//    icarouse.backgroundColor = [UIColor blueColor];
    icarouse.type = iCarouselTypeRotary;
    icarouse.vertical = YES;
    icarouse.delegate = self;
    icarouse.dataSource = self;
    [self.view addSubview:icarouse];
}

#pragma mark - iCarousel dataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.items.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-self.tableView.right-20, 200.0f)];
        //        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.backgroundColor = RGBA(arc4random()%255, arc4random()%255, arc4random()%255, arc4random()%255);
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        //        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [_items[index] stringValue];
    return view;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.months.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SceneLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 65;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [UILabel labelWithText:@"" textColor:UIColorBlack fontSize:18];
    label.frame = CGRectMake(0, 0, 60, 65);
    label.text = [NSString stringWithFormat:@"  %@", self.months[section]];
    return label;
}

- (void)setUp
{
    //set up data
    _wrap = YES;
    self.items = [NSMutableArray array];
    for (int i = 0; i < 5; i++)
    {
        [_items addObject:@(i)];
    }
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
//    {
////        [self setUp];
//    }
//    return self;
//}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}
#pragma mark -
#pragma mark View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
 
}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return YES;
//}

@end
