//
//  CommentViewController.h
//  家居定制
//
//  Created by iKing on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "BaseViewController.h"
#import "MagazineModel.h"

#define CommentSuccess @"CommentSuccess"

@interface CommentViewController : BaseViewController
@property (nonatomic, strong) MagazineModel *model;///<<#注释#>
@property (nonatomic, copy) MYAction commentAction;
@end
