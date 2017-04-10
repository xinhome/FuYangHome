//
//  CustomMadeViewController.m
//  家居定制
//
//  Created by iKing on 2017/4/5.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CustomMadeViewController.h"
#import "EaseTextView.h"
#import "TZTestCell.h"
#import "TZImagePickerController.h"
#import "CustomIntroductionController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface CustomMadeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UITextFieldDelegate>
@property (nonatomic, weak) UITextField *name;///<姓名
@property (nonatomic, weak) UITextField *telephone;///<电话
@property (nonatomic, weak) UITextField *address;///<地址
@property (nonatomic, weak) UITextField *roomArea; // 面积
@property (nonatomic, weak) EaseTextView *textView;
@property (nonatomic, strong) UICollectionView *collectionView;///<<#注释#>
@property (nonatomic, strong) NSMutableArray<UIImage *> *selectedPhotos;///<<#注释#>
@end

@implementation CustomMadeViewController {
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    CGFloat _itemWH;
    CGFloat _margin;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:UIColorWhite] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全屋订制";
    [self setupUI];
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
}
- (void)setupUI {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    scrollView.backgroundColor = RGB(240, 240, 240);
    [self.view addSubview:scrollView];
    
    UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake(0, 25, rateWidth(230), 40)];
    name.backgroundColor = UIColorWhite;
    name.centerX = kScreenWidth/2;
    [scrollView addSubview:name];
    self.name = name;
    
    UITextField *telephone = [[UITextField alloc] initWithFrame:CGRectMake(0, name.bottom+17, rateWidth(230), 40)];
    telephone.placeholder = @"请填写真实号码";
    telephone.backgroundColor = UIColorWhite;
    telephone.centerX = kScreenWidth/2;
    [scrollView addSubview:telephone];
    self.telephone = telephone;
    _telephone.delegate = self;

    UITextField *address = [[UITextField alloc] initWithFrame:CGRectMake(0, telephone.bottom+17, rateWidth(230), 40)];
    address.placeholder = @"请具体到小区名称";
    address.backgroundColor = UIColorWhite;
    address.centerX = kScreenWidth/2;
    [scrollView addSubview:address];
    self.address = address;
    
    UILabel *label1 = [UILabel labelWithText:@"姓名" textColor:UIColorFromRGB(0x333333) fontSize:17];
    [label1 sizeToFit];
    label1.right = name.left-rateWidth(20);
    label1.centerY = name.centerY;
    [scrollView addSubview:label1];
    
    UILabel *label2 = [UILabel labelWithText:@"电话" textColor:UIColorFromRGB(0x333333) fontSize:16];
    [label2 sizeToFit];
    label2.right = telephone.left-rateWidth(20);
    label2.centerY = telephone.centerY;
    [scrollView addSubview:label2];
    
    UILabel *label3 = [UILabel labelWithText:@"地址" textColor:UIColorFromRGB(0x333333) fontSize:16];
    [label3 sizeToFit];
    label3.right = address.left-rateWidth(20);
    label3.centerY = address.centerY;
    [scrollView addSubview:label3];
    
    UILabel *label4 = [UILabel labelWithText:@"房屋面积" textColor:UIColorFromRGB(0x333333) fontSize:16];
    label4.frame = CGRectMake(label3.left, label3.bottom+35, 0, 0);
    [label4 sizeToFit];
    [scrollView addSubview:label4];
    
    UITextField *roomArea = [[UITextField alloc] initWithFrame:CGRectMake(label4.right+rateWidth(19), address.bottom+17, rateWidth(195), 40)];
    roomArea.backgroundColor = UIColorWhite;
    [scrollView addSubview:roomArea];
    self.roomArea = roomArea;
    UILabel *meterLabel = [UILabel labelWithText:@"m²" textColor:UIColorFromRGB(0x333333) fontSize:16];
    [meterLabel sizeToFit];
    meterLabel.left = roomArea.right+10;
    meterLabel.centerY = roomArea.centerY;
    [scrollView addSubview:meterLabel];
    
    UILabel *label5 = [UILabel labelWithText:@"设计需求" textColor:UIColorFromRGB(0x333333) fontSize:16];
    label5.frame = CGRectMake(label4.left, label4.bottom+50, 0, 0);
    [label5 sizeToFit];
    [scrollView addSubview:label5];
    
    EaseTextView *textView = [[EaseTextView alloc] initWithFrame:CGRectMake(label5.right+rateWidth(19), roomArea.bottom+17, rateWidth(225), 100)];
    textView.placeHolder = @"注明主要功能";
    [scrollView addSubview:textView];
    self.textView = textView;
    
    UILabel *label6 = [UILabel labelWithText:@"俯视图" textColor:UIColorFromRGB(0x333333) fontSize:16];
    label6.frame = CGRectMake(label5.left, label5.bottom+130, 0, 0);
    [label6 sizeToFit];
    [scrollView addSubview:label6];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 0;
    _itemWH = 85;
    flowLayout.itemSize = CGSizeMake(_itemWH, _itemWH);
    flowLayout.minimumInteritemSpacing = _margin;
    flowLayout.minimumLineSpacing = _margin;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(label6.right+35, textView.bottom+30, rateWidth(230), 85) collectionViewLayout:flowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
