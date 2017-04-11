//
//  TwoViewController.m
//  TV
//
//  Created by HOME on 16/7/19.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "TwoViewController.h"
#import "main1TableViewCell.h"
#import "DPPhotoGroupViewController.h"
#import "EaseTextView.h"
#import "ButtonInPost.h"
#import "TZTestCell.h"
#import "TZImagePickerController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>

typedef NS_ENUM(NSInteger, ShareType) {
    ShareTypeNone,
    ShareTypeTencent,
    ShareTypeWeiXin,
    ShareTypeSina
};

@interface TwoViewController ()<UITextViewDelegate, DPPhotoGroupViewControllerDelegate, EaseTextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, TZImagePickerControllerDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UITextField *textField;///<标题
@property (nonatomic, weak) EaseTextView *textView;///<内容
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray<UIButton *> *btns;///<<#注释#>
@property (nonatomic, strong) NSMutableArray<ButtonInPost *> *btns2;///<<#注释#>
@property (nonatomic, strong) NSArray *titles;///<选择分类
@property (nonatomic, strong) NSArray *colors;///<选择分类颜色
@property (nonatomic, strong) UICollectionView *collectionView;///<<#注释#>
@property (nonatomic, strong) NSMutableArray *selectedPhotos;///<<#注释#>
@property (nonatomic, assign) int selectType;///< 选择的类型
@property (nonatomic, assign) ShareType shareType;///< <#注释#>
@end

@implementation TwoViewController {
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    CGFloat _itemWH;
    CGFloat _margin;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:UIColorWhite] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布帖子";
    self.view.backgroundColor = UIColorWhite;
    self.titles = @[@"卧室天地",@"卫浴天地",@"厨房天地",@"客厅天地",@"厨房天地",@"阳台天地",@"手动DIY"];
    self.colors = @[RGB(237, 155, 170),RGB(170, 215, 187),RGB(170, 163, 205),RGB(254, 252, 162),RGB(239, 185, 145),RGB(215, 216, 213),RGB(209, 232, 162)];
    [self setupUI];
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
}

