//
//  CommonViewController.m
//  家居定制
//
//  Created by iKing on 2017/3/21.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CommonViewController.h"
#import "CommonCell.h"
#import "EaseTextView.h"

@interface CommonViewController ()<EaseTextViewDelegate>
@property (nonatomic, assign) CGFloat keyboardHeight;///< <#注释#>
@property (nonatomic, weak) UIView *sendView;///<<#注释#>
@property (nonatomic, weak) UIButton *send;///<<#注释#>
@property (nonatomic, weak) EaseTextView *textView;///<<#注释#>
@property (nonatomic, weak) UIView *coverView;///<<#注释#>
@end

@implementation CommonViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboareWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboareWillShow:(NSNotification *)aNotification {
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
    self.sendView.bottom = kScreenHeight-self.keyboardHeight-64;
}

- (void)keyboardWillHidden {
    self.sendView.bottom = kScreenHeight-64;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"场景评论";
    [self setupView];
}

- (void)setupView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-40) style:UITableViewStylePlain];
    [self.tableView registerClass:[CommonCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self setupSendView];
}

- (void)setupSendView {
    UIView *sendView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, kScreenWidth, 40)];
    self.sendView = sendView;
    sendView.backgroundColor = RGB(224, 224, 224);
    [self.view addSubview:sendView];
    
//    UIButton *send = [UIButton buttonWithTitle:@"发送" fontSize:16 titleColor:UIColorWhite background:RGB(68, 202, 181) cornerRadius:0];
//    send.frame = CGRectMake(0, 0, 85, 40);
////    send.bottom = sendView.bo
//    send.right = kScreenWidth;
//    [sendView addSubview:send];
    
    EaseTextView *textView = [[EaseTextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    textView.returnKeyType = UIReturnKeySend;
    textView.delegate = self;
    textView.placeHolder = @"说点什么吧...";
    [sendView addSubview:textView];
    
//    [send addActionHandler:^{
//        [textView endEditing:YES];
//    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.common = @"评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CommonCell heightForCell:@"评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容"];
}

#pragma mark - easeview delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    
    float height = [self heightForTextView:textView WithText:textView.text];
    if (height >= 130) {
        height = 130;
    }
    [UIView animateWithDuration:0.5 animations:^{
        textView.height = height;
        textView.top = self.sendView.height-height;
//        self.tableView.height = kScreenHeight-64-height-self.keyboardHeight;
//        self.sendView.top = self.tableView.bottom;
    } completion:nil];
    
    return YES;
}

#pragma mark - EaseTextView
- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    CGSize constraint = CGSizeMake(textView.contentSize.width , CGFLOAT_MAX);
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                        context:nil];
    float textHeight = size.size.height+22.0;
    return textHeight;
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
