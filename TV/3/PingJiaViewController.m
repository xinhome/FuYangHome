//
//  PingJiaViewController.m
//  家居定制
//
//  Created by iking on 2017/3/31.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "PingJiaViewController.h"
#import "DPPhotoGroupViewController.h"
#import "TZTestCell.h"
#import "TZImagePickerController.h"
@class MyOrderViewController;

@interface PingJiaViewController ()<UITextViewDelegate,DPPhotoGroupViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, TZImagePickerControllerDelegate>
{
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    CGFloat _itemWH;
    CGFloat _margin;
}
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placehoderLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, assign) NSInteger btnIndex; // 0好，1中，2差
@property (nonatomic, assign) NSInteger isNiMing; // 0不匿名，1匿名

@end

@implementation PingJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"提交评价";
    [self addRightItemWithTitle:@"提交" action:@selector(actionTiJiao)];
    [self setUpUI];
}

#pragma mark - 提交评价
- (void)actionTiJiao
{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    for (UIImage *image in _selectedPhotos) {
//        NSString *string = [UIImageJPEGRepresentation(image, 1.0) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        dict[[NSString stringWithFormat:@"returnGoodsImage%lu", (unsigned long)[_selectedPhotos indexOfObject:image]]] = string;
//    }
//    NSString *jsonStr = [dict mj_JSONString];
//    
//    [MBProgressHUD showMessage:@"正在提交..." toView:self.view];
//    NSDictionary *parameters = @{
//                                 @"id": @([_model.goodsId intValue]),
//                                 @"buyerMsg": self.textView.text,
//                                 @"buyerStatus": @(_btnIndex),
//                                 @"buyerNm":@(_isNiMing),
//                                 @"buyerPic": jsonStr
//                                 };
//        NSLog(@"%@", parameters);
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager POST:[NSString stringWithFormat:@"%@Order/saveMsg", WeiMingURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
//        NSLog(@"评价：%@", responseObject);
//        [MBProgressHUD showSuccess:@"提交成功"];
//
//        for (UIViewController *controller in self.navigationController.viewControllers) {
//            if ([controller isKindOfClass:[MyOrderViewController class]]) {
//                [self.navigationController popToViewController:controller animated:YES];
//            }
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//        [MBProgressHUD showError:@"网络异常"];
//    }];
    [MBProgressHUD showMessage:@"正在提交..." toView:self.view];
    NSDictionary *parameters = @{
                                 @"id": @([_model.goodsId intValue]),
                                 @"buyerMsg": self.textView.text,
                                 @"buyerStatus": @(_btnIndex),
                                 @"buyerNm":@(_isNiMing)
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/Order/saveMsg" parameters:parameters constructingBody:^(id<AFMultipartFormData> formData) {
        for (UIImage *image in self.selectedPhotos) {
            NSLog(@"%d", arc4random());
            NSString *fileName = [NSString stringWithFormat:@"%d", arc4random()];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.3) name:@"uploadFile" fileName:[NSString stringWithFormat:@"%@.jpg", fileName]  mimeType:@"image/jpeg"];
        }
    } success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([successResponse isSuccess]) {
            [MBProgressHUD hideHUDForView:self.view];
            NSLog(@"评价：%@", successResponse);
            [MBProgressHUD showSuccess:@"提交成功"];
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[MyOrderViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常"];
    }];
}

