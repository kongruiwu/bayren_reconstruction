//
//  UserManager.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
+ (instancetype)manager{
    static UserManager * manger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[UserManager alloc]init];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]) {
            manger.userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
            manger.userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
            manger.userIcon = [[NSUserDefaults standardUserDefaults] objectForKey:@"userImage"];
            manger.token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
            manger.isLogin = YES;
        }else{
            manger.userName = @"登 录 / 注 册";
            manger.userIcon = @"leftnav_avatar";
            manger.token = @"";
            manger.userid = @0;
            manger.isLogin = NO;
        }
    });
    return manger;
}
- (void)setUser:(UserModel *)user{
    if (user != nil) {
        _user = user;
        _userid = user.uid;
        _token = user.callback_verify;
        self.isLogin = YES;
    }else{
        _user = nil;
        _userid = @0;
        _token = @"";
        self.isLogin = NO;
    }
    [[NSUserDefaults standardUserDefaults] setObject:_token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] setObject:_userid forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (void)getUserInfo{
    if ([self.userid intValue] != 0) {
        NSDictionary * params = @{@"uid":self.userid};
        [[NetWorkManger manager] sendRequest:Page_userInfo route:Route_User withParams:params complete:^(NSDictionary *result) {
            NSDictionary * dic = result[@"data"];
            self.user = [[UserModel alloc]initWithDictionary:dic];
        } error:^(BYError *byerror) {
            
        }];
    }
}

@end
