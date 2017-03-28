//
//  YijianViewController.h
//  Tea
//
//  Created by HOME on 16/5/25.
//  Copyright © 2016年 安鑫一家. All rights reserved.
//

#import "BaseViewController.h"

@interface YijianViewController : BaseViewController
@property (retain, nonatomic) IBOutlet UITextView *textview;
@property (retain, nonatomic) IBOutlet UITextField *tf;
- (IBAction)tijiao:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *bgt;

@end
