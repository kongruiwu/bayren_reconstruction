//
//  BaseViewController.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"

#import <MJRefresh.h>
#import "NetNullView.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
@interface BaseViewController : UIViewController
@property (nonatomic) SelectorBackType backType;
@property (nonatomic, strong) MJRefreshNormalHeader * refreshHeader;
@property (nonatomic, strong) MJRefreshAutoNormalFooter * refreshFooter;
@property (nonatomic, strong) NetNullView * nullview;
//设置界面是返回 还是 显示左右两边框
@property (nonatomic, assign) BOOL isPush;

- (void)drawMainTabItem;
- (void)drawBackButton;
- (void)setNavigationTitle:(NSString *)title;
- (void)doBack;
- (void)RefreshSetting;
- (void)creatNullView;
- (void)nullViewClick;
- (void)creatBackGroundImage;
- (void)nullviewShow;
- (void)nullViewHidden;
- (void)setNavAlpha;
- (void)setNavUnAlpha;
- (void)drawMainSearchTabItem;
@end
