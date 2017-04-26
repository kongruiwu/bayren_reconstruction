//
//  FixtureModel.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface FixtureModel : BaseModel

@property (nonatomic, strong) NSString * game_id;
//联赛id
@property (nonatomic, strong) NSString * league_id;

@property (nonatomic, strong) NSString * match_day;
//比赛时间
@property (nonatomic, strong) NSString * match_date_cn;
//主场球队id
@property (nonatomic, strong) NSString * home_id;
//主场球队名称
@property (nonatomic, strong) NSString * home_name;
//主场球队分数
@property (nonatomic, strong) NSString * home_score;
//客场球队id
@property (nonatomic, strong) NSString * away_id;
//客场球队名称
@property (nonatomic, strong) NSString * away_name;
//客场得分
@property (nonatomic, strong) NSString * away_score;
//半场得分
@property (nonatomic, strong) NSString * half_score;
//比赛状态
@property (nonatomic, strong) NSString * game_status;
//新闻链接
@property (nonatomic, strong) NSNumber * news_link;
//图集链接
@property (nonatomic, strong) NSNumber * album_link;
//转播信息
@property (nonatomic, strong) NSString * relay_info;
//主场球队图标
@property (nonatomic, strong) NSString * home_logo;
//客场球队图标
@property (nonatomic, strong) NSString * away_logo;
//比赛标题
@property (nonatomic, strong) NSString * league_title;
//在首页是否为默认显示的比赛
@property (nonatomic, assign) BOOL  show_default;

@end
