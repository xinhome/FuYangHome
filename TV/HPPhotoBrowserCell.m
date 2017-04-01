//
//  HPPhotoBrowserCell.m
//  haipai
//
//  Created by Tom Yin on 2016/12/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "HPPhotoBrowserCell.h"
#import "SDWebImageManager.h"

@interface HPPhotoBrowserCell () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;


@end

@implementation HPPhotoBrowserCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.maximumZoomScale = 4;
    scrollView.minimumZoomScale = 0.5;
    scrollView.delegate = self;
    
    [self addSubview:scrollView];
    _scrollView = scrollView;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:imageView];
    [scrollView addSubview:imageView];
    _imageView = imageView;
}

- (void)resetZoomingScale {
    
    if (self.scrollView.zoomScale !=1) {
        self.scrollView.zoomScale = 1;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _scrollView.frame = self.bounds;
    _imageView.frame = _scrollView.bounds;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    [[NSNotificationCenter defaultCenter] postNotificationName:kPhotoCellDidZommingNotification object:_indexPath];
}

- (void)configureCellWithURLStrings:(NSString *)URLStrings {
    self.imageView.image = self.placeholderImage;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", KAIKANG, URLStrings]] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        self.imageView.image = image;
    }];
}

@end