- (void)setupUI {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49)];
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:scrollView];
    
    UILabel *label = [UILabel labelWithText:@"选择分类" textColor:RGB(91, 91, 91) fontSize:15];
    label.frame = CGRectMake(15, 20, kScreenWidth, 15);
    [scrollView addSubview:label];
    CGFloat leftMargin = 0;
    if (INCH_4) {
        leftMargin = 28;
    } else if (INCH_4_7) {
        leftMargin = 55;
    } else {
        leftMargin = 75;
    }
    for (int i = 0; i < 7; i ++) {
        ButtonInPost *btn = [[ButtonInPost alloc] initWithFrame:CGRectMake(leftMargin+(80+12)*(i%3), label.bottom+25+(35+8)*(i/3), 80, 35)];
        [btn addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorBlack forState:UIControlStateNormal];
        btn.backgroundColor = self.colors[i];
        [scrollView addSubview:btn];
        btn.tag = i+1;
        [self.btns2 addObject:btn];
    }
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 200, kScreenWidth-30, 1)];
    line1.backgroundColor = RGB(229, 229, 229);
    [scrollView addSubview:line1];
    
    UILabel *label1 = [UILabel labelWithText:@"标题" textColor:RGB(91, 91, 91) fontSize:15];
    label1.frame = CGRectMake(15, line1.bottom+20, kScreenWidth, 15);
    [scrollView addSubview:label1];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, label1.bottom+25, kScreenWidth-30, 35)];
    self.textField = textField;
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleNone;
    textField.placeholder = @"帖子标题";
    [scrollView addSubview:textField];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(15, textField.bottom, kScreenWidth-30, 1)];
    line2.backgroundColor = RGB(229, 229, 229);
    [scrollView addSubview:line2];
    
    UILabel *label2 = [UILabel labelWithText:@"内容" textColor:RGB(91, 91, 91) fontSize:15];
    label2.frame = CGRectMake(15, line2.bottom+25, kScreenWidth, 15);
    [scrollView addSubview:label2];
    
    EaseTextView *textView = [[EaseTextView alloc] initWithFrame:CGRectMake(15, label2.bottom+15, kScreenWidth-30, 80)];
    self.textView = textView;
    textView.delegate = self;
    textView.placeHolder = @"聊一聊你的家居装饰小秘诀...";
    [scrollView addSubview:textView];
    
    /*UIButton *camera = [UIButton buttonWithType:UIButtonTypeCustom];
    [camera addActionHandler: ^{
        [self selectImages];
    }];
    camera.frame = CGRectMake(15, textView.bottom+30, 60, 60);
    [camera setImage:UIImageNamed(@"camare") forState:UIControlStateNormal];
    [scrollView addSubview:camera];*/
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 0;
    _itemWH = 60;
    flowLayout.itemSize = CGSizeMake(_itemWH, _itemWH);
    flowLayout.minimumInteritemSpacing = _margin;
    flowLayout.minimumLineSpacing = _margin;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, textView.bottom+30, kScreenWidth-30, 68) collectionViewLayout:flowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = UIColorWhite;
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    
    [scrollView addSubview:self.collectionView];
    
    UILabel *label3 = [UILabel labelWithText:@"同时分享到" textColor:RGB(91, 91, 91) fontSize:15];
    label3.frame = CGRectMake(15, self.collectionView.bottom+40, kScreenWidth, 15);
    [scrollView addSubview:label3];
    
    UIButton *wechat = [UIButton buttonWithType:UIButtonTypeCustom];
    [wechat addActionHandler:^{
        self.shareType = ShareTypeWeiXin;
    }];
    [wechat addTarget:self action:@selector(shareTo:) forControlEvents:UIControlEventTouchUpInside];
    [wechat setImage:UIImageNamed(@"weixin1") forState:UIControlStateNormal];
    [wechat setImage:UIImageNamed(@"weixin2") forState:UIControlStateSelected];
    wechat.frame = CGRectMake(0, label3.bottom+20, 25, 25);
    wechat.centerX = kScreenWidth/2;
    [scrollView addSubview:wechat];
    [self.btns addObject:wechat];
    
    UIButton *tencent = [UIButton buttonWithType:UIButtonTypeCustom];
    tencent.hidden = ![QQApiInterface isQQInstalled];
    [tencent addActionHandler:^{
        self.shareType = ShareTypeTencent;
    }];
    [tencent addTarget:self action:@selector(shareTo:) forControlEvents:UIControlEventTouchUpInside];
    [tencent setImage:UIImageNamed(@"qq1") forState:UIControlStateNormal];
    [tencent setImage:UIImageNamed(@"qq2") forState:UIControlStateSelected];
    tencent.frame = CGRectMake(0, label3.bottom+20, 25, 25);
    tencent.right = wechat.left-30;
    [scrollView addSubview:tencent];
    [self.btns addObject:tencent];
    
    UIButton *sina = [UIButton buttonWithType:UIButtonTypeCustom];
    [sina addActionHandler:^{
        self.shareType = ShareTypeSina;
    }];
    [sina addTarget:self action:@selector(shareTo:) forControlEvents:UIControlEventTouchUpInside];
    [sina setImage:UIImageNamed(@"xinlang2") forState:UIControlStateNormal];
    [sina setImage:UIImageNamed(@"xinlang1") forState:UIControlStateSelected];
    sina.frame = CGRectMake(0, label3.bottom+20, 25, 25);
    sina.left = wechat.right+30;
    [scrollView addSubview:sina];
    [self.btns addObject:sina];
    
    UIButton *publish = [UIButton buttonWithTitle:@"发布" fontSize:15 titleColor:UIColorWhite background:RGB(74, 204, 183) cornerRadius:7];
    [publish addActionHandler:^{
        [self publish];
    }];
    publish.frame = CGRectMake(0, wechat.bottom+40, rateWidth(210), 40);
    publish.centerX = kScreenWidth/2;
    [scrollView addSubview:publish];
    
    scrollView.contentSize = CGSizeMake(0, publish.bottom+50);
}

#pragma mark - 选择图片
- (void)selectImages {
    DPPhotoGroupViewController *controller = [[DPPhotoGroupViewController alloc] init];
    controller.maxSelectionCount = 9;
    controller.delegate = self;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:controller] animated:YES completion:nil];
}
#pragma mark - DPPhotoGroupViewControllerDelegate
- (void)didSelectPhotos:(NSMutableArray *)photos {
    NSLog(@"%@", photos);
}

#pragma mark - collectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"camare"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    //    if (!self.allowPickingGifSwitch.isOn) {
    cell.gifLable.hidden = YES;
    //    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}
#pragma mark - collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:6 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    } else
    {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
        //            imagePickerVc.maxImagesCount = self.maxCountTF.text.integerValue;
        //            imagePickerVc.allowPickingOriginalPhoto = self.allowPickingOriginalPhotoSwitch.isOn;
        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            _selectedAssets = [NSMutableArray arrayWithArray:assets];
            _isSelectOriginalPhoto = isSelectOriginalPhoto;
            [_collectionView reloadData];
            _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
    
    
}
#pragma mark - TZImagePickerControllerDelegate

