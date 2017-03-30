//
//  ProductDetailController.m
//  家居定制
//
//  Created by iKing on 2017/3/21.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ProductDetailController.h"
#import "ProductDetailHeaderView.h"
#import "ProductDetailCell.h"
#import "ProductDetailModel.h"
#import "ParamDataModel.h"

@interface ProductDetailController ()
@property (nonatomic, weak) UILabel *count;///<<#注释#>
@property (nonatomic, strong) ProductDetailHeaderView *headerView;///<<#注释#>
@property (nonatomic, strong) NSArray<NSString *> *productShow;///<产品展示
@property (nonatomic, strong) ProductDetailModel *model1;///<商品详情
@end

@implementation ProductDetailController {
    int _num;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品详情";
    _num = 1;
    [self setupUI];
    
    [self loadData];
}

- (void)loadData {
    
//    [[AFHTTPSessionManager manager] POST:@"http://xwmasd.ngrok.cc/Item/ById" parameters:@{@"itemId": self.itemID} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
    [[HttpRequestManager shareManager] addPOSTURL:@"/Item/ById" person:RequestPersonWeiMing parameters:@{@"itemId": self.itemID} success:^(id successResponse) {
        if ([successResponse isSuccess]) {
            ProductDetailModel *model = [ProductDetailModel mj_objectWithKeyValues:successResponse[@"data"]];
            self.model1 = model;
            NSString *paramData = successResponse[@"data"][@"paramData"];
            NSDictionary *dict = [paramData mj_JSONObject];
            NSArray<ParamDataModel *> *model2 = [ParamDataModel mj_objectArrayWithKeyValuesArray:dict];
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSString *imageStr in [model.image componentsSeparatedByString:@","]) {
                [arrM addObject:[NSString stringWithFormat:@"%@%@", WEIMING, imageStr]];
            }
            self.headerView.cycleView.imageURLStringsGroup = arrM;
            self.headerView.nameLabel.text = model.title;
            self.headerView.priceLabel.text = [NSString stringWithFormat:@"￥ %@", model.price];
            self.headerView.model = model2.firstObject;
            self.productShow = [successResponse[@"data"][@"itemDesc"] filterImageUrl];
            [self.tableView reloadData];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD showError:@"网络错误"];
    }];
    
}

- (void)setupUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-60) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[ProductDetailCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self setupHeaderView];
    
    [self setupToolView];
}

- (void)setupToolView {
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-60-64, kScreenWidth, 60)];
    toolView.backgroundColor = RGB(69, 69, 69);
    
    UIButton *sub = [UIButton buttonWithType:UIButtonTypeCustom];
    [sub addActionHandler:^{
        [self jianhao];
    }];
    [sub setImage:UIImageNamed(@"jianhao") forState:UIControlStateNormal];
    sub.frame = CGRectMake(25, 17.5, 25, 25);
    [toolView addSubview:sub];
    
    UILabel *count = [UILabel labelWithText:@"1" textColor:RGB(83, 204, 185) fontSize:14];
    self.count = count;
    count.textAlignment = NSTextAlignmentCenter;
    count.backgroundColor = UIColorWhite;
    count.frame = CGRectMake(sub.right+15, 0, 50, 25);
    count.centerY = sub.centerY;
    [toolView addSubview:count];
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
    [add addActionHandler:^{
        [self add];
    }];
    [add setImage:UIImageNamed(@"jiahao") forState:UIControlStateNormal];
    add.frame = CGRectMake(count.right+15, 17.5, 25, 25);
    [toolView addSubview:add];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 1, 20)];
    line.backgroundColor = UIColorWhite;
    line.centerX = kScreenWidth/2;
    [toolView addSubview:line];
    
    UIButton *addShopCar = [UIButton buttonWithTitle:@"加入购物车" fontSize:13 titleColor:UIColorWhite background:[UIColor clearColor] cornerRadius:0];
    [addShopCar addActionHandler:^{
        [self addToShopCar]; // 加入购物车
    }];
    addShopCar.frame = CGRectMake(line.right+15, 0, 80, 13);
    addShopCar.centerY = line.centerY;
    [toolView addSubview:addShopCar];
    
    UIView *circelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    circelView.backgroundColor = RGB(69, 69, 69);
    circelView.layer.cornerRadius = 25;
    circelView.layer.masksToBounds = YES;
    circelView.centerY = 10;
    circelView.right = kScreenWidth;
    [toolView addSubview:circelView];
    
    [self.view addSubview:toolView];
}

- (void)addToShopCar {
    
    if (self.model1 == nil) {
        [MBProgressHUD showError:@"网络异常"];
        return;
    }
    
    if (self.headerView.selectedColor == nil) {
        [MBProgressHUD showError:@"请选择颜色"];
        return;
    }
    if (self.headerView.selectedSize == nil) {
        [MBProgressHUD showError:@"请选择规格"];
        return;
    }
    float totalFee = _num*[self.model1.price floatValue];
    NSDictionary *parameters = @{
                                 @"picPath": [self.model1.image componentsSeparatedByString:@","].firstObject,
                                 @"totalFee": @(totalFee),
                                 @"price": self.model1.price,
                                 @"title": self.model1.title,
                                 @"num": @(_num),
                                 @"itemId": self.itemID,
                                 @"userId": self.user.ID,
                                 @"colour": self.headerView.selectedColor,
                                 @"style": self.headerView.selectedSize
                                 };
    [MBProgressHUD showMessage:@"正在添加购物车" toView:self.view];
//    [[AFHTTPSessionManager manager] POST:@"http://xwmasd.ngrok.cc/FyHome/Order/addCar" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
    [[HttpRequestManager shareManager] addPOSTURL:@"/Order/addCar" person:RequestPersonWeiMing parameters:parameters success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([successResponse isSuccess]) {
            [MBProgressHUD showSuccess:@"成功加入购车"];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
//        NSLog(@"%@", successResponse);
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常"];
    }];
}

- (void)add {
    _num = _num + 1;
    self.count.text = [NSString stringWithFormat:@"%d",_num];
}

- (void)jianhao {
    if (_num == 0) {
        return;
    }
    _num--;
    self.count.text = [NSString stringWithFormat:@"%d",_num];
}

- (void)setupHeaderView {
    ProductDetailHeaderView *headerView = [[ProductDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(425)+207)];
    self.headerView = headerView;
    self.tableView.tableHeaderView = headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productShow.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSLog(@"%@", [NSString stringWithFormat:@"%@%@", WEIMING, self.productShow[indexPath.row]]);
    [cell.iv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, self.productShow[indexPath.row]]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 57+rateHeight(440);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = RGB(224, 224, 224);
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 30)];
    line.backgroundColor = RGB(83, 204, 185);
    [view addSubview:line];
    UILabel *label = [UILabel labelWithText:@"产品展示" textColor:RGB(132, 132, 132) fontSize:13];
    [label sizeToFit];
    label.left = line.right+20;
    label.centerY = view.centerY;
    [view addSubview:label];
    return view;
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
