//
//  OneDetailViewController.m
//  TV
//
//  Created by HOME on 16/9/13.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "OneDetailViewController.h"
#import "SocietyCommentModel.h"
#import "CommunityDetailCell.h"
#import <ShareSDKUI/ShareSDKUI.h>
@interface OneDetailViewController ()<UIScrollViewDelegate, UIWebViewDelegate>
{
    float _imageHeight;
    int _height;
    CGPoint _panLocation;
}

@property (nonatomic, strong) UIWebView *webView;///<<#注释#>
@property (nonatomic, weak) UILabel *commentLabel;///<<#注释#>
@property (nonatomic, weak) UILabel *praiseLabel;///<<#注释#>
@property (nonatomic, strong) NSMutableArray<SocietyCommentModel *> *dataSource;///<<#注释#>
@end

@implementation OneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _height = 0;
    _panLocation = CGPointMake(kScreenWidth-85+30, kScreenHeight-128);
    _imageHeight =kScreenHeight*360/1280;
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
        self.dataSource = [SocietyCommentModel mj_objectArrayWithKeyValuesArray:successResponse];
        [self.tableView reloadData];
//        NSLog(@"%@", successResponse);
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD showError:@"网络异常"];
    }];
}
- (void)setupUI {
    NSString *HTMLString = [self.model.magazineTextContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    HTMLString = [HTMLString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    HTMLString = [HTMLString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    HTMLString = [HTMLString stringByReplacingOccurrencesOfString:@"2017" withString:[NSString stringWithFormat:@"%@%@", WEIMING, @"2017"]];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-45) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    webView.scrollView.scrollEnabled = NO;
    webView.delegate = self;
    webView.scrollView.delegate = self;
    [webView loadHTMLString:HTMLString baseURL:nil];
    webView.backgroundColor = UIColorWhite;
    self.webView = webView;
//    [self.view addSubview:webView];
    self.tableView.tableHeaderView = webView;
    [self setupToolView];
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *identifier = @"cell";
        CommunityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[CommunityDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.model = self.dataSource[indexPath.row];
        return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [CommunityDetailCell cellHeightForModel:self.dataSource[indexPath.row]];
    
}

#pragma mark - UIWebView Delegate Methods
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //获取到webview的高度
    CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    self.webView.frame = CGRectMake(self.webView.frame.origin.x,self.webView.frame.origin.y, kScreenWidth, height);
    [self.tableView reloadData];
}
//- (void)addObserverForWebViewContentSize{
//    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:0 context:nil];
//}
//- (void)removeObserverForWebViewContentSize{
//    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
//}
////以下是监听结果回调事件：
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    //在这里边添加你的代码
//    [self layoutCell];
//}
////设置footerView的合理位置
//- (void)layoutCell{
//    //取消监听，因为这里会调整contentSize，避免无限递归
//    [self removeObserverForWebViewContentSize];
//    UIView *viewss = [self.webView.scrollView viewWithTag:99999];
//    [viewss removeFromSuperview];
//    CGSize contentSize = self.webView.scrollView.contentSize;
//    UIView *vi = [[UIView alloc] init];
//    vi.backgroundColor = [UIColor redColor];
//    vi.userInteractionEnabled = YES;
//    vi.tag = 99999;
//    vi.frame = CGRectMake(0, contentSize.height, self.view.width, 150);
//    [self.webView.scrollView addSubview:vi];
//    self.webView.scrollView.contentSize = CGSizeMake(contentSize.width, contentSize.height + 150);
//    //重新监听
//    [self addObserverForWebViewContentSize];
//}
//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
//    button.backgroundColor = [UIColor greenColor];
//    [button addTarget:self action:@selector(buttonHeaderAction) forControlEvents:UIControlEventTouchUpInside];
//    [webView.scrollView addSubview:button];
//    webView.scrollView.subviews[0].frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 1579);
//}
//- (void)buttonHeaderAction {
//    NSLog(@"**************");
//}
- (void)setupToolView {
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-45-64, kScreenWidth, 45)];
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
    comment.commentAction = ^(SocietyCommentModel *model){
        self.commentAction();
        [self.dataSource addObject:model];
        [self.tableView reloadData];
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
- (NSMutableArray<SocietyCommentModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
