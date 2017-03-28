//
//  OneDetailViewController.m
//  TV
//
//  Created by HOME on 16/9/13.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "OneDetailViewController.h"
#import "commentViewController.h"
@interface OneDetailViewController ()<UIScrollViewDelegate>
{
    float _imageHeight;
    int _height;
    CGPoint _panLocation;
}
#define titleColor  RGB(51, 51, 51)
#define conColor   RGB(102, 102, 102)
#define smallColor   RGB(153, 153, 153)
@property (nonatomic,retain)UIScrollView *scrollView;

@end

@implementation OneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _height = 0;
    _panLocation = CGPointMake(kScreenWidth-85+30, kScreenHeight-128);
    _imageHeight =kScreenHeight*360/1280;
    
    self.title = @"产品详情";
    [self loadScroll];

    [self.view bringSubviewToFront:_dingzhiBtn];
    [self.view bringSubviewToFront:_buttomView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(tuozhuai:)];
    pan.maximumNumberOfTouches = 1;
    pan.minimumNumberOfTouches = 1;
    [_dingzhiBtn addGestureRecognizer:pan];
    
    [self loadData];
}
- (void)loadData {
    NSDictionary *parameters = @{
                                 @"id": self.model.magazineId,
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/getone" person:RequestPersonKaiKang parameters:parameters success:^(id successResponse) {
        NSLog(@"%@", successResponse);
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)tuozhuai:(UIPanGestureRecognizer *)paramSender
{
    if (paramSender.state != UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed){
        //通过使用 locationInView 这个方法,来获取到手势的坐标
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        paramSender.view.center = location;
        _dingzhiBtn.center = location;
        _panLocation = location;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        _dingzhiBtn.center  = CGPointMake(_panLocation.x, kScreenHeight-10);
        _dingzhiBtn.alpha = 0;
//        _dingzhiBtn.frame = CGRectMake(kScreenWidth-65, kScreenHeight-60, 0, 0);
    } completion:^(BOOL finished) {
//        _dingzhiBtn.hidden = YES;
    }];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [UIView animateWithDuration:1 animations:^{
        _dingzhiBtn.alpha = 1;
        _dingzhiBtn.center = _panLocation;
    }];
}
- (void)loadScroll
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    _scrollView.pagingEnabled = NO;
    _scrollView.delegate = self;
    _scrollView.scrollEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    [self initUI];
}
- (void)initUI
{
    [self creatImageViewWithImageName:@"changjing" type:2];
    
    [self creatCenter:@"三招解决白色家具发黄问题"];

    [self creatContenWithText:@"三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题"];

    [self creatTitleWithText:@"家具清洁擦拭"];

    [self creatContenWithText:@"三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题"];
    
    [self creatImageViewWithImageName:@"changjing" type:1];
    [self creatImageDescription:@"图片描述内容"];
    
    [self creatTitleWithText:@"家具清洁擦拭"];
    
    [self creatContenWithText:@"三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题"];
    
    [self creatImageViewWithImageName:@"changjing" type:1];
    [self creatImageDescription:@"图片描述内容"];
    [self creatImageViewWithImageName:@"changjing" type:1];
    [self creatImageDescription:@"图片描述内容"];
//    评论
    [self creatTitleWithText2];
    
    for (int i=0; i<3; i++) {
        [self comment:@"三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色" imageName:@"changjing" name:@"我不是大王" time:@"2015-02-15"];
    }
    
    
     _scrollView.contentSize = CGSizeMake(0, _height);
    
}
//图片
- (void)creatImageViewWithImageName:(NSString *)imageName  type:(int )type
{
    
    int wight;
    if (type == 1) {
        wight = 20;
    }else
    {
        wight = 0;
    }
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0+wight, _height, kScreenWidth-wight*2, _imageHeight)];
    image.image = [UIImage imageNamed:imageName];
    image.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:image];
    
     _height = _height+_imageHeight;
}
//内容
- (void)creatContenWithText:(NSString *)text
{
    CGSize size = K_GET_STRINGSIZE(text, 16);
    
    UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(15, _height, kScreenWidth-30, size.height)];
    
    textview.textColor  = conColor;
    textview.font = [UIFont systemFontOfSize:15];
    textview.text = [NSString stringWithFormat:@"    %@",text];
    textview.editable = NO;
    [_scrollView addSubview:textview];
    
    _height +=size.height;
    
}
//蓝条标题
- (void)creatTitleWithText:(NSString *)text
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, 40)];
    [_scrollView addSubview:view];
    _height +=40;
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, 3, 34)];
    lab.backgroundColor = qianlv;
    [view addSubview:lab];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 200, 40)];
    lab1.text = text;
    lab1.font = [UIFont systemFontOfSize:20];
    lab1.textColor = titleColor;
    [view addSubview:lab1];
}
//评论
- (void)creatTitleWithText2
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, 25)];
    view.backgroundColor = RGB(230, 230, 230);
    [_scrollView addSubview:view];
    _height +=25;
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, 2, 20)];
    lab.backgroundColor = qianlv;
    [view addSubview:lab];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 25)];
    lab1.text = @"评论";
    lab1.font = [UIFont systemFontOfSize:15];
    lab1.textColor = titleColor;
    [view addSubview:lab1];
}
//创建标题
- (void)creatCenter:(NSString *)text
{
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, 40)];
    lab1.text = text;
    lab1.font = [UIFont systemFontOfSize:20];
    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.textColor = titleColor;
    [_scrollView addSubview:lab1];
    _height+=40;
}

