//
//  OneTableViewCell.m
//  TV
//
//  Created by HOME on 16/8/23.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "OneTableViewCell.h"

@interface OneTableViewCell ()
@property (nonatomic, strong) NSMutableArray<UIImageView *> *ivs;///<<#注释#>
@property (nonatomic, weak) UILabel *day;///<<#注释#>
@property (nonatomic, weak) UILabel *month;///<<#注释#>
@property (nonatomic, weak) UILabel *title;///<<#注释#>
@property (nonatomic, weak) UIButton *commonBtn;///<<#注释#>

@property (nonatomic, weak) UILabel *desc;///<<#注释#>
@end

@implementation OneTableViewCell
- (void)prepareForReuse {
    [super prepareForReuse];
    for (UIImageView *iv in self.ivs) {
        iv.hidden = YES;
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *dateView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 50, 65)];
        dateView.image = UIImageNamed(@"time");
        [self.contentView addSubview:dateView];
        
        UILabel *day = [UILabel labelWithText:@"24" textColor:UIColorBlack fontSize:20];
        _day = day;
        day.textAlignment = NSTextAlignmentCenter;
        day.frame = CGRectMake(dateView.left, dateView.top+15, dateView.width, 20);
        [self.contentView addSubview:day];
        
        UILabel *month = [UILabel labelWithText:@"Jun" textColor:UIColorBlack fontSize:16];
        _month = month;
        month.textAlignment = NSTextAlignmentCenter;
        month.frame = CGRectMake(dateView.left, day.bottom+10, dateView.width, 16);
        [self.contentView addSubview:month];
        
        for (int i = 0; i < 3; i ++) {
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(dateView.right+10+rateWidth(95)*i, dateView.top, rateWidth(90), rateHeight(135))];
            iv.hidden = YES;
            iv.layer.cornerRadius = 7;
            iv.layer.masksToBounds = YES;
            [self.contentView addSubview:iv];
            [self.ivs addObject:iv];
        }
        
        UILabel *title = [UILabel labelWithText:@"客厅------几款现代自然的客厅装修" textColor:UIColorBlack fontSize:16];
        _title = title;
        title.frame = CGRectMake(dateView.right+10, self.ivs.firstObject.bottom+15, kScreenWidth-dateView.right-20, 16);
        [self.contentView addSubview:title];
        
//        UILabel *desc = [UILabel labelWithText:@"" textColor:RGB(121, 121, 121) fontSize:16];
//        _desc = desc;
//        desc.numberOfLines = 2;
//        desc.frame = CGRectMake(title.left, title.bottom+3, title.width, 40);
//        [self.contentView addSubview:desc];
        
        UIButton *common = [UIButton buttonWithTitle:@"0" fontSize:17 titleColor:RGB(150, 150, 150) background:UIColorWhite cornerRadius:0];
        self.commonBtn = common;
        common.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [common setImage:UIImageNamed(@"comment1") forState:UIControlStateNormal];
        common.frame = CGRectMake(rateWidth(80), title.bottom+10, 80, 35);
        [self.contentView addSubview:common];
        
        UIButton *praise = [UIButton buttonWithTitle:@"0" fontSize:17 titleColor:RGB(150, 150, 150) background:UIColorWhite cornerRadius:0];
        self.pariseBtn = praise;
        praise.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [praise setImage:UIImageNamed(@"favor1") forState:UIControlStateNormal];
        praise.frame = CGRectMake(common.right+3, title.bottom+10, 80, 35);
        [self.contentView addSubview:praise];
        
        UIButton *share = [UIButton buttonWithTitle:@"" fontSize:17 titleColor:RGB(150, 150, 150) background:UIColorWhite cornerRadius:0];
        share.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [share setImage:UIImageNamed(@"share") forState:UIControlStateNormal];
        share.frame = CGRectMake(praise.right+3, title.bottom+10, 80, 35);
        [self.contentView addSubview:share];
        _share = share;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(title.left, common.bottom+5, kScreenWidth-title.left, 1)];
        line.backgroundColor = RGB(235, 235, 235);
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setModel:(MagazineModel *)model {
    _model = model;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:model.generateTime];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger flags = NSCalendarUnitMonth | NSCalendarUnitDay;
    comps = [calendar components:flags fromDate:date];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    _day.text = [NSString stringWithFormat:@"%ld", day];
    _month.text = [NSString stringWithFormat:@"%ld", month];
    
    _title.text = model.magazineName;
    
    NSMutableArray *urls = [[model.magazineUrlContent componentsSeparatedByString:@","] mutableCopy];
//    [urls removeObjectAtIndex:0];
    
    switch (urls.count) {
        case 1:
            self.ivs.firstObject.hidden = NO;
            break;
        case 2:
            self.ivs.firstObject.hidden = NO;
            self.ivs[1].hidden = NO;
            break;
        default:
            self.ivs.firstObject.hidden = NO;
            self.ivs[1].hidden = NO;
            self.ivs.lastObject.hidden = NO;
            break;
    }
    
    for (int i = 0; i < urls.count; i ++) {
        [self.ivs[i] sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", KAIKANG, urls[i]]]];
    }
    
    [self.commonBtn setTitle:[NSString stringWithFormat:@"%ld", model.comments.count] forState:UIControlStateNormal];
    [self.pariseBtn setTitle:[NSString stringWithFormat:@"%ld", model.thumbs.count] forState:UIControlStateNormal];
//    self.desc.text = model.magazineTextContent;
}

- (NSMutableArray<UIImageView *> *)ivs {
    if (!_ivs) {
        _ivs = [NSMutableArray array];
    }
    return _ivs;
}

@end
