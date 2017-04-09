//
//  OneDetailViewController.m
//  TV
//
//  Created by HOME on 16/9/13.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "OneDetailViewController.h"

#import <ShareSDKUI/ShareSDKUI.h>
@interface OneDetailViewController ()<UIScrollViewDelegate>
{
    float _imageHeight;
    int _height;
    CGPoint _panLocation;
}

@property (nonatomic, weak) UIWebView *webView;///<<#注释#>
@property (nonatomic, weak) UILabel *commentLabel;///<<#注释#>
@property (nonatomic, weak) UILabel *praiseLabel;///<<#注释#>
@end

@implementation OneDetailViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentSuccess) name:CommentSuccess object:nil];
}
- (void)commentSuccess {
    self.commentLabel.text = self.model.count;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _height = 0;
    _panLocation = CGPointMake(kScreenWidth-85+30, kScreenHeight-128);
    _imageHeight =kScreenHeight*360/1280;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"杂志详情";
    [self setupUI];
    
    [self loadData];
}
- (void)loadData {
    NSDictionary *parameters = @{
                                 @"id": self.model.magazineId,
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/getone" person:RequestPersonKaiKang parameters:parameters success:^(id successResponse) {
        NSLog(@"%@", successResponse);
//        NSLog(@"%@", successResponse);
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)setupUI {
    NSString *HTMLString = [self.model.magazineTextContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    HTMLString = [HTMLString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    HTMLString = [HTMLString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    [webView loadHTMLString:HTMLString baseURL:nil];
    webView.backgroundColor = UIColorWhite;
    [self.view addSubview:webView];
    [self setupToolView];
}
- (void)setupToolView {
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-45, kScreenWidth, 45)];
    toolView.backgroundColor = RGB(74, 74, 74);
    [self.view addSubview:toolView];
    UIImageView *comment = [[UIImageView alloc] initWithFrame:CGRectMake(13, (45-20)/2, 22, 20)];
    [comment whenTapped:^{
        [self comment];
    }];
    comment.image = UIImageNamed(@"comment");
    [toolView addSubview:comment];
    
    UILabel *commentLabel = [UILabel labelWithText:self.model.count textColor:UIColorWhite fontSize:13];
    self.commentLabel = commentLabel;
    commentLabel.frame = CGRectMake(comment.right+10, 0, 60, 13);
    commentLabel.centerY = comment.centerY;
    [toolView addSubview:commentLabel];
    
    UIImageView *praise = [[UIImageView alloc] initWithFrame:CGRectMake(commentLabel.right+5, 0, 22, 20)];
    [praise whenTapped:^{
        [self dianzan];
    }];
    praise.image = [UIImage imageNamed:@"favor"];
    praise.centerY = comment.centerY;
    [toolView addSubview:praise];
    
    UILabel *praiseLabel = [UILabel labelWithText:self.model.likes textColor:UIColorWhite fontSize:13];
    self.praiseLabel = praiseLabel;
    praiseLabel.frame = CGRectMake(praise.right+10, 0, 60, 13);
    praiseLabel.centerY = comment.centerY;
    [toolView addSubview:praiseLabel];
    
    UIImageView *share = [[UIImageView alloc] initWithFrame:CGRectMake(praiseLabel.right+5, 0, 22, 20)];
    [share whenTapped:^{
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:nil
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            
        }];
    }];
    share.image = [UIImage imageNamed:@"share"];
    share.centerY = comment.centerY;
    [toolView addSubview:share];
    
    UILabel *label = [UILabel labelWithText:@"参与评论" textColor:UIColorWhite fontSize:14];
    [label whenTapped:^{
        [self comment];
    }];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, 130, 45);
    label.right = kScreenWidth;
    [toolView addSubview:label];
}

- (void)comment {
    CommentViewController *comment = [[CommentViewController alloc]init];
    comment.model = self.model;
    comment.commentAction = ^{
        self.commentAction();
        self.commentLabel.text = self.model.count;
    };
    [self.navigationController pushViewController:comment animated:YES];
}

- (void)dianzan {
    NSDictionary *parameters = @{
                                 @"magazineId": self.model.magazineId
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/like" person:RequestPersonWeiMing parameters:parameters success:^(id successResponse) {
        if ([successResponse isSuccess]) {
            if (self.praiseAction) {
                self.praiseAction();
            }
            self.praiseLabel.text = self.model.likes;
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"网络异常"];
        NSLog(@"%@", error);
    }];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
