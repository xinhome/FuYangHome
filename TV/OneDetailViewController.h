//
//  OneDetailViewController.h
//  TV
//
//  Created by HOME on 16/9/13.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "BaseViewController.h"
#import "MagazineModel.h"
#import "CommentViewController.h"

@interface OneDetailViewController : BaseViewController

@property (nonatomic, strong) MagazineModel *model;///<<#注释#>

@property (nonatomic, copy) MYAction commentAction;
@property (nonatomic, copy) MYAction praiseAction;
@end
