//
//  BaseViewController.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "RESideMenu.h"
@interface BaseViewController : UIViewController
@property (nonatomic) SelectorBackType backType;

- (void)drawMainTabItem;
- (void)setNavigationTitle:(NSString *)title;
- (void)doBack;
@end