//创建图片描述
- (void)creatImageDescription:(NSString *)text
{
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, 30)];
    lab1.text = text;
    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.font = [UIFont systemFontOfSize:17];
    lab1.textColor = smallColor;
    [_scrollView addSubview:lab1];
    _height+=30;
}
//描述
- (void)comment:(NSString *)contetText imageName:(NSString *)imageName name:(NSString *)name  time:(NSString *)time
{
    CGSize size = K_GET_STRINGSIZE(contetText, 15);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, size.height+60)];
    [_scrollView addSubview:view];
    _height+= size.height+60;
    //头像
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 3, 40, 40)];
    image.image = [UIImage imageNamed:imageName];
    image.layer.masksToBounds = YES;
    image.layer.cornerRadius = 20;
    [view addSubview:image];
//    昵称
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(55, 8, kScreenWidth-45, 15)];
    lab1.text = name;
    lab1.textAlignment = NSTextAlignmentLeft;
    lab1.font = [UIFont systemFontOfSize:15];
    lab1.textColor = conColor;
    [view addSubview:lab1];
    
//    评价内容
    UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(50, 25, kScreenWidth-70, size.height+20)];
    
    textview.textColor  = conColor;
//    textview.font = [UIFont systemFontOfSize:17];
    textview.text = [NSString stringWithFormat:@"    %@",contetText];
    textview.font = [UIFont systemFontOfSize:15];
    textview.editable = NO;
    [view addSubview:textview];
    
    
    UILabel *timeLable = [[UILabel alloc]initWithFrame:CGRectMake(20, size.height+40, kScreenWidth-40, 15)];
    timeLable.text = time;
    timeLable.textAlignment = NSTextAlignmentRight;
    timeLable.font = [UIFont systemFontOfSize:15];
    timeLable.textColor = conColor;
    [view addSubview:timeLable];
    
    
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 58+size.height, kScreenWidth, 1)];
    lineLable.backgroundColor = RGB(230, 230, 230);
    [view addSubview:lineLable];
    
}
- (IBAction)comment:(id)sender {
    CommentViewController *comment = [[CommentViewController alloc]init];
    comment.model = self.model;
    [self.navigationController pushViewController:comment animated:YES];
    
}

- (IBAction)dianzan:(id)sender {
}
@end
