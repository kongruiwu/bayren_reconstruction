//
//  BaseViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BYColor_Ground;
}

- (void)creatBackGroundImage{
    UIImageView * imgView = [BYFactory creatImageViewWithImage:@"groundImage"];
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

//用于首页，左右切换页面滑动
- (void)drawMainTabItem {
    if (self.isPush) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_2"] style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }else{
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"item"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftViewController)];
        self.navigationItem.leftBarButtonItem = item;
        
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"game"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(presentRightViewController)];
        self.navigationItem.rightBarButtonItem = item2;
    }
}
- (void)drawMainSearchTabItem{
    if (self.isPush) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_2"] style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }else{
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"item"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftViewController)];
        self.navigationItem.leftBarButtonItem = item;
        
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"game"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(presentRightViewController)];
        UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchBtnClick)];
        self.navigationItem.rightBarButtonItems = @[item2,item3];
    }
}
- (void)searchBtnClick{
    [self.navigationController pushViewController:[SearchViewController new] animated:YES];
}
- (void)drawBackButton{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_2"] style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)creatNullView{
    self.nullview = [[NetNullView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT)];
    self.nullview.hidden = YES;
    [self.nullview.reloadButton addTarget:self action:@selector(nullViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nullview];
}
- (void)nullviewShow{
    self.nullview.hidden = NO;
    [self.view bringSubviewToFront:self.nullview];
}
- (void)nullViewHidden{
    self.nullview.hidden = YES;
}
- (void)presentLeftViewController{
    [self.sidePanelController showLeftPanelAnimated:YES];
}
- (void)presentRightViewController{
    [self.sidePanelController showRightPanelAnimated:YES];
}
- (void)nullViewClick{
    
}

- (void)setNavigationTitle:(NSString *)title{
    
    UIView * titleView = [BYFactory creatViewWithColor:[UIColor clearColor]];
    titleView.frame = CGRectMake(0, 0, 100, 40);
    
    UIImageView * icon = [BYFactory creatImageViewWithImage:@"logo"];
    UILabel * titleLabel = [BYFactory creatLabelWithText:title fontValue:font750(36)
                                               textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    [titleView addSubview:icon];
    [titleView addSubview:titleLabel];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@0);
        make.height.with.equalTo(@(Anno750(48)));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(Anno750(20));
        make.centerY.equalTo(@0);
    }];
    
    self.navigationItem.titleView = titleView;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = BYColor_Main;
}
- (void)doBack{
    switch (self.backType) {
        case SelectorBackTypeDismiss:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case SelectorBackTypePopBack:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case SelectorBackTypePoptoRoot:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}
- (void)RefreshSetting{
    [self.refreshHeader setTitle:@"继续下拉" forState:MJRefreshStateIdle];
    [self.refreshHeader setTitle:@"松开就刷新" forState:MJRefreshStatePulling];
    [self.refreshHeader setTitle:@"刷新中 ..." forState:MJRefreshStateRefreshing];
    self.refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [self.refreshFooter setTitle:@"" forState:MJRefreshStateIdle];
    [self.refreshFooter setTitle:@"就是要加载" forState:MJRefreshStateWillRefresh];
    [self.refreshFooter setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    [self.refreshFooter setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
}

- (void)setNavAlpha{
    self.navigationController.navigationBar.translucent = YES;
    UIView * clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, 20)];
    [self.view addSubview:clearView];
    //    导航栏变为透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    //    让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
}
- (void)setNavUnAlpha{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = nil;
}
@end
