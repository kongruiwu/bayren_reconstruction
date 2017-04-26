//
//  HomeTeamerModel.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface HomeTeamerModel : BaseModel
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * pic;
@property (nonatomic, strong) NSString * player_id;
@property (nonatomic, strong) NSString * number;
//球员 0  教练 1
@property (nonatomic, assign) BOOL is_coach;
@end
