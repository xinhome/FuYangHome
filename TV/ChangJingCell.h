//
//  ChangJingCell.h
//  家居定制
//
//  Created by iKing on 2017/3/28.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangJingModel.h"
#import "WPWaveRippleView.h"
/**
 场景展示cell
 */
@interface ChangJingCell : UICollectionViewCell
@property (nonatomic, strong) NSMutableArray<WPWaveRippleView *> *dots;///<<#注释#>
@property (nonatomic, strong) ChangJingModel *model;///<<#注释#>

@end
