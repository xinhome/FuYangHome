//
//  AboutViewController.m
//  TV
//
//  Created by HOME on 16/9/14.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self addBackForUser];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = UIColorWhite;
    [self.view addSubview:scrollView];
    
    UILabel *label1 = [UILabel labelWithText:@"联系电话:" textColor:UIColorBlack fontSize:17];
    [label1 sizeToFit];
    label1.origin = CGPointMake(14, 15);
    [scrollView addSubview:label1];
    UILabel *telephone = [UILabel labelWithText:@"0530-3433938" textColor:RGB(138, 138, 138) fontSize:17];
    [telephone sizeToFit];
    telephone.centerY = label1.centerY;
    telephone.left = label1.right+10;
    [scrollView addSubview:telephone];
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, label1.bottom+15, kScreenWidth, 0.7)];
    line1.backgroundColor = RGB(241, 241, 241);
    [scrollView addSubview:line1];
    
    UILabel *label2 = [UILabel labelWithText:@"办公地址:" textColor:UIColorBlack fontSize:17];
    [label2 sizeToFit];
    label2.origin = CGPointMake(14, line1.bottom+15);
    [scrollView addSubview:label2];
    
    NSString *address = @"山东省菏泽市曹县牡丹江路166号";
    UILabel *addressLabel = [UILabel labelWithText:address textColor:RGB(138, 138, 138) fontSize:17];
    addressLabel.numberOfLines = 0;
    CGSize addressSize = [address getSizeWithMaxSize:CGSizeMake(kScreenWidth-label2.right-10-10, CGFLOAT_MAX) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    addressLabel.frame = CGRectMake(label2.right+10, line1.bottom+15, addressSize.width, addressSize.height);
    [scrollView addSubview:addressLabel];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, addressLabel.bottom+15, kScreenWidth, 0.7)];
    line2.backgroundColor = RGB(241, 241, 241);
    [scrollView addSubview:line2];
    
    UILabel *label3 = [UILabel labelWithText:@"公司简介:" textColor:UIColorBlack fontSize:17];
    [label3 sizeToFit];
    label3.origin = CGPointMake(14, line2.bottom+15);
    [scrollView addSubview:label3];
    
    NSString *descString = @"山东富洋工艺有限公司成立于2006年11月，注册资本8000万美元，属外商独资企业。公司位于山东省曹县开发区牡丹江路166号，占地面积20万平方米，建筑面积16万平方米，拥有干部职工800余人。公司主要生产高、中、低档家具、棺木、灯具等系列产品，已荣获国家外观设计、实用新型等9项专利。山东富洋工艺有限公司依靠雄厚的技术力量、成熟可靠的生产工艺，形成了完善的原料供应、生产管理和市场销售体系。目前，公司已通过ISO9001国际质量管理体系、OHSAS18001职业健康安全管理体系认证、ISO14001环境管理体系。规范现代化的企业管理，使公司生产规模迅速扩大，2011年实现销售收入5.7亿元。公司经济效益稳步增长，已呈现出超常规、跳跃式发展的良好态势。山东富洋工艺有限公司先后被评为“明星企业”、“菏泽市优秀中小企业”、“菏泽市优秀企业”、“菏泽市工商联优秀会员企业”、“菏泽市对外贸易十强企业”。现公司采用多元化经营模式的同时，又专注于公司自己的特色产品，拥有自己的研发中心，在新产品开发上，公司秉承“人无我有，人有我全，人全我新”的创新理念，采取现代化的精艺工艺流程，及时更新花色品种；在经营管理上，推行日本6S的管理模式，提高公司的现代化管理水平；在产业化发展的道路上，起到了排头兵的典范作用。";
    UILabel *descLabel = [UILabel labelWithText:descString textColor:RGB(138, 138, 138) fontSize:17];
    descLabel.numberOfLines = 0;
    CGSize descSize = [descString getSizeWithMaxSize:CGSizeMake(kScreenWidth-label3.right-10-10, CGFLOAT_MAX) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    descLabel.frame = CGRectMake(label3.right+10, line2.bottom+15, descSize.width, descSize.height);
    [scrollView addSubview:descLabel];
    scrollView.contentSize = CGSizeMake(0, descLabel.bottom+64);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
