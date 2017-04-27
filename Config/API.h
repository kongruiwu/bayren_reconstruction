//
//  API.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#ifndef API_h
#define API_h

#define Base_ApiHost    @"http://api.fcbayern.cn"
#define Base_ImgHost    @"http://7xj11p.com1.z0.glb.clouddn.com/"
#define Base_WebHost    @"www.fcbayern.cn"
#define BER_APP_KEY     @"54NexY5d69M24bg"
//首页
#define Route_Home      @"home_data"
//首页头部焦点
#define Page_HomeFocus  @"get_focus_2016"
//首页广告
#define Page_HomeAd     @"get_mid_adv"
//首页视屏焦点
#define Page_HomeVideo  @"get_home_video"
//首页赛程
#define Page_HomeFixture    @"get_home_schedule_board"
//首页球员
#define Page_HomeTeamer @"get_home_player"
//首页新闻
#define Page_HomeNews   @"get_news_list"

//赛程相关
#define Route_Fixture   @"match"
#define Page_Schedules  @"schedules"
#define Page_Right_Sched    @"lastSchedules"
//积分相关
#define Page_Rank       @"team_rank"
#define Page_Right_Rank @"right_team_rank"
//视频相关
#define Route_Video     @"video"
#define Page_VideoList  @"get_list"
#define Page_VideoFocus @"get_focus_2016"

//新闻相关
#define Route_News      @"news"
#define Page_NewsFocus  @"get_focus_2016"
#define Page_NewsList   @"get_list_2016"
//球队
#define Route_Team      @"team"
#define Page_TeamList   @"get_list"
#define Page_detail     @"get_detail"
//图集
#define Route_Photo     @"album"
#define Page_PhotoList  @"get_list"
#define Page_PhotoDetail    @"get_detail"


#endif /* API_h */
