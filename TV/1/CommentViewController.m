//
//  CommentViewController.m
//  家居定制
//
//  Created by iKing on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CommentViewController.h"
#import "EaseTextView.h"
#import "SocietyCommentModel.h"

@interface CommentViewController ()<EaseTextViewDelegate>

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    EaseTextView *textView = [[EaseTextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    textView.placeHolder = @"说点什么吧。。。";
    textView.delegate = self;
    [self.view addSubview:textView];
    
    UIButton *commit = [UIButton buttonWithTitle:@"提交" fontSize:16 titleColor:UIColorWhite background:RGB(74, 204, 183) cornerRadius:7];
    [commit addActionHandler:^{
        [self commit:textView.text];
    }];
    commit.frame = CGRectMake(0, textView.bottom+30, rateWidth(220), 40);
    commit.centerX = self.view.centerX;
    [self.view addSubview:commit];
}

- (void)commit:(NSString *)commentContent {
    if (self.user == nil) {
        [MBProgressHUD showError:@"请登录"];
        return;
    }
    if (commentContent.length == 0) {
        [MBProgressHUD showError:@"请填写评论内容"];
        return;
    }
    NSDictionary *parameters = @{
                                 @"reviewer.id": self.user.ID,
                                 @"magazine.magazineId": self.model.magazineId,
                                 @"parentComment.commentId": @0,
                                 @"commentContent": commentContent
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/comments/add" person:RequestPersonKaiKang parameters:parameters success:^(id successResponse) {
        if ([successResponse isSuccess]) {
            [MBProgressHUD showSuccess:@"评论成功"];
            if (self.commentAction) {
                SocietyCommentModel *model = [[SocietyCommentModel alloc] init];
                model.commentContent = commentContent;
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                model.generateTime = [formatter stringFromDate:[NSDate date]];
                model.name = self.user.nickname;
                model.url = [self.user.avatar substringFromIndex:WEIMING.length];
                self.commentAction(model);
            }
            [self popViewController];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD showError:@"网络异常"];
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
