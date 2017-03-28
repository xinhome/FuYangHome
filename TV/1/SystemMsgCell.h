//
//  SystemMsgCell.h
//  家居定制
//
//  Created by iKing on 2017/3/18.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 系统消息cell
@interface SystemMsgCell : UITableViewCell
@property (nonatomic, copy) NSString *content;///<<#注释#>
@property (nonatomic, weak) UILabel *time;///<<#注释#>
+ (CGFloat)heightForContent:(NSString *)content;
@property (nonatomic, copy) MYAction longPressAction;
@property (nonatomic, weak) UIMenuController *menu;///<<#注释#>
@end
