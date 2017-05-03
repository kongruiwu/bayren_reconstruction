//
//  HomeViewModel.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"
#import "VideoFocusModel.h"
#import "HomeVideoFocusModel.h"
#import "HomeAdModel.h"
#import "FixtureModel.h"
#import "HomeTeamerModel.h"
#import "ConfigHeader.h"
#import "NewsListModel.h"
@interface HomeViewModel : BaseModel
/**头部轮播图数据*/
@property (nonatomic, strong) NSArray<VideoFocusModel *> * headFocus;
/**头部轮播图标题数据*/
@property (nonatomic, strong) NSArray * HeadFocusTitles;
/**头部轮播图图片数据*/
@property (nonatomic, strong) NSArray * HeadFocusImages;
/**广告数据*/
@property (nonatomic, strong) HomeAdModel * adModel;
/**视频轮播图数据*/
@property (nonatomic, strong) NSArray<HomeVideoFocusModel *> * videoFocus;
@property (nonatomic, strong) NSArray * VideoFocusTitles;
@property (nonatomic, strong) NSArray * VideoFocusImages;
/**新闻数据*/
@property (nonatomic, strong) NSArray<NewsListModel *> * news;
/**赛程数据*/
@property (nonatomic, strong) NSArray<FixtureModel *> * fixtures;
//首页要展示赛程的位置
@property (nonatomic, assign) NSInteger index;
/**队员数据*/
@property (nonatomic, strong) NSArray<HomeTeamerModel *> * teamers;
@end
