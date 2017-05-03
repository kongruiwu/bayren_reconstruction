//
//  CommentViewController.m
//  Bayern
//
//  Created by 吴孔锐 on 16/9/14.
//  Copyright © 2016年 Wusicong. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTableViewCell.h"
#import "CommentModel.h"
#import "CommentView.h"


#import "LoginViewController.h"


@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,CommentCellDelegate>
@property (nonatomic, strong)UITableView * tabview;
@property (nonatomic, strong) UIView * blackView;
@property (nonatomic, strong) UILabel * commentNumber;
@property (nonatomic, strong) CommentView * commentView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, assign) BOOL commentSuccess;

@property (nonatomic, assign) BOOL needMoreData;

@end

@implementation CommentViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerNotification];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeNotification];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"全部评论"];
    [self drawBackButton];
    [self creatUI];
    [self creatCommentTextf];
    [self loadCommentList];
}
- (void)creatUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [[NSMutableArray alloc]init];;
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64 - Anno750(80)) style:UITableViewStyleGrouped];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
    [self creatHeadView];
}
- (void)creatHeadView{
    UIView * headView = [BYFactory creatViewWithColor:[UIColor whiteColor]];
    headView.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(88));
    UILabel * label = [BYFactory creatLabelWithText:@"球迷互动"
                                          fontValue:font750(30)
                                          textColor:BYColor_Main
                                      textAlignment:NSTextAlignmentLeft];
    self.commentNumber = [BYFactory creatLabelWithText:@""
                                             fontValue:font750(26)
                                             textColor:BYColor_Tag
                                         textAlignment:NSTextAlignmentRight];
    UIImageView * icon = [BYFactory creatImageViewWithImage:@"statusbar_talk_gray"];
    UIView * line = [BYFactory creatViewWithColor:BYColor_Main];
    [headView addSubview:label];
    [headView addSubview:self.commentNumber];
    [headView addSubview:icon];
    [headView addSubview:line];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(40)));
        make.bottom.equalTo(@(-Anno750(20)));
    }];
    [self.commentNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(40)));
        make.centerY.equalTo(label.mas_centerY);
    }];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentNumber.mas_left).offset(-Anno750(20));
        make.centerY.equalTo(label.mas_centerY);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(40)));
        make.right.equalTo(@(-Anno750(40)));
        make.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
    self.tabview.tableHeaderView = headView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.needMoreData) {
        return self.dataArray.count+1;
    }
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataArray.count && self.needMoreData) {
        return 50;
    }
    CommentModel * model = self.dataArray[indexPath.row];
    CGSize size = [BYFactory getSize:model.content maxSize:CGSizeMake((UI_WIDTH - Anno750(100)), 99999) font:[UIFont systemFontOfSize:font750(26)]];
    return Anno750(155) + size.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellID = @"CommentTableViewCell";
    CommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    CommentModel * model = self.dataArray[indexPath.row];
    cell.delegate = self;
    [cell updateWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

#pragma mark 评论输入框
- (void)creatCommentTextf{
    UIView * footerView = [BYFactory creatViewWithColor:BYColor_Ground];
    footerView.frame = CGRectMake(0, UI_HEGIHT - Anno750(80) - 64, UI_WIDTH, Anno750(80));
    [self.view addSubview:footerView];

    UIView * whiteView = [BYFactory creatViewWithColor:[UIColor whiteColor]];
    whiteView.layer.cornerRadius = Anno750(30);
    [footerView addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.right.equalTo(@(-Anno750(30)));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(60)));
    }];
    UIImageView * icon = [BYFactory creatImageViewWithImage:@"comment"];
    [whiteView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(20)));
        make.height.with.equalTo(@(Anno750(25)));
        make.centerY.equalTo(@0);
    }];
    UILabel * label = [BYFactory creatLabelWithText:@"评论"
                                          fontValue:font750(28)
                                          textColor:BYColor_gray_6
                                      textAlignment:NSTextAlignmentLeft];
    [footerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(Anno750(20));
        make.centerY.equalTo(@0);
    }];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentKeyBoard)];
    [footerView addGestureRecognizer:tap];

    
    self.commentView = [[CommentView alloc]init];
    self.commentView.frame = CGRectMake(0, UI_HEGIHT, UI_WIDTH, Anno750(250));
    [self.commentView.commitButton addTarget:self action:@selector(commitComment) forControlEvents:UIControlEventTouchUpInside];
    self.commentView.textView.delegate = self;
    
   
    
}
- (void)creatBlackView{
    self.blackView = [BYFactory creatViewWithColor:BYColor_Alpha_gray];
    self.blackView.hidden = YES;
    [self.navigationController.view addSubview:self.blackView];
    [self.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.blackView addSubview:self.commentView];
}
- (void)presentKeyBoard{
    self.blackView.hidden = NO;
    self.commentView.textView.text = @"";
    [self.commentView.textView becomeFirstResponder];
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0) {
        [self.commentView.textView showAllUI:YES];
    }else{
        [self.commentView.textView showAllUI:NO];
    }
}
- (void)commenLikeButtonClick:(UIButton *)btn{
    
    if ([UserManager manager].isLogin) {
        UITableViewCell * cell = (UITableViewCell *)[btn superview];
        NSIndexPath * indexpath = [self.tabview indexPathForCell:cell];
        [self likeCommentRequestWithIndexPath:indexpath];
        
    }else{
        
        [self showLoginMessage];
    }
}

