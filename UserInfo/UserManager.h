//
//  UserManager.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserModel.h"
#import "NetWorkManger.h"
@interface UserManager : NSObject

@property (nonatomic, strong) UserModel * user;
@property (nonatomic, strong) NSNumber * userid;
/**是否登陆*/
@property (nonatomic, assign) BOOL isLogin;
//缓存使用
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * userIcon;
@property (nonatomic, strong) NSString * token;
//是否超过提示日期
@property (nonatomic, assign) BOOL isTimeOut;
//用户是否完善了信息
@property (nonatomic, assign) BOOL isComplete;

+ (instancetype)manager;

- (void)getUserInfo;
@end
