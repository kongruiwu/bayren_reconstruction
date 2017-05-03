//
//  NewsDetailViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "NewsDetailViewController.h"
#import <WebKit/WebKit.h>
#import "ShareView.h"
#import "CommentView.h"
#import "CommentTextView.h"
#import "CommentViewController.h"
#import "LoginViewController.h"
#import "VoteDetailModel.h"
#import "NewsDetailModel.h"
#import "TagNewsListViewController.h"
@interface NewsDetailViewController ()<UITextViewDelegate,WKNavigationDelegate>

@property (nonatomic, strong) NSNumber * newsid;
@property (nonatomic, strong) ShareView * shareView;
@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) NSString * urlStr;
@property (nonatomic, strong) UIProgressView * progressView;
@property (nonatomic, strong) UIButton * commentCount;
@property (nonatomic, strong) CommentView * commentView;
@property (nonatomic, assign) BOOL commentSuccess;
@property (nonatomic, assign) int comentNumber;
@property (nonatomic, strong) NewsDetailModel * model;
@property (nonatomic, strong) VoteDetailModel * vote;
@property (nonatomic, strong) UIView * blackView;

@end

@implementation NewsDetailViewController
- (instancetype)initWithNewsid:(NSNumber *)newsid{
    self = [super init];
    if (self) {
        self.newsid = newsid;
        self.urlStr = [NSString stringWithFormat:@"http://%@/news/%@?app=1",Base_WebHost,newsid];
        if ([UserManager manager].isLogin) {
            self.urlStr = [NSString stringWithFormat:@"%@&uid=%@&callback_verify=%@",self.urlStr,[UserManager manager].userid,[UserManager manager].token];
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"新闻"];
    [self drawBackButton];
    [self creatCommentTextf];
    [self creatUI];
    [self getNewsDetail];
    [self drawShareButton];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self registerNotification];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self removeNotification];
}
- (void)creatUI{
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64 - Anno750(80))];
    [self.view addSubview:self.webView];
    self.webView.navigationDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(30))];
    self.progressView.trackTintColor = BYColor_Line;
    self.progressView.progressTintColor = BYColor_Main;
    [self.view addSubview:self.progressView];
    
    self.shareView = [[ShareView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT)];
    [self.view addSubview:self.shareView];
    [self.view bringSubviewToFront:self.shareView];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == self.webView) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        }else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)drawShareButton{
    UIView * leftView = [BYFactory creatViewWithColor:[UIColor clearColor]];
    leftView.frame = CGRectMake(0, 0, Anno750(250), 44);
    UIButton * shareButton = [BYFactory creatButtonWithNormalImage:@"share" selectImage:nil];
    [shareButton addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(Anno750(60)));
        make.width.equalTo(@(Anno750(50)));
        make.right.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    self.commentCount = [BYFactory creatButtonWithTitle:@"" backGroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textSize:font750(24)];
    [self.commentCount setImage:[UIImage imageNamed:@"statusbar_talk"] forState:UIControlStateNormal];
    [self.commentCount addTarget:self action:@selector(pushTocommentViewController) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:self.commentCount];
    [self.commentCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(shareButton.mas_left).offset(-Anno750(20));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(60)));
    }];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.rightBarButtonItem = leftItem;
}
- (void)pushTocommentViewController{
    CommentViewController * vc = [[CommentViewController alloc]init];
    vc.newsID = self.newsid;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)doShare{
    [self.shareView show];
}


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

