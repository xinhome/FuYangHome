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
#import "ChangJingViewController.h"

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
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSArray *> *dataSource;///<<#注释#>
@property (nonatomic, strong) NSMutableArray<NSString *> *days;///<<#注释#>
@property (nonatomic, assign) SceneType sceneType;///< <#注释#>
@property (nonatomic, copy) NSString *selectedDate;
@end

@implementation ShowSceneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"场景展示";
    self.view.backgroundColor = RGB(224, 249, 246);
    [self setupUI];
    self.selectedDate = @"00-00";
    [self loadDataWithType:SceneTypeAll date:self.selectedDate];
}
- (void)loadDataWithType:(SceneType)type date:(NSString *)date {
    [[HttpRequestManager shareManager] addPOSTURL:@"/Content/list/first" person:RequestPersonWeiMing parameters:@{@"time": date, @"type": @(type)} success:^(id successResponse) {
        NSArray *data = successResponse[@"data"];
        self.items = [HomeContentModel mj_objectArrayWithKeyValuesArray:data];
        if (type == SceneTypeAll && [date isEqualToString:@"00-00"]) {
            [self.dataSource removeAllObjects];
            [self.days removeAllObjects];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            NSInteger flags = NSCalendarUnitMonth | NSCalendarUnitDay;
            NSMutableArray *array = [NSMutableArray array];
            for (HomeContentModel *model in self.items) {
                [array addObject:model.created];
            }
            
            for (NSString *created in array) {
                NSDate *date = [formatter dateFromString:created];
                comps = [calendar components:flags fromDate:date];
                NSInteger month = [comps month];
                NSInteger day = [comps day];
                if (![self.dataSource.allKeys containsObject:[NSString stringWithFormat:@"%ld", month]]) {
                    self.dataSource[[NSString stringWithFormat:@"%ld月", month]] = self.days;
                }
            }
            
            for (HomeContentModel *model in self.items) {
                NSDate *date = [formatter dateFromString:model.created];
                comps = [calendar components:flags fromDate:date];
                NSInteger month = [comps month];
                NSInteger day = [comps day];
                for (NSString *key in self.dataSource.allKeys) {
                    if ([key isEqualToString:[NSString stringWithFormat:@"%ld月", month]]) {
                        if (![self.days containsObject:[NSString stringWithFormat:@"%ld日", day]]) {
                            [self.days addObject:[NSString stringWithFormat:@"%02ld.%02ld",  month, day]];
                        }
                    }
                    [self.days sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                        return [obj2 compare:obj1];
                    }];
                    self.dataSource[key] = self.days;
                }
                
            }
            [self.carousel reloadData];
            [self.tableView reloadData];
        } else {
            [self.carousel reloadData];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
//    [[HttpRequestManager shareManager] addPOSTURL:@"/Content/list" person:RequestPersonYuChuan parameters:@{@"type": @(type)} success:^(id successResponse) {
//        NSLog(@"%@", successResponse);
//        self.items = [HomeContentModel mj_objectArrayWithKeyValuesArray:successResponse[@"data"]];
//        [self.carousel reloadData];
//        [self setupLeftDataSource];
//    } fail:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
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
        if (![self.dataSource.allKeys containsObject:[NSString stringWithFormat:@"%ld月", month]]) {
            [self.days addObject:[NSString stringWithFormat:@"%ld", day]];
//            [self.dataSource addObject:[NSString stringWithFormat:@"%ld月", month]];
//            self.dataSource[[NSString stringWithFormat:@"%ld", month]] =
        }
        
//        [self.days addObject:[NSString stringWithFormat:@"%ld月", day]];
    }
    for (HomeContentModel *model in self.items) {
        NSDate *date = [formatter dateFromString:model.updated];
        
        comps = [calendar components:flags fromDate:date];
        NSInteger monthNumber = [comps month];
        NSInteger dayNumber = [comps day];
        for (NSString *month in self.dataSource) {
            
            if ([month isEqualToString:[NSString stringWithFormat:@"%ld月", (long)monthNumber]]) {
                [self.days addObject:[NSString stringWithFormat:@"%02ld%02ld", monthNumber, dayNumber]];
            }
            
        }
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
//    icarouse.bounces = NO;
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
    self.sceneType = index;
    if (index == 0) {
        self.selectedDate = @"00-00";
    }
    [self loadDataWithType:index date:self.selectedDate];
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
        backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200.0f)];
        [backgroundImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, self.items[index].pic]] placeholderImage:UIImageNamed(@"scence-placeholder")];
        [view addSubview:backgroundImageView];
        
        UIImageView *borderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rateWidth(130), 70)];
        borderImageView.image = UIImageNamed(@"kuang");
        borderImageView.centerX = view.centerX;
        borderImageView.top = rateHeight(30);
        [view addSubview:borderImageView];
        
        date = [UILabel labelWithText:@"MAY-20" textColor:UIColorWhite fontSize:12];
        [date sizeToFit];
        date.centerX = view.centerX;
        date.top = rateHeight(25);
        [view addSubview:date];
        date.text = [self translateDate:self.items[index].updated];
        
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
        [backgroundImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, self.items[index].pic]] placeholderImage:UIImageNamed(@"scence-placeholder")];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    ChangJingViewController *controller = [[ChangJingViewController alloc] init];
    controller.model = self.items[index];
    [self pushViewController:controller animation:YES];
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    
    NSLog(@"%ld", carousel.currentItemIndex);
}

//- carouselscroll

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataSource.allValues[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SceneLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *array = self.dataSource.allValues[indexPath.section];
    cell.date.text = array[indexPath.row];
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
    label.text = [NSString stringWithFormat:@"  %@", self.dataSource.allKeys[section]];
    return label;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = self.dataSource.allValues[indexPath.section];
    NSString *date = array[indexPath.row];
    date = [date stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    self.selectedDate = date;
    [self loadDataWithType:self.sceneType date:date];
}
- (NSString *)translateDate:(NSString *)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger flags = NSCalendarUnitMonth | NSCalendarUnitDay;
    comps = [calendar components:flags fromDate:date];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    switch (month) {
        case 1:
            return [NSString stringWithFormat:@"Jan-%02ld", day];
        case 2:
            return [NSString stringWithFormat:@"Feb-%02ld", day];
        case 3:
            return [NSString stringWithFormat:@"Mar-%02ld", day];
        case 4:
            return [NSString stringWithFormat:@"Apr-%02ld", day];
        case 5:
            return [NSString stringWithFormat:@"May-%02ld", day];
        case 6:
            return [NSString stringWithFormat:@"Jun-%02ld", day];
        case 7:
            return [NSString stringWithFormat:@"Jul-%02ld", day];
        case 8:
            return [NSString stringWithFormat:@"Aug-%02ld", day];
        case 9:
            return [NSString stringWithFormat:@"Sep-%02ld", day];
        case 10:
            return [NSString stringWithFormat:@"Oct-%02ld", day];
        case 11:
            return [NSString stringWithFormat:@"Nov-%02ld", day];
        default:
            return [NSString stringWithFormat:@"Dec-%02ld", day];
            break;
    }
}

- (NSMutableDictionary<NSString *,NSArray *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableDictionary dictionary];
    }
    return _dataSource;
}
- (NSMutableArray<NSString *> *)days {
    if (!_days) {
        _days = [NSMutableArray array];
    }
    return _days;
}

@end
