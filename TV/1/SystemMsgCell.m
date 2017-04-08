//
//  SystemMsgCell.m
//  家居定制
//
//  Created by iKing on 2017/3/18.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "SystemMsgCell.h"
#import "SystemMsgLabel.h"

@interface SystemMsgCell ()
@property (nonatomic, weak) SystemMsgLabel *contentLabel;///<<#注释#>

@end

@implementation SystemMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 65)];
        time.text = @"8月20日   14:27";
        self.time = time;
        time.textAlignment = NSTextAlignmentCenter;
        time.font = [UIFont systemFontOfSize:14];
        time.textColor = RGB(124, 124, 124);
        [self.contentView addSubview:time];
        
        SystemMsgLabel *content = [[SystemMsgLabel alloc] initWithFrame:CGRectMake(15, time.bottom, kScreenWidth-30, 100)];
        
        content.userInteractionEnabled = YES;
//        [content addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];
        content.layer.cornerRadius = 5;
        content.layer.masksToBounds = YES;
        content.numberOfLines = 0;
        content.backgroundColor = RGB(221, 221, 221);
        content.textColor = UIColorBlack;
        content.font = [UIFont systemFontOfSize:16];
        self.contentLabel = content;
        [self.contentView addSubview:content];
    }
    return self;
}

+ (CGFloat)heightForContent:(NSString *)content {
    NSMutableParagraphStyle *paraStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paraStyle.headIndent = 2;
    paraStyle.lineSpacing = 5;
    paraStyle.firstLineHeadIndent = 32;
    CGSize strSize = [content getSizeWithMaxSize:CGSizeMake(kScreenWidth-30, CGFLOAT_MAX) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSParagraphStyleAttributeName: paraStyle}];
    return strSize.height+65+10;
}

- (void)setContent:(NSString *)content {
    _content = content;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.headIndent = 2;
    paraStyle.lineSpacing = 5;
    paraStyle.firstLineHeadIndent = self.contentLabel.font.pointSize*2;
    CGSize strSize = [content getSizeWithMaxSize:CGSizeMake(kScreenWidth-30, CGFLOAT_MAX) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSParagraphStyleAttributeName: paraStyle}];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSParagraphStyleAttributeName: paraStyle}];
    self.contentLabel.height = strSize.height+10;
    self.contentLabel.attributedText = attr;
}

- (void)longPress:(UILongPressGestureRecognizer *)gr {
    [self.contentLabel becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    // 设置菜单内容
    menu.menuItems = @[
                       [[UIMenuItem alloc] initWithTitle:@"删除全部" action:@selector(removeAll:)],
                       [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(remove:)]
                       ];
    self.menu = menu;
    // 显示位置 ： 参考Cell的左上角，指向Cell中间的一条高1的位置
    /*
     targetRect：menuController指向的矩形框
     targetView：targetRect以targetView的左上角为坐标原点
     */
    CGRect rect = CGRectMake(0, 5, kScreenWidth, 1);
    [menu setTargetRect:rect inView:self.contentLabel];
    // 显示出来
    [menu setMenuVisible:YES animated:YES];
}

-(BOOL)canBecomeFirstResponder{
    
    return YES;
    
}
// 用于UIMenuController显示，缺一不可
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if (action ==@selector(remove:) || action ==@selector(removeAll:)){
        
        return YES;
        
    }
    
    return NO;//隐藏系统默认的菜单项
}

- (void)remove:(UIMenuItem *)item {
    
}

- (void)removeAll:(UIMenuItem  *)item {
    
}

@end
