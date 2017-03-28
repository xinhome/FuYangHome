//
//  ThereDetailViewController.m
//  TV
//
//  Created by HOME on 16/9/14.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "ThereDetailViewController.h"
#import "EaseTextView.h"

@interface ThereDetailViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UITextViewDelegate>
{
    float _imageHeight;
    int _height;
}
#define titleColor  RGB(51, 51, 51)
#define conColor   RGB(102, 102, 102)
#define smallColor   RGB(153, 153, 153)
@property (nonatomic,retain)UIScrollView *scrollView;
@property (nonatomic,retain)NSArray *ImageArr;
@end

@implementation ThereDetailViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardHide:) name: UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"社区详情";
    _textview.delegate = self;
    
    [self initUI];
    
    [self loadScroll];
    
    [self.view bringSubviewToFront:_bgView];
}
#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"说点什么吧"]) {
        textView.text = @"";
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"说点什么吧";
    }
}
#pragma mark - 键盘出现函数
- (void)keyboardWasShown:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    int h = keyboardSize.height;
    
    _bgView.frame = CGRectMake(0,kScreenHeight-h-60, kScreenWidth, 60);
}

#pragma mark - 键盘关闭函数
-(void)keyboardHide:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    keyboardSize = keyboardSize;
    _bgView.frame = CGRectMake(0,kScreenHeight-60, kScreenWidth, 60);
    
}
- (BOOL)prefersStatusBarHidden
{
    return NO;//隐藏为YES，显示为NO
}
- (void)initUI
{
    _height = 0;
    _imageHeight =kScreenHeight*228/1280;
    self.ImageArr = [NSArray arrayWithObjects:@"changjing",@"changjing",@"changjing",@"changjing",@"changjing",@"changjing",@"changjing", nil];
    
    _textview.layer.cornerRadius = 4;
    _textview.layer.masksToBounds = YES;
    _textview.layer.borderColor = RGB(200, 200, 200).CGColor;
    _textview.layer.borderWidth = 1;
    _bgView.layer.borderColor = RGB(200, 200, 200).CGColor;
    _bgView.layer.borderWidth = 1;
    
    [self MainView1];
    self.leftBtn.hidden = NO;
    self.titleLable.text = @"社区详情";
    
   
    self.bgView.frame = CGRectMake(0, kScreenHeight-60, kScreenWidth, 60);
}
- (void)loadScroll
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-60)];
    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _scrollView.pagingEnabled = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kScreenWidth, 0);
    _scrollView.scrollEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    _userHeaf.layer.masksToBounds = YES;
    self.userHeaf.layer.cornerRadius = self.userHeaf.frame.size.width/2;
    
    [_scrollView addSubview:_userView];
    _height = 63;
    
    [self loadUI];
}

- (void)loadUI
{
    [self creatCenter:@"三招解决白色家具发黄问题"];
    
    [self creatContenWithText:@"黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题"];
    
    [self loadImage];
    
    [self.scrollView addSubview:_dianzanView];
    _dianzanView.frame = CGRectMake(0, _height, kScreenWidth, 46);
    _height +=46;
    
    //评论
    [self creatTitleWithText2];
    
    for (int i=0; i<5; i++) {
        [self comment:@"题三招解决白色三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色家具发黄问题三招解决白色" imageName:@"changjing" name:@"我不是大王" time:@"2015-02-15"];
    }
    
    _scrollView.contentSize = CGSizeMake(0, _height);
}
//创建标题
- (void)creatCenter:(NSString *)text
{
    CGSize size = K_GET_STRINGSIZE(text, 17);
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(20, _height, kScreenWidth-40, size.height)];
    lab1.text = text;
    lab1.font = [UIFont systemFontOfSize:20];
    lab1.textAlignment = NSTextAlignmentLeft;
    lab1.textColor = titleColor;
    [_scrollView addSubview:lab1];
    _height+=size.height+10;
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
- (void)loadImage
{
    float wight = (kScreenWidth-40)/3-10;
    float height =kScreenHeight* 230/1280;
    for (int i =0; i< self.ImageArr.count; i++) {
        int row = i/3;
        int rank = i%3;
        
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds = YES;
            btn.frame = CGRectMake(20+wight*rank+10*rank, _height+(height+10)*row, kScreenWidth/3.5, height);
            [btn setBackgroundImage:[UIImage imageNamed:self.ImageArr[i]] forState:UIControlStateNormal];
            [_scrollView addSubview:btn];

    }
    _height += (height+26)*(self.ImageArr.count+1)/3;
}
//评论
- (void)creatTitleWithText2
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, 25)];
    view.backgroundColor = RGB(230, 230, 230);
    [_scrollView addSubview:view];
    _height +=25;
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 2, 25)];
    lab.backgroundColor = qianlv;
    [view addSubview:lab];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 25)];
    lab1.text = @"评论";
    lab1.font = [UIFont systemFontOfSize:15];
    lab1.textColor = titleColor;
    [view addSubview:lab1];
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
- (IBAction)commentBtnClick:(id)sender {
    [_textview becomeFirstResponder];
}
@end
