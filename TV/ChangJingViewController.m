//
//  ChangJingViewController.m
//  TV
//
//  Created by HOME on 16/9/12.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "ChangJingViewController.h"
#import "ProductViewController.h"
#import "WPWaveRippleView.h"
@interface ChangJingViewController ()<UIScrollViewDelegate>
@property (nonatomic,retain)UIScrollView *scrollView;
@property (nonatomic,retain)NSMutableArray *imageArr;
@property (nonatomic, strong) WPWaveRippleView *waveRippleView;
@end

@implementation ChangJingViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *imageStrs = [self.model.pic2 componentsSeparatedByString:@","];
    for (NSString *str in imageStrs) {
        [self.imageArr addObject:[NSString stringWithFormat:@"%@%@", WEIMING, str]];
    }
    [self loadScroll];
    [self.view bringSubviewToFront:_buttomView];
    [self.view bringSubviewToFront:_backBtn];
    _buttomView.backgroundColor = RGB(51, 51, 51);
    _buttomView.alpha = 0.8;
}
- (void)loadScroll
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, kScreenHeight+20)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kScreenWidth*self.imageArr.count, 0);
    _scrollView.scrollEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i<self.imageArr.count; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        [image sd_setImageWithURL:[NSURL URLWithString:self.imageArr[i]]];
        [_scrollView addSubview:image];

        self.waveRippleView = [[WPWaveRippleView alloc] initWithTintColor:[UIColor redColor] minRadius:3 waveCount:5 timeInterval:1 duration:4];
        self.waveRippleView.frame = CGRectMake(100+kScreenWidth*i, 300, 50, 50);
        [_scrollView addSubview:[self waveRippleView]];
        [[self waveRippleView] startAnimating];
    }
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)LookAtAll:(id)sender {
    ProductViewController *Pro= [[ProductViewController alloc]init];
    Pro.categoryId = self.model.categoryId;
    [self.navigationController pushViewController:Pro animated:YES];
}

- (IBAction)comment:(id)sender {
    CommonViewController *controller = [[CommonViewController alloc]init];
    [self.navigationController pushViewController:controller    animated:YES];
}

- (IBAction)dianzan:(id)sender {
}

- (NSMutableArray *)imageArr {
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}
@end
