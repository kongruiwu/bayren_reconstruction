//
//  JpushHander.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/8.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JpushModel.h"
#import "NewsDetailViewController.h"
#import "PhotoDetailViewController.h"
#import "MainWebViewController.h"
@interface JpushHander : NSObject

+ (instancetype)defaultHander;
- (void)handerPushUserInfo:(NSDictionary *)dic withBack:(BOOL)isBack vc:(UIViewController *)vc;
@end
