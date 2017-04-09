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

typedef NS_ENUM(NSInteger, SceneType) {
    SceneTypeAll,          ///< 全部
    SceneTypeRoom,         ///< 卧室
    SceneTypeKitchen,      ///< 厨房
    SceneTypeLivingRoom,   ///< 客厅
    SceneTypeStudy,        ///< 书房
    SceneTypeBalcony,      ///< 阳台
    SceneTypeBathRoom,     ///< 卫浴
    SceneTypeDIY           ///< DIY
};

@interface ShowSceneViewController ()<iCarouselDataSource, iCarouselDelegate, SceneShowViewDelegate>

@property (nonatomic, weak) iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray<HomeContentModel *> *items;
@property (nonatomic, strong) NSMutableArray<NSString *> *months;///<<#注释#>
@property (nonatomic, strong) NSMutableArray<NSString *> *days;///<<#注释#>
@property (nonatomic, assign) SceneType sceneType;///< <#注释#>
@end

@implementation ShowSceneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"场景展示";
    self.view.backgroundColor = RGB(224, 249, 246);
    [self setupUI];
    [self loadData:SceneTypeAll];
}
- (void)loadData:(SceneType)type {
    [[HttpRequestManager shareManager] addPOSTURL:@"/Content/list" person:RequestPersonYuChuan parameters:@{@"type": @(type)} success:^(id successResponse) {
        NSLog(@"%@", successResponse);
        self.items = [HomeContentModel mj_objectArrayWithKeyValuesArray:successResponse[@"data"]];
        [self.carousel reloadData];
        [self setupLeftDataSource];
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)setupLeftDataSource {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger flags = NSCalendarUnitMonth | NSCalendarUnitDay;
    for (HomeContentModel *model in self.items) {
        
        NSDate *date = [formatter dateFromString:model.updated];
        
        comps = [calendar components:flags fromDate:date];
        NSInteger month = [comps month];
        NSInteger day = [comps day];
        [self.months addObject:[NSString stringWithFormat:@"%ld月", month]];
        [self.days addObject:[NSString stringWithFormat:@"%ld月", day]];
    }
    [self.tableView reloadData];
}
- (void)setupUI {
    SceneShowView *sceneView = [[SceneShowView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    sceneView.delegate = self;
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
    
    iCarousel *icarouse = [[iCarousel alloc] initWithFrame:CGRectMake(leftTableView.right+20, sceneView.bottom, kScreenWidth-leftTableView.right-20, kScreenHeight-64-35)];
    self.carousel = icarouse;
//    icarouse.backgroundColor = [UIColor blueColor];
    icarouse.type = iCarouselTypeRotary;
    icarouse.vertical = YES;
    icarouse.delegate = self;
    icarouse.dataSource = self;
    [self.view addSubview:icarouse];
}

#pragma mark - SceneShowViewDelegate
- (void)sceneShow:(SceneShowView *)view didSelectIndex:(NSInteger)index {
    [self loadData:index];
}

#pragma mark - iCarousel dataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.items.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *backgroundImageView = nil;
    UILabel *date = nil;
    UILabel *title = nil;
    UILabel *subTitle = nil;
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-self.tableView.right, 200.0f)];
        backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(150))];
        [backgroundImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, self.items[index].pic]] placeholderImage:nil];
        backgroundImageView.backgroundColor = [UIColor blueColor];
        [view addSubview:backgroundImageView];
        
        UIImageView *borderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rateWidth(130), 70)];
        borderImageView.image = UIImageNamed(@"kuang");
        borderImageView.centerX = view.centerX;
        borderImageView.top = rateHeight(30);
        [view addSubview:borderImageView];
        
        date = [UILabel labelWithText:@"MYY-20" textColor:UIColorWhite fontSize:12];
        [date sizeToFit];
        date.centerX = view.centerX;
        date.top = rateHeight(25);
        [view addSubview:date];
        
        title = [UILabel labelWithText:@"" textColor:UIColorWhite fontSize:12];
        title.textAlignment = NSTextAlignmentCenter;
        title.frame = CGRectMake(0, date.bottom+10, 100, 12);
        title.centerX = view.centerX;
        [view addSubview:title];
        
        subTitle = [UILabel labelWithText:@"" textColor:UIColorWhite fontSize:12];
        subTitle.textAlignment = NSTextAlignmentCenter;
        subTitle.frame = CGRectMake(0, title.bottom+10, 100, 12);
        subTitle.centerX = view.centerX;
        [view addSubview:subTitle];
        
        title.text = self.items[index].title;
        subTitle.text = self.items[index].subTitle;
    } else {
        title.text = self.items[index].title;
        subTitle.text = self.items[index].subTitle;
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
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

- (NSMutableArray<NSString *> *)months {
    if (!_months) {
        _months = [NSMutableArray array];
    }
    return _months;
}
- (NSMutableArray<NSString *> *)days {
    if (!_days) {
        _days = [NSMutableArray array];
    }
    return _days;
}

@end