/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    // 1.打印图片名字
    //    [self printAssetsName:assets];
}

// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [_collectionView reloadData];
}

// 如果用户选择了一个gif图片，下面的handle会被执行
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [_collectionView reloadData];
}
- (void)publish {
    if (self.user == nil) {
        [MBProgressHUD showError:@"请登录"];
        return;
    }
    if (self.textField.text.length == 0 || self.textView.text == 0) {
        [MBProgressHUD showError:@"信息不完全"];
        return;
    }
    if (_selectedPhotos.count == 0) {
        [MBProgressHUD showError:@"选择图片"];
        return;
    }
    
    
    [MBProgressHUD showMessage:@"正在发布..." toView:self.view];
    NSDictionary *parameters = @{
                                 @"type": @(self.selectType),
                                 @"magazineName": self.textField.text,
                                 @"magazineTextContent": self.textView.text,
                                 @"user.id": self.user.ID,
                                 };

//    [[AFHTTPSessionManager manager] POST:@"http://xwmasd.ngrok.cc/FyHome/magazines/addp" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (UIImage *image in self.selectedPhotos) {
//            NSLog(@"%d", arc4random());
//            NSString *fileName = [NSString stringWithFormat:@"%d", arc4random()];
//            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.3) name:@"uploadFile" fileName:[NSString stringWithFormat:@"%@.jpg", fileName]  mimeType:@"image/jpeg"];
//        }
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/addp" parameters:parameters constructingBody:^(id<AFMultipartFormData> formData) {
        for (UIImage *image in self.selectedPhotos) {
            NSLog(@"%d", arc4random());
            NSString *fileName = [NSString stringWithFormat:@"%d", arc4random()];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.3) name:@"uploadFile" fileName:[NSString stringWithFormat:@"%@.jpg", fileName]  mimeType:@"image/jpeg"];
        }
    } success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([successResponse isSuccess]) {
            self.textField.text = nil;
            self.textView.text = nil;
            [self.selectedPhotos removeAllObjects];
            [self.collectionView reloadData];
            [MBProgressHUD showSuccess:@"发布成功"];
            for (UIButton *btn in self.btns) {
                btn.selected = NO;
            }
            switch (self.shareType) {
                case ShareTypeTencent: {
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    [params SSDKSetupShareParamsByText:@"富阳家居" images:@"https://www.taobao.com" url:[NSURL URLWithString:@"https://www.baidu.com"] title:@"富阳家居" type:SSDKContentTypeAuto];
                    [ShareSDK share:SSDKPlatformTypeQQ parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                        NSLog(@"%d", state);
                    }];
                }
                    break;
                case ShareTypeWeiXin: {
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    [params SSDKSetupShareParamsByText:@"富阳家居" images:@"https://www.taobao.com" url:[NSURL URLWithString:@"https://www.baidu.com"] title:@"富阳家居" type:SSDKContentTypeAuto];
                    [ShareSDK share:SSDKPlatformTypeWechat parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                        NSLog(@"%d", state);
                    }];
                }
                    break;
                case ShareTypeSina: {
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    [params SSDKSetupShareParamsByText:@"富阳家居" images:@"https://www.taobao.com" url:[NSURL URLWithString:@"https://www.baidu.com"] title:@"富阳家居" type:SSDKContentTypeAuto];
                    [ShareSDK share:SSDKPlatformTypeSinaWeibo parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                        NSLog(@"%d", state);
                    }];
                }
                    break;
                default: {
                    NSLog(@"不分享内容");  
                }
                    break;
            }
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常"];
    }];
//    [[HttpRequestManager shareManager] addPOSTURL:@"/magazines/addp" person:RequestPersonKaiKang parameters:parameters success:^(id successResponse) {
//
//    } fail:^(NSError *error) {

//    }];
}

- (void)shareTo:(UIButton *)sender {
    for (UIButton *btn in self.btns) {
        if (sender == btn) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

- (void)selectCategory:(ButtonInPost *)sender {
    for (ButtonInPost *btn in self.btns2) {
        if (sender == btn) {
            self.selectType = sender.tag;
            [btn setSelected:YES];
        } else {
            [btn setSelected:NO];
        }
    }
}

- (NSMutableArray<UIButton *> *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (NSMutableArray<ButtonInPost *> *)btns2 {
    if (!_btns2) {
        _btns2 = [NSMutableArray array];
    }
    return _btns2;
}
@end