- (void)setUpUI
{
    UIImageView *goodsImg = [UIImageView new];
    [goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WeiMingURL,_model.picPath]]];
    [self.view addSubview:goodsImg];
    [goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(rateWidth(39), rateWidth(39)));
        make.top.equalTo(self.view).offset(rateHeight(10));
        make.left.equalTo(self.view).offset(rateWidth(15));
    }];
    
    self.btnArray = [NSMutableArray array];
    NSArray *arrayTitle = @[@"好评",@"中评",@"差评"];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithTitle:arrayTitle[i] fontSize:15 titleColor:[UIColor whiteColor] background:UIColorFromRGB(0xc1bfc7) cornerRadius:rateHeight(14)];
        btn.tag = i;
        btn.frame = CGRectMake(rateWidth(80)+rateWidth(100)*i, rateHeight(15), rateWidth(55), rateHeight(28));
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(actionTouch:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.btnArray addObject:btn];
    }
    UIButton *firstBtn = (UIButton *)_btnArray[0];
    [firstBtn setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xfe3102)] forState:UIControlStateNormal];
    self.btnIndex = 0;
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0xdfdce6);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(goodsImg.mas_bottom).offset(rateHeight(10));
        make.height.equalTo(@(0.5));
    }];
    
    self.textView = [UITextView new];
    _textView.font = [UIFont systemFontOfSize:13.0];
    _textView.delegate = self;
    _textView.textColor = UIColorFromRGB(0xa7a7a7);
    [self.view addSubview:_textView];
    int height = self.view.frame.size.height;
    int H = 0;
    if (height <= 480) {
        H = 200;
    } else if (height >= 480 && height <= 568) {
        H = 260;
    } else {
        H = 320;
    }
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line).with.offset(rateHeight(10));
        make.left.equalTo(line).offset(rateWidth(20));
        make.right.equalTo(line).with.offset(-rateWidth(20));
        make.height.equalTo(@(rateHeight(85)));
    }];
    self.placehoderLabel = [UILabel new];
    self.placehoderLabel.frame = CGRectMake(4, 5, 200, 20);
    _placehoderLabel.textColor = UIColorFromRGB(0xa7a7a7);
    _placehoderLabel.font = [UIFont systemFontOfSize:13];
    _placehoderLabel.text = @"说说你对产品的感受吧！";
    _placehoderLabel.enabled = NO;
    _placehoderLabel.backgroundColor = [UIColor clearColor];
    [_textView addSubview:_placehoderLabel];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 10;
    _itemWH = rateWidth(90);
    flowLayout.itemSize = CGSizeMake(_itemWH, rateHeight(58));
    flowLayout.minimumInteritemSpacing = _margin;
    flowLayout.minimumLineSpacing = _margin;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(rateWidth(20), _textView.bottom+rateHeight(10), kScreenWidth-rateWidth(40), rateHeight(100)) collectionViewLayout:flowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = UIColorWhite;
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodsImg);
        make.top.equalTo(_textView.mas_bottom).offset(rateHeight(10));
        make.right.equalTo(self.view).offset(-rateWidth(20));
        make.height.equalTo(@(rateHeight(70)));
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = UIColorFromRGB(0xdfdce6);
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(_collectionView.mas_bottom).offset(rateHeight(10));
        make.height.equalTo(@(0.5));
    }];
    
    UIButton *niMingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [niMingBtn setImage:[UIImage imageNamed:@"匿名未选"] forState:(UIControlStateNormal)];
    [self.view addSubview:niMingBtn];
    [niMingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(rateWidth(25));
        make.top.equalTo(line1.mas_bottom).offset(rateHeight(20));
        make.size.mas_offset(CGSizeMake(rateWidth(15), rateWidth(15)));
    }];
    [niMingBtn addTarget:self action:@selector(actionNiMing:) forControlEvents:(UIControlEventTouchUpInside)];
    self.isNiMing = 0;
    
    UILabel *label = [UILabel labelWithText:@"匿名评价" textColor:UIColorFromRGB(0x333333) fontSize:14];
    [label sizeToFit];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(niMingBtn);
        make.left.equalTo(niMingBtn.mas_right).offset(rateWidth(15));
    }];
}
- (void)actionNiMing:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setImage:[UIImage imageNamed:@"匿名选中"] forState:(UIControlStateNormal)];
        _isNiMing = 1;
    } else {
        [btn setImage:[UIImage imageNamed:@"匿名未选"] forState:(UIControlStateNormal)];
        _isNiMing = 0;
    }
}
- (void)actionTouch:(UIButton *)btn
{
    UIButton *button = (UIButton *)_btnArray[btn.tag];
    button.selected = !button.selected;
    if (button.selected) {
        [button setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xfe3102)] forState:UIControlStateNormal];
        _btnIndex = btn.tag;
//        NSLog(@"btnIndex:%ld", (long)_btnIndex);
        for (int i = 0; i < _btnArray.count; i++) {
            UIButton *btn00 = (UIButton *)_btnArray[i];
            if (i != btn.tag) {
                [btn00 setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xc1bfc7)] forState:UIControlStateNormal];
                btn00.selected = NO;
            }
        }
    } else if (button.selected == NO) {
        [button setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xc1bfc7)] forState:UIControlStateNormal];
    }
}
#pragma mark - textView设置placehoder
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _placehoderLabel.text = @"说说你对产品的感受吧！";
    } else {
        _placehoderLabel.text = @"";
    }
}
#pragma mark - 选择图片
- (void)selectImages {
    DPPhotoGroupViewController *controller = [[DPPhotoGroupViewController alloc] init];
    controller.maxSelectionCount = 5;
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
        cell.imageView.image = [UIImage imageNamed:@"zhaoxiangji00"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.gifLable.hidden = YES;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
