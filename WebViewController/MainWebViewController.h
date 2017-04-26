//
//  MainWebViewController.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/21.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseViewController.h"

@interface MainWebViewController : BaseViewController

@property (nonatomic, assign) BOOL needBack;

- (instancetype)initWithTitle:(NSString *)title url:(NSString *)urlStr;

@end
