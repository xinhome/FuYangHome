//
//  HomeCell.m
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCellButton : UIView
@property (nonatomic, weak) UIImageView *imageView;///<图片
@property (nonatomic, weak) UILabel *title;///<标题
@property (nonatomic, weak) UILabel *price;///<价格
@end

@implementation HomeCellButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-30)];
        self.imageView = imageView;
        imageView.backgroundColor = [UIColor redColor];
        [self addSubview:imageView];
        
        UILabel *title = [UILabel labelWithText:@"" textColor:UIColorBlack fontSize:13];
        self.title = title;
        title.textAlignment = NSTextAlignmentCenter;
        title.frame = CGRectMake(0, imageView.bottom+2, self.width, 13);
        [self addSubview:title];
        
        UILabel *price = [UILabel labelWithText:@"" textColor:[UIColor redColor] fontSize:14];
        self.price = price;
        price.textAlignment = NSTextAlignmentCenter;
        price.frame = CGRectMake(0, title.bottom, self.width, 14);
        [self addSubview:price];
    }
    return self;
}

@end


@interface HomeCell ()

@property (nonatomic, weak) UILabel *date;///<<#注释#>
@property (nonatomic, weak) UILabel *title;///<<#注释#>
@property (nonatomic, weak) UILabel *subTitle;///<<#注释#>
@property (nonatomic, strong) NSMutableArray<HomeCellButton *> *btns;///<<#注释#>
@end

@implementation HomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(150))];
        self.backgroundImageView = backgroundImageView;
        backgroundImageView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:backgroundImageView];
        CGFloat height = rateHeight(150);
        for (int i = 0; i < 6; i ++) {
            HomeCellButton *btn = [[HomeCellButton alloc] initWithFrame:CGRectMake(kScreenWidth/3*(i%3), backgroundImageView.bottom+height*(i/3), kScreenWidth/3, height)];
            [btn whenTapped:^{
                self.itemTapped(@(i));
            }];
            [self addSubview:btn];
            [self.btns addObject:btn];
        }
        
        UIImageView *borderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 65)];
        borderImageView.image = UIImageNamed(@"kuang");
        borderImageView.centerX = kScreenWidth/2;
        borderImageView.top = rateHeight(30);
        [self.contentView addSubview:borderImageView];
        
        UILabel *date = [UILabel labelWithText:@"MAY-20" textColor:UIColorWhite fontSize:12];
        self.date = date;
        [date sizeToFit];
        date.centerX = kScreenWidth/2;
        date.top = rateHeight(25);
        [self.contentView addSubview:date];
        
        UILabel *title = [UILabel labelWithText:@"复古田园风格客厅装饰" textColor:UIColorWhite fontSize:12];
        self.title = title;
        title.textAlignment = NSTextAlignmentCenter;
        title.frame = CGRectMake(0, date.bottom+10, 100, 12);
        title.centerX = kScreenWidth/2;
        [self.contentView addSubview:title];
        
        UILabel *subTitle = [UILabel labelWithText:@"【客厅天地】" textColor:UIColorWhite fontSize:12];
        self.subTitle = subTitle;
        subTitle.textAlignment = NSTextAlignmentCenter;
        subTitle.frame = CGRectMake(0, title.bottom+10, 100, 12);
        subTitle.centerX = kScreenWidth/2;
        [self.contentView addSubview:subTitle];
        
        UIImageView *more = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        self.moreImageView = more;
        more.image = UIImageNamed(@"more");
        more.right = kScreenWidth-10;
        more.bottom = backgroundImageView.bottom-10;
        [self.contentView addSubview:more];
    }
    return self;
}

- (void)setModel:(HomeContentModel *)model {
    _model = model;
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, model.pic]]];
    self.date.text = [self translateDate:model.updated];
    self.title.text = model.titleDesc;
    self.subTitle.text = model.title;
    NSInteger count = model.items.count;
    if (model.items.count > 6) {
        count = 6;
    }
    for (int i = 0; i < count; i ++) {
        NSString *url = [model.items[i].image componentsSeparatedByString:@","].firstObject;
        self.btns[i].title.text = model.items[i].title;
        self.btns[i].price.text = [NSString stringWithFormat:@"%@￥", model.items.firstObject.price];
        [self.btns[i].imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, url]]];
    }
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
            return [NSString stringWithFormat:@"Jan-%ld", day];
        case 2:
            return [NSString stringWithFormat:@"Feb-%ld", day];
        case 3:
            return [NSString stringWithFormat:@"Mar-%ld", day];
        case 4:
            return [NSString stringWithFormat:@"Apr-%ld", day];
        case 5:
            return [NSString stringWithFormat:@"May-%ld", day];
        case 6:
            return [NSString stringWithFormat:@"Jun-%ld", day];
        case 7:
            return [NSString stringWithFormat:@"Jul-%ld", day];
        case 8:
            return [NSString stringWithFormat:@"Aug-%ld", day];
        case 9:
            return [NSString stringWithFormat:@"Sep-%ld", day];
        case 10:
            return [NSString stringWithFormat:@"Oct-%ld", day];
        case 11:
            return [NSString stringWithFormat:@"Nov-%ld", day];
        default:
            return [NSString stringWithFormat:@"Dec-%ld", day];
            break;
    }
}

- (NSMutableArray<HomeCellButton *> *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

@end
