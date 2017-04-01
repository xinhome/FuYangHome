//
//  HPPhotoBrowser.m
//  haipai
//
//  Created by Tom Yin on 2016/12/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "HPPhotoBrowser.h"
#import "HPPhotoBrowserCell.h"

@interface HPPhotoBrowser () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    CGRect _endTempFrame;
    NSInteger _currentPage;
    NSIndexPath *_zoomingIndexPath;
}

@property (nonatomic, strong) UIView *inView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSArray *URLStrings;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger index;

@end

@implementation HPPhotoBrowser

+ (instancetype)showFromImageView:(UIImageView *)imageView inView:(UIView *)view withURLStrings:(NSArray *)URLStrings atIndex:(NSInteger)index {
    return [self showFromImageView:imageView inView:view withURLStrings:URLStrings placeholderImage:nil atIndex:index];
}

+ (instancetype)showFromImageView:(UIImageView *)imageView inView:(UIView *)view withURLStrings:(NSArray *)URLStrings placeholderImage:(UIImage *)image atIndex:(NSInteger)index {
    HPPhotoBrowser *browser = [[HPPhotoBrowser alloc] initWithFrame:view.frame];
    browser.inView = view;
    browser.imageView = imageView;
    browser.URLStrings = URLStrings;
    [browser configureBrowserWithView:view];
    if (imageView) {
        [browser animateImageViewAtIndex:index inView:view];
    }
    browser.placeholderImage = image;
    
    return browser;
}

#pragma mark - private

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self whenTapped:^{
            [self removeFromSuperview];
        }];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor blackColor];
        collectionView.hidden = YES;
        collectionView.pagingEnabled = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView = collectionView;
        [self addSubview:collectionView];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadForScreenRotate) name:UIDeviceOrientationDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photoCellDidZooming:) name:kPhotoCellDidZommingNotification object:nil];
        
    }
    return self;
}

- (void)animateImageViewAtIndex:(NSInteger)index inView:(UIView *)view {
    _index = index;
    CGRect startFrame = [self.imageView.superview convertRect:self.imageView.frame toView:view];
    CGRect endFrame = view.frame;
    if (self.imageView.image) {
        UIImage *image = self.imageView.image;
        CGFloat ratio = image.size.width / image.size.height;
        
        if (ratio > kScreenRatio) {
            endFrame.size.height = view.frame.size.width / ratio;
            
        } else {
            
            endFrame.size.height = view.frame.size.width * ratio;
        }
        endFrame.origin.x = view.frame.origin.x;
        endFrame.origin.y = view.frame.origin.y;
    }
    
    _endTempFrame = endFrame;
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:startFrame];
    tempImageView.image = self.imageView.image;
    tempImageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:tempImageView];
    
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        tempImageView.frame = endFrame;
    } completion:^(BOOL finished) {
        _currentPage = index;
        [self.collectionView setContentOffset:CGPointMake(self.inView.frame.size.width * index,0) animated:NO];
        self.collectionView.hidden = NO;
        [tempImageView removeFromSuperview];
    }];
}

- (void)configureBrowserWithView:(UIView *)view {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[HPPhotoBrowserCell class] forCellWithReuseIdentifier:kPhotoBrowserCellID];
    [view addSubview:self];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _URLStrings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HPPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoBrowserCellID forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.placeholderImage = self.placeholderImage;
    [cell resetZoomingScale];
    
    [cell configureCellWithURLStrings:self.URLStrings[indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth, kScreenHeight);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentPage = scrollView.contentOffset.x/kScreenWidth + 0.5;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrolledToPositionInBrowser:position:)]) {
        [self.delegate scrolledToPositionInBrowser:self position:_currentPage];
    }
    
    if (_zoomingIndexPath) {
        [self.collectionView reloadItemsAtIndexPaths:@[_zoomingIndexPath]];
        _zoomingIndexPath = nil;
    }
}

- (void)reloadForScreenRotate {
    _collectionView.frame = self.inView.frame;
    
    [_collectionView reloadData];
    _collectionView.contentOffset = CGPointMake(self.inView.frame.size.width * _currentPage,0);
}

- (void)photoCellDidZooming:(NSNotification *)nofit {
    NSIndexPath *indexPath = nofit.object;
    _zoomingIndexPath = indexPath;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
