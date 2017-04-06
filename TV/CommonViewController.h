//
//  CommonViewController.h
//  家居定制
//
//  Created by iKing on 2017/3/21.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeContentModel.h"

/// 评论controller
@interface CommonViewController : BaseViewController
@property (nonatomic, copy) NSString *scenceId;///<<#注释#>
@property (nonatomic, copy) MYAction commentSuccess;
@end
