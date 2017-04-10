//
//  CommunityDetailCell.h
//  家居定制
//
//  Created by iKing on 2017/3/29.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocietyCommentModel.h"

@interface CommunityDetailCell : UITableViewCell
@property (nonatomic, strong) SocietyCommentModel *model;///<<#注释#>
+ (CGFloat)cellHeightForModel:(SocietyCommentModel *)model;
@end
