//
//  AddressCell.h
//  家居定制
//
//  Created by iKing on 2017/3/18.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 编辑地址cell
@interface AddressCell : UITableViewCell

@property (nonatomic, weak) UIImageView *iv;///<选中远点

@property (nonatomic, weak) UIImageView *border;///<<#注释#>

@property (nonatomic, weak) UILabel *address;///<<#注释#>

@property (nonatomic, weak) UILabel *contact;///<<#注释#>

@property (nonatomic, weak) UILabel *contactTel;///<联系方式

@end
