//
//  ChangJingCell.m
//  家居定制
//
//  Created by iKing on 2017/3/28.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ChangJingCell.h"
#import "WPWaveRippleView.h"
#import "DotDetailView.h"

@interface ChangJingCell ()

@property (nonatomic, weak) UIImageView *imageView;///<<#注释#>

@property (nonatomic, strong) DotDetailView *view;///<<#注释#>
@end

@implementation ChangJingCell

- (void)prepareForReuse {
    [super prepareForReuse];
    for (WPWaveRippleView *dot in self.dots) {
        [dot removeFromSuperview];
    }
    [self.dots removeAllObjects];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = huiseColor;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        self.imageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return self;
}
- (void)setModel:(ChangJingModel *)model {
    _model = model;
    //[self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, model.pic]]];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, model.pic]] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        self.imageView.image = image;
        for (Coordinate *coordinate in model.coordinates) {
            CGFloat x = [[coordinate.coordinate componentsSeparatedByString:@","].firstObject floatValue];
            CGFloat y = [[coordinate.coordinate componentsSeparatedByString:@","].lastObject floatValue];
            WPWaveRippleView *dotView = [[WPWaveRippleView alloc] initWithTintColor:RGB(80, 197, 176) minRadius:3 waveCount:5 timeInterval:1 duration:4];
//            [dotView whenTapped:^{
//                self.view.name.text = coordinate.name;
//                self.view.price.text = coordinate.price;
//                self.view.bottom = dotView.top;
//                self.view.centerX = dotView.centerX;
//            }];
            dotView.frame = CGRectMake(rateWidth(x), rateHeight(y), 7, 7);
            [self.contentView addSubview:dotView];
            [dotView startAnimating];
            [self.dots addObject:dotView];
        }
    }];
}

- (DotDetailView *)view {
    if (!_view) {
        _view = [[DotDetailView alloc] initWithFrame:CGRectMake(0, 0, 95, 70)];
        [self addSubview:_view];
    }
    return _view;
}

- (NSMutableArray<WPWaveRippleView *> *)dots {
    if (!_dots) {
        _dots = [NSMutableArray array];
    }
    return _dots;
}
@end
