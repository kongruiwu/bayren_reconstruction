//
//  BaseViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BYColor_Ground;
}
//用于首页，左右切换页面滑动
- (void)drawMainTabItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"item"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftViewController)];
    self.navigationItem.leftBarButtonItem = item;
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"game"] style:UIBarButtonItemStylePlain target:self action:@selector(presentRightViewController)];
    self.navigationItem.rightBarButtonItem = item2;
}
- (void)presentLeftViewController{
    [self.sideMenuViewController presentLeftMenuViewController];
}
- (void)presentRightViewController{
    [self.sideMenuViewController presentRightMenuViewController];
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
@end
