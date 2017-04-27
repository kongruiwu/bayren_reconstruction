//
//  UserModel.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

/**用户id*/
@property (nonatomic, retain) NSNumber * uid;
/**用户姓名*/
@property (nonatomic, strong) NSString * username;
/**用户注册时间*/
@property (nonatomic, strong) NSString * reg_date;
/**用户性别*/
@property (nonatomic, strong) NSString * gender;
/**用户邮箱*/
@property (nonatomic, strong) NSString * email;
/**用户验证信息 类似token*/
@property (nonatomic, strong) NSString * callback_verify;
/**用户生日*/
@property (nonatomic, strong) NSString * birth;
/**用户头像*/
@property (nonatomic, strong) NSString * avatar;
/**用户地址*/
@property (nonatomic, strong) NSString * area;
@end
