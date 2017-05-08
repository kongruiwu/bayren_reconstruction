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
//#define Base_ImgHost    @"https://bayern-cn.hupucdn.com"
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
//赛程列表
#define Page_Schedules  @"schedules"
//抽屉右边赛程列表
#define Page_Right_Sched    @"lastSchedules"
//积分相关
#define Page_Rank       @"team_rank"
//抽屉右边积分列表
#define Page_Right_Rank @"right_team_rank"
//视频相关
#define Route_Video     @"video"
//视屏列表
#define Page_VideoList  @"get_list"
//视屏焦点图
#define Page_VideoFocus @"get_focus_2016"
//新闻相关
#define Route_News      @"news"
//评论列表
#define Page_commentList    @"comment_list"
//点赞
#define Page_AtCommet   @"comment_good"
//获取新闻详情
#define Page_NewsDetail @"get_detail"
//发表评论
#define Page_AddComment @"add_comment"
//新闻焦点图
#define Page_NewsFocus  @"get_focus_2016"
//新闻列表
#define Page_NewsList   @"get_list_2016"
//标签新闻列表
#define Page_TagList    @"get_tag_list"
//球队
#define Route_Team      @"team"
//球队列表
#define Page_TeamList   @"get_list"
//队员详情
#define Page_detail     @"get_detail"
//图集
#define Route_Photo     @"album"
//图集列表
#define Page_PhotoList  @"get_list"
//图片详情
#define Page_PhotoDetail    @"get_detail"
//用户
#define Route_User      @"user"
//登陆
#define Page_login      @"login"
//找回密码
#define Page_GetRecode  @"getRecode"
//注册
#define Page_register   @"register"
//获取用户信息
#define Page_userInfo   @"profile"
//修改用户信息统一接口
#define Page_ChangeUserInfo @"profile_update"
//登出
#define Page_LogOut     @"logout"
//路由 其他
#define Route_Else      @"other"
//获取投票的分享信息
#define Page_getVote    @"get_vote"
//搜索
#define Page_Search     @"search"
#endif /* API_h */
