//
//  MainWebViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/21.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "MainWebViewController.h"
#import <WebKit/WebKit.h>
#import "ShareView.h"

@interface MainWebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView * webview;
@property (nonatomic, strong) NSString * titleStr;
@property (nonatomic, strong) NSString * urlStr;
@property (nonatomic, strong) UIProgressView * progressView;
@property (nonatomic, assign) FromType fromType;
@property (nonatomic, strong) ShareView * shareView;


//分享设置
@property (nonatomic, strong) NSString * shareTitle;
@property (nonatomic, strong) NSString * shareContent;
@property (nonatomic, strong) NSString * shareImage;
@end

@implementation MainWebViewController

- (instancetype)initWithTitle:(NSString *)title url:(NSString *)urlStr andFromType:(FromType)type {
    self = [super init];
    if (self) {
        self.titleStr = title;
        self.urlStr = urlStr;
        if ([UserManager manager].isLogin) {
            self.urlStr = [NSString stringWithFormat:@"%@&uid=%@&callback_verify=%@",self.urlStr,[UserManager manager].userid,[UserManager manager].token];
        }
        self.fromType = type;
    }
    return self;
}
- (void)updateShareSettingWithTitle:(NSString *)title content:(NSString *)content image:(NSString *)imageName{
    self.shareTitle = title;
    self.shareContent = content;
    self.shareImage = imageName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:self.titleStr];

    [self drawMainTabItem];
    
    [self creatUI];
    
    if (self.fromType == FromTypeVideo) {
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(doShare)];
        self.navigationItem.rightBarButtonItem = item2;
        self.shareView = [[ShareView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT)];
        [self.view addSubview:self.shareView];
        [self.view bringSubviewToFront:self.shareView];
        
        [self.shareView updateShareInfoWithTitle:self.shareTitle desc:self.shareContent contentUlr:self.urlStr imageUrl:self.shareImage];
    }
}
- (void)doShare{
    [self.shareView show];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.webview removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (void)creatUI{
    self.webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 49)];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    self.webview.navigationDelegate = self;
    [self.view addSubview:self.webview];
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(30))];
    self.progressView.trackTintColor = BYColor_Line;
    self.progressView.progressTintColor = BYColor_Main;
    [self.view addSubview:self.progressView];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == self.webview) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webview.estimatedProgress animated:YES];
            if(self.webview.estimatedProgress >= 1.0f) {
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
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
