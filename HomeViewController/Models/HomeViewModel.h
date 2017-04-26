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

@property (nonatomic, strong) NSArray<VideoFocusModel *> * headFocus;
@property (nonatomic, strong) NSArray * HeadFocusTitles;
@property (nonatomic, strong) NSArray * HeadFocusImages;

@property (nonatomic, strong) HomeAdModel * adModel;

@property (nonatomic, strong) NSArray<HomeVideoFocusModel *> * videoFocus;
@property (nonatomic, strong) NSArray * VideoFocusTitles;
@property (nonatomic, strong) NSArray * VideoFocusImages;

@property (nonatomic, strong) NSArray<NewsListModel *> * news;

@property (nonatomic, strong) NSArray<FixtureModel *> * fixtures;
//首页要展示赛程的位置
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSArray<HomeTeamerModel *> * teamers;
@end
