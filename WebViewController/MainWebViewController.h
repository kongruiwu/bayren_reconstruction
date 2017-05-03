//
//  MainWebViewController.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/21.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, FromType){
    FromTypeWeb = 0,
    FromTypeVideo = 1,
};

@interface MainWebViewController : BaseViewController


- (instancetype)initWithTitle:(NSString *)title url:(NSString *)urlStr andFromType:(FromType)type;
- (void)updateShareSettingWithTitle:(NSString *)title content:(NSString *)content image:(NSString *)imageName;
@end
