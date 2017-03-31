//
//  ReturnGoodsDetaildsViewController.m
//  家居定制
//
//  Created by iking on 2017/3/27.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ReturnGoodsDetaildsViewController.h"
#import "DPPhotoGroupViewController.h"
#import "TZTestCell.h"
#import "TZImagePickerController.h"

@interface ReturnGoodsDetaildsViewController ()<UITableViewDelegate, UITableViewDataSource,UITextViewDelegate,DPPhotoGroupViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, TZImagePickerControllerDelegate>
{
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    CGFloat _itemWH;
    CGFloat _margin;
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) UILabel *numLB;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placehoderLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;

@end

@implementation ReturnGoodsDetaildsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.num = 1;
    self.navigationItem.title = @"退换货";
    [self.view addSubview:self.myTableView];
}
#pragma mark - setUpData
- (void)setUpData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (UIImage *image in _selectedPhotos) {
        NSString *string = [UIImageJPEGRepresentation(image, 1.0) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        dict[[NSString stringWithFormat:@"goodsImage%lu", (unsigned long)[_selectedPhotos indexOfObject:image]]] = string;
    }
    NSString *jsonStr = [dict mj_JSONString];
    
    [MBProgressHUD showMessage:@"正在提交..." toView:self.view];
    NSDictionary *parameters = @{
                                 @"orderId": _model.orderId,
                                 @"reason": self.textView.text,
                                 @"num": @(self.num),
                                 @"image": jsonStr
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
    [manager POST:[NSString stringWithFormat:@"%@Order/saveReturn", WeiMingURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"退货：%@", responseObject);
        [MBProgressHUD showSuccess:@"提交成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [MBProgressHUD showError:@"网络异常"];
    }];
}
#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            UILabel *numLB = [UILabel labelWithText:[NSString stringWithFormat:@"订单编号：%@", _model.orderId] textColor:UIColorFromRGB(0x666666) fontSize:14];
            numLB.frame = CGRectMake(rateWidth(20), rateHeight(15), 0, 0);
            [numLB sizeToFit];
            [cell.contentView addSubview:numLB];
            
            UIView *bgView = [UIView new];
            bgView.backgroundColor = UIColorFromRGB(0xf7f7f7);
            [cell.contentView addSubview:bgView];
            [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(numLB.mas_bottom).offset(rateHeight(15));
                make.left.equalTo(cell.contentView);
                make.bottom.equalTo(cell.contentView);
                make.width.equalTo(@(kScreenWidth));
            }];
            
            UIImageView *image = [UIImageView new];
            image.backgroundColor = [UIColor whiteColor];
            [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WeiMingURL,_model.picPath]]];
            [bgView addSubview:image];
            [image mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(bgView).offset(rateWidth(25));
                make.centerY.equalTo(bgView);
                make.size.mas_offset(CGSizeMake(rateHeight(80), rateHeight(80)));
            }];
            
            UILabel *label1 = [UILabel labelWithText:_model.title textColor:UIColorFromRGB(0x333333) fontSize:15];
            [label1 sizeToFit];
            [bgView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(image.mas_right).offset(rateWidth(15));
                make.top.equalTo(image).offset(rateHeight(5));
            }];
            
            UILabel *label2 = [UILabel labelWithText:[NSString stringWithFormat:@"数量：%@件", _model.num] textColor:UIColorFromRGB(0x333333) fontSize:15];
            [label2 sizeToFit];
            [bgView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(image.mas_right).offset(rateWidth(15));
                make.centerY.equalTo(image);
            }];
            
            UILabel *label3 = [UILabel labelWithText:[NSString stringWithFormat:@"单价：￥%.2f", [_model.price floatValue]] textColor:RGB(242, 0, 0) fontSize:14];
            [label3 sizeToFit];
            [bgView addSubview:label3];
            [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(image.mas_right).offset(rateWidth(15));
                make.bottom.equalTo(image.mas_bottom).offset(-rateHeight(5));
            }];
            cell.selectionStyle = NO;
            return cell;
        }
            break;
        case 1:
        {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            UILabel *label = [UILabel labelWithText:@"退货数量" textColor:UIColorFromRGB(0x333333) fontSize:13];
            [label sizeToFit];
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(rateWidth(20));
                make.top.equalTo(cell.contentView).offset(rateHeight(15));
            }];
            
            UILabel *btnLabel = [UILabel labelWithText:[NSString stringWithFormat:@"%ld", (long)self.num] textColor:UIColorFromRGB(0x333333) fontSize:13];
            btnLabel.textAlignment = NSTextAlignmentCenter;
            btnLabel.layer.masksToBounds = YES;
            btnLabel.layer.cornerRadius = 3;
            btnLabel.layer.borderWidth = 1;
            btnLabel.layer.borderColor = RGB(199, 199, 199).CGColor;
            btnLabel.backgroundColor = UIColorFromRGB(0xf2f2f2);
            [cell.contentView addSubview:btnLabel];
            [btnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(label.mas_bottom).offset(rateHeight(17));
                make.left.equalTo(cell.contentView).offset(rateWidth(70));
                make.size.mas_offset(CGSizeMake(rateWidth(114), rateHeight(31)));
            }];
            self.numLB = btnLabel;
            self.numLB.userInteractionEnabled = YES;
            
            for (int i = 0; i < 2; i++) {
                UIView *line = [UIView new];
                line.backgroundColor = RGB(199, 199, 199);
                [btnLabel addSubview:line];
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(btnLabel).offset(1);
                    make.bottom.equalTo(btnLabel).offset(-1);
                    make.left.equalTo(btnLabel).offset(rateWidth(38+38*i));
                    make.width.equalTo(@(1));
                }];
            }
            
            UIButton *jianBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [jianBtn setImage:[UIImage imageNamed:@"矩形 45"] forState:(UIControlStateNormal)];
            [btnLabel addSubview:jianBtn];
            [jianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(btnLabel);
                make.left.equalTo(btnLabel).offset(rateWidth(10));
                make.size.mas_offset(CGSizeMake(rateWidth(20), rateWidth(20)));
            }];
            [jianBtn addTarget:self action:@selector(jianNum:) forControlEvents:(UIControlEventTouchUpInside)];
            
            UIButton *jiaBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [jiaBtn setImage:[UIImage imageNamed:@"+"] forState:(UIControlStateNormal)];
            [btnLabel addSubview:jiaBtn];
            [jiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(btnLabel);
                make.right.equalTo(btnLabel).offset(-rateWidth(10));
                make.size.mas_offset(CGSizeMake(rateWidth(20), rateWidth(20)));
            }];
            [jiaBtn addTarget:self action:@selector(jiaNum:) forControlEvents:(UIControlEventTouchUpInside)];
            
            cell.selectionStyle = NO;
            return cell;
        }
            break;
        case 2:
        {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            UILabel *label = [UILabel labelWithText:@"问题描述" textColor:UIColorFromRGB(0x333333) fontSize:13];
            [label sizeToFit];
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(rateWidth(20));
                make.top.equalTo(cell.contentView).offset(rateHeight(15));
            }];
            UIView *line = [UIView new];
            line.backgroundColor = RGB(227, 228, 233);
            [cell.contentView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(label);
                make.right.equalTo(cell.contentView);
                make.top.equalTo(label.mas_bottom).offset(rateHeight(12));
                make.height.equalTo(@(1));
            }];
            
            self.textView = [UITextView new];
            _textView.font = [UIFont systemFontOfSize:13.0];
            _textView.delegate = self;
            _textView.textColor = UIColorFromRGB(0xa7a7a7);
            [cell.contentView addSubview:_textView];
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
                make.top.equalTo(line).with.offset(rateHeight(14));
                make.left.equalTo(line);
                make.right.equalTo(cell.contentView).with.offset(-rateWidth(20));
                make.bottom.equalTo(cell.contentView).with.offset(-rateHeight(10));
            }];
            self.placehoderLabel = [UILabel new];
            self.placehoderLabel.frame = CGRectMake(4, 5, 200, 20);
            _placehoderLabel.textColor = UIColorFromRGB(0xa7a7a7);
            _placehoderLabel.font = [UIFont systemFontOfSize:13];
            _placehoderLabel.text = @"请您在此描述详细问题";
            _placehoderLabel.enabled = NO;
            _placehoderLabel.backgroundColor = [UIColor clearColor];
            [_textView addSubview:_placehoderLabel];
            
            cell.selectionStyle = NO;
            return cell;
        }
            break;
        default:
        {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            UILabel *label = [UILabel labelWithText:@"上传照片" textColor:UIColorFromRGB(0x333333) fontSize:13];
            [label sizeToFit];
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(rateWidth(20));
                make.top.equalTo(cell.contentView).offset(rateHeight(15));
            }];
            
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            _margin = 10;
            _itemWH = rateWidth(90);
            flowLayout.itemSize = CGSizeMake(_itemWH, rateHeight(58));
            flowLayout.minimumInteritemSpacing = _margin;
            flowLayout.minimumLineSpacing = _margin;
            self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(rateWidth(20), label.bottom+rateHeight(24), kScreenWidth-rateWidth(40), rateHeight(100)) collectionViewLayout:flowLayout];
            _collectionView.alwaysBounceVertical = YES;
            _collectionView.backgroundColor = UIColorWhite;
            _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
            _collectionView.dataSource = self;
            _collectionView.delegate = self;
            _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
            [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
            [cell.contentView addSubview:_collectionView];
            
            UILabel *bottomLB = [UILabel labelWithText:@"为了帮助我们更好的解决问题，请上传照片。最多5张，每张不超过5M，支持JPG、BMP、PNG" textColor:UIColorFromRGB(0xa7a7a7) fontSize:13];
            bottomLB.numberOfLines = 0;
            bottomLB.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:bottomLB];
            [bottomLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(label);
                make.width.equalTo(@(kScreenWidth-rateWidth(40)));
                make.bottom.equalTo(cell.contentView).offset(-rateHeight(18));
            }];
            
            cell.selectionStyle = NO;
            return cell;
        }
            break;
    }
}
- (void)jianNum:(UIButton *)btn
{
    if (self.num > 1) {
        self.num = self.num - 1;
        self.numLB.text = [NSString stringWithFormat:@"%ld", (long)self.num];
    }
}
- (void)jiaNum:(UIButton *)btn
{
    if (self.num < [_model.num intValue]) {
        self.num = self.num + 1;
        self.numLB.text = [NSString stringWithFormat:@"%ld", (long)self.num];
    }
}
#pragma mark - textView设置placehoder
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _placehoderLabel.text = @"请您在此描述详细问题";
    } else {
        _placehoderLabel.text = @"";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return rateHeight(140);
            break;
        case 1:
            return rateHeight(100);
            break;
        case 2:
            return rateHeight(170);
            break;
        default:
            return rateHeight(170);
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return rateHeight(230);
    } else {
        return rateHeight(10);
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(200))];
        bgView.backgroundColor = [UIColor clearColor];
        UILabel *label = [UILabel labelWithText:@"售后客服电话：12312123897" textColor:UIColorFromRGB(0x999999) fontSize:13];
        [label sizeToFit];
        [bgView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(rateWidth(20));
            make.top.equalTo(bgView).offset(rateHeight(15));
        }];
        
        UIButton *tiJiaoBtn = [UIButton buttonWithTitle:@"提交" fontSize:17 titleColor:[UIColor whiteColor] background:UIColorFromRGB(0xed2f2f) cornerRadius:6];
        [bgView addSubview:tiJiaoBtn];
        [tiJiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom).offset(rateHeight(70));
            make.centerX.equalTo(bgView);
            make.size.mas_offset(CGSizeMake(rateWidth(314), rateHeight(50)));
        }];
        [tiJiaoBtn addActionHandler:^{
            [self setUpData];
        }];
        return bgView;
    } else {
        return nil;
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
        cell.imageView.image = [UIImage imageNamed:@"添加图片"];
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

- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStyleGrouped)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = NO;
        
    }
    return _myTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
