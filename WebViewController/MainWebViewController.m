//
//  MainWebViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/21.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "MainWebViewController.h"
#import <WebKit/WebKit.h>


@interface MainWebViewController ()

@property (nonatomic, strong) WKWebView * webview;
@property (nonatomic, strong) NSString * titleStr;
@property (nonatomic, strong) NSString * urlStr;
@property (nonatomic, strong) UIProgressView * progressView;

@end

@implementation MainWebViewController

- (instancetype)initWithTitle:(NSString *)title url:(NSString *)urlStr{
    self = [super init];
    if (self) {
        self.titleStr = title;
        self.urlStr = urlStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:self.titleStr];
    if (self.needBack) {
        [self drawBackButton];
    }else{
        [self drawMainTabItem];
    }
    
    [self creatUI];
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


@end