- (void)commitComment{
    
    if ([UserManager manager].isLogin) {
        [self.commentView startLoading:YES];
        [self addCommentRequest];
    }else{
        [self.commentView.textView resignFirstResponder];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"登陆提示" message:@"你好，请登陆后发表你的回复，我们期待你参与讨论！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * login = [UIAlertAction actionWithTitle:@"登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            LoginViewController * vc = [LoginViewController new];
            vc.isPush = YES;
            vc.backType = SelectorBackTypeDismiss;
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }];
        UIAlertAction * cannce = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:login];
        [alert addAction:cannce];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
}
- (void)addCommentRequest{
    
    NSDictionary * params = @{
                              @"nid":self.newsid,
                              @"uid":[UserManager manager].userid,
                              @"callback_verify":[UserManager manager].token,
                              @"content":self.commentView.textView.text
                              };
    
    [[NetWorkManger manager]sendRequest:Page_AddComment route:Route_News withParams:params complete:^(NSDictionary *result) {
        [self.commentView startLoading:NO];
        self.commentSuccess = YES;
        [self.commentView.textView endEditing:YES];
        self.comentNumber  += 1;
        [self.commentCount setTitle:[NSString stringWithFormat:@"%d",self.comentNumber] forState:UIControlStateNormal];
    } error:^(BYError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}
- (void)getVoteDeatilWithvoteid:(NSString *)voteid{
    NSDictionary * params = @{
                              @"id":voteid,
                              @"uid":[UserManager manager].userid
                              };
    [[NetWorkManger manager] sendRequest:Page_getVote route:Route_Else withParams:params complete:^(NSDictionary *result) {
        self.vote = [[VoteDetailModel alloc]initWithDictionary:result[@"data"]];
        [self.shareView updateShareInfoWithTitle:self.vote.share_title desc:self.vote.share_title contentUlr:self.vote.share_link imageUrl:self.vote.pic];
        [self.shareView show];
    } error:^(BYError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}

- (void)getNewsDetail{
    NSDictionary * params = @{
                              @"id":self.newsid,
                              };
    
    [[NetWorkManger manager] sendRequest:Page_NewsDetail route:Route_News withParams:params complete:^(NSDictionary *result) {
        self.model = [[NewsDetailModel alloc]initWithDictionary:result[@"data"]];
        self.comentNumber = [self.model.comment_count intValue];
        [self.commentCount setTitle:[NSString stringWithFormat:@"%d",self.comentNumber] forState:UIControlStateNormal];
        [self.shareView updateShareInfoWithTitle:self.model.sub_title desc:self.model.share_title contentUlr:self.model.share_link imageUrl:self.model.share_pic];
    } error:^(BYError *byerror) {
        
    }];

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
- (void)registerNotification{
    [self creatBlackView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)removeNotification{
    [self.blackView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyBoardWillShow:(NSNotification *)noti{
    NSDictionary *info = [noti userInfo];
    CGFloat time = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:time animations:^{
        self.commentView.frame = CGRectMake(0, UI_HEGIHT -Anno750(250)-kbSize.height, UI_WIDTH, Anno750(250));
    }];
}
- (void)keyboardWillHidden:(NSNotification *)noti{
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


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"star......");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"load......");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"over......");
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"faild......");
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%@",navigation);
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"%@",navigationResponse.response);
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 在发送请求之前，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString * urlStr = [NSString stringWithFormat:@"%@",navigationAction.request.URL];
    if ([urlStr containsString:@"fcbayern:"]) {
        if ([urlStr containsString:@"vote_share"]) {
            NSArray * arr = [urlStr componentsSeparatedByString:@"&"];
            for (NSString * str in arr) {
                if ([str containsString:@"vid"]) {
                    NSArray * params = [str componentsSeparatedByString:@"="];
                    [self getVoteDeatilWithvoteid:params.lastObject];
                }
            }
        }else if([urlStr containsString:@"login"]){
            LoginViewController * vc = [LoginViewController new];
            vc.index = 2;
            vc.isPush = YES;
            vc.backType = SelectorBackTypeDismiss;
            UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nvc animated:YES completion:nil];
        }else if([urlStr containsString:@"news_more_commnet"]){
            [self pushTocommentViewController];
        }else if([urlStr containsString:@"tag_news_list"]){
            NSString * string = [urlStr stringByReplacingOccurrencesOfString:@"}" withString:@""];
            NSString * string1 = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSArray * arr = [string1 componentsSeparatedByString:@"&"];
            for (NSString * str in arr) {
                if ([str containsString:@"tag_id"]) {
                    NSArray * params = [str componentsSeparatedByString:@"="];
                    TagNewsListViewController * vc = [[TagNewsListViewController alloc]init];
                    NSNumber * tagStr = params.lastObject;
                    vc.tagid = tagStr;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