- (void)commitComment{
    if ([UserManager manager].isLogin) {
        [self.commentView startLoading:YES];
        [self addCommentRequest];
    }else{
        [self.commentView.textView resignFirstResponder];
        [self showLoginMessage];
    }
}
- (void)showLoginMessage{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"登陆提示" message:@"你好，请登陆后发表你的回复，我们期待你参与讨论！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * login = [UIAlertAction actionWithTitle:@"登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController * vc = [LoginViewController new];
        vc.isPush = YES;
        vc.index = 2;
        vc.backType = SelectorBackTypeDismiss;
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }];
    UIAlertAction * cannce = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:login];
    [alert addAction:cannce];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}


- (void)registerNotification{
    [self creatBlackView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow1:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden1:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)removeNotification{
    [self.blackView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyBoardWillShow1:(NSNotification *)noti{
    NSDictionary *info = [noti userInfo];
    CGFloat time = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:time animations:^{
        self.commentView.frame = CGRectMake(0, UI_HEGIHT -Anno750(250)-kbSize.height, UI_WIDTH, Anno750(250));
    }];
}
- (void)keyboardWillHidden1:(NSNotification *)noti {
    NSDictionary *info = [noti userInfo];
    CGFloat time = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:time animations:^{
        self.commentView.frame = CGRectMake(0, UI_HEGIHT, UI_WIDTH, Anno750(250));
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.blackView.hidden = YES;
        if (self.commentSuccess) {
            [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"评论发表成功!"
                                 duration:1.0f completion:^{
                                     self.commentSuccess = NO;
            }];
        }
    });
}
- (void)addCommentRequest{
    NSDictionary * params = @{
                              @"nid":self.newsID,
                              @"uid":[UserManager manager].userid,
                              @"callback_verify":[UserManager manager].token,
                              @"content":self.commentView.textView.text
                              };
    [[NetWorkManger manager] sendRequest:Page_AddComment route:Route_News withParams:params complete:^(NSDictionary *result) {
        [self.commentView startLoading:NO];
        NSDictionary * dic1 = result[@"data"];
        NSDictionary * commentDic = dic1[@"comment"];
        CommentModel * model = [[CommentModel alloc]initWithDictionary:commentDic];
        [self.dataArray insertObject:model atIndex:0];
        [self.tabview reloadData];
        self.commentSuccess = YES;
        [self.commentView.textView endEditing:YES];
    } error:^(BYError *byerror) {
        [self.commentView startLoading:NO];
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];

}
//获取数据
- (void)loadCommentList{
    NSString * idNum = @"";
    if (self.dataArray.count>0) {
        CommentModel * model = self.dataArray.lastObject;
        idNum = [NSString stringWithFormat:@"%@",model.id];
    }
    NSDictionary * params = @{
                            @"nid":self.newsID,
                            @"last_id":idNum,
                            @"uid":[UserManager manager].userid
                              };
    [[NetWorkManger manager] sendRequest:Page_commentList route:Route_News withParams:params complete:^(NSDictionary *result) {
        NSDictionary * comment = result[@"info"];
        self.commentNumber.text = [NSString stringWithFormat:@"%@",comment[@"all_count"]];
        id list = result[@"data"];
        if(list && ![list isKindOfClass:[NSNull class]]){
            NSArray * arr = (NSArray *)list;
            for (int i = 0; i < arr.count; i ++) {
                NSDictionary * dic = arr[i];
                CommentModel * model = [[CommentModel alloc]initWithDictionary:dic];
                [self.dataArray addObject:model];
            }
        }
        [self.tabview reloadData];
    } error:^(BYError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}
#pragma mark 点赞
- (void)likeCommentRequestWithIndexPath:(NSIndexPath *)indepath{
    CommentModel * model = self.dataArray[indepath.row];
    NSDictionary * params = @{
                              @"cid":[NSString stringWithFormat:@"%@",model.id],
                              @"uid":[UserManager manager].userid,
                              @"callback_verify":[UserManager manager].token
                              };
    [[NetWorkManger manager] sendRequest:Page_AtCommet route:Route_News withParams:params complete:^(NSDictionary *result) {
        model.gooded = YES;
        model.good = @(model.good.longValue +1);
        [self.tabview reloadData];
    } error:^(BYError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}


@end
