//
//  JiFenDuiHuanViewController.h
//  家居定制
//
//  Created by iking on 2017/4/5.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "BaseViewController.h"

@protocol jiFenDelegate <NSObject>

- (void)getJiFen:(NSString *)jifen;

@end

@interface JiFenDuiHuanViewController : BaseViewController

@property (nonatomic, strong) NSString *jiFen;
@property (nonatomic, assign) id<jiFenDelegate> delegate;

@end
