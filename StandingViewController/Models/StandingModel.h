//
//  StandingModel.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface StandingModel : BaseModel
@property(nonatomic,retain)NSNumber * avg_goal_hit;
@property(nonatomic,retain)NSNumber * avg_goal_lost;
@property(nonatomic,retain)NSNumber * avg_goal_win;
@property(nonatomic,retain)NSNumber * avg_score;
@property(nonatomic,retain)NSNumber * difference;
//平场数
@property(nonatomic,retain)NSNumber * draw;
//进球
@property(nonatomic,retain)NSNumber * hits;
@property(nonatomic,copy)NSString * known_name_zh;
//输球场次
@property(nonatomic,retain)NSNumber * lost;
//失球
@property(nonatomic,retain)NSNumber * miss;
@property(nonatomic,copy)NSString * name_zh;
@property(nonatomic,retain)NSNumber * played;
@property(nonatomic,retain)NSNumber * promotion_id;
@property(nonatomic,copy)NSString * promotion_name;
//排名
@property(nonatomic,retain)NSNumber * rank_index;
//球队积分
@property(nonatomic,retain)NSNumber * score;
@property(nonatomic,retain)NSNumber * team_id;
//球队logo
@property(nonatomic,copy)NSString * team_logo;
//赢的场数
@property(nonatomic,retain)NSNumber * win;
//是否时拜仁球队
@property(nonatomic,assign) BOOL isBer;
@end