//    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    
    [scrollView addSubview:self.collectionView];
    
    UIButton *detailIntroductionsBtn = [UIButton buttonWithTitle:@"详细说明>" fontSize:14 titleColor:RGB(172, 220, 212) background:[UIColor clearColor] cornerRadius:0];
    [detailIntroductionsBtn addActionHandler:^{
        [self pushViewController:[[CustomIntroductionController alloc] init] animation:YES];
    }];
    detailIntroductionsBtn.layer.borderColor = RGB(172, 220, 212).CGColor;
    detailIntroductionsBtn.layer.borderWidth = 0.7;
    detailIntroductionsBtn.frame = CGRectMake(0, self.collectionView.bottom+rateHeight(32), 85, 28);
    detailIntroductionsBtn.right = kScreenWidth-15;
    [scrollView addSubview:detailIntroductionsBtn];
    
    UIButton *commitBtn = [UIButton buttonWithTitle:@"支付" fontSize:14 titleColor:RGB(172, 220, 212) background:[UIColor clearColor] cornerRadius:0];
    commitBtn.layer.borderColor = RGB(172, 220, 212).CGColor;
    commitBtn.layer.borderWidth = 0.7;
    commitBtn.frame = CGRectMake(0, detailIntroductionsBtn.bottom+28, rateWidth(152), 36);
    commitBtn.centerX = kScreenWidth/2;
    [scrollView addSubview:commitBtn];
    scrollView.contentSize = CGSizeMake(0, commitBtn.bottom+150);
    [commitBtn addActionHandler:^{
        [self tiJiao];
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![self.telephone.text isMobileNumber]) {
        [MBProgressHUD showError:@"请输入正确手机号"];
        return;
    }
}
#pragma mark - 提交
- (void)tiJiao
{
    if (_name.text.length != 0 && _telephone.text.length != 0 && _address.text.length != 0 && _roomArea.text.length != 0 && _textView.text.length != 0 && _selectedPhotos.count != 0) {
        [MBProgressHUD showMessage:@"正在提交..." toView:self.view];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userId = [userDefaults valueForKey:@"myUserId"];
        NSDictionary *parameters = @{
                                     @"userId": userId,
                                     @"nick":_name.text,
                                     @"pone":_telephone.text,
                                     @"address":_address.text,
                                     @"area":_roomArea.text,
                                     @"design":_textView.text,
                                     @"amount":@"0.01"
                                     };
        NSLog(@"%@", parameters);
        NSLog(@"%@", [NSString stringWithFormat:@"%@design/buy", WeiMingURL]);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:[NSString stringWithFormat:@"%@design/buy", WeiMingURL] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (UIImage *image in self.selectedPhotos) {
                NSString *fileName = [NSString stringWithFormat:@"%d", arc4random()];
                [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.3) name:@"uploadFile" fileName:[NSString stringWithFormat:@"%@.jpg", fileName]  mimeType:@"image/jpeg"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD hideHUDForView:self.view];
//            NSLog(@"定制：%@", responseObject);
//            [MBProgressHUD showSuccess:@"提交成功"];
            [[AlipaySDK defaultService] payOrder:responseObject[@"data"] fromScheme:@"fuyangjiaju" callback:^(NSDictionary *resultDic) {
//                NSLog(@"%@", resultDic);
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"网络异常"];
        }];
    } else {
        [MBProgressHUD showError:@"请把信息填写完整"];
    }
}
#pragma mark - 支付


#pragma mark - collectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"俯视图"];
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
