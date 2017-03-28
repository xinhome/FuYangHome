//
//  CommonCell.h
//  家居定制
//
//  Created by iKing on 2017/3/21.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonCell : UITableViewCell
@property (nonatomic, copy) NSString *common;
+ (CGFloat)heightForCell:(NSString *)common;
@end
