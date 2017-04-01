//
//  HPPhotoBrowserCell.h
//  haipai
//
//  Created by Tom Yin on 2016/12/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPhotoBrowserCellID @"HPPhotoBrowserCell"
static NSString *const kPhotoCellDidZommingNotification = @"kPhotoCellDidZommingNotification";

@interface HPPhotoBrowserCell : UICollectionViewCell

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)resetZoomingScale;


- (void)configureCellWithURLStrings:(NSString *)URLStrings;

@end
