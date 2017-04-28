//
//  HomeViewModel.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"homeFocus"]) {
            NSData * focusData = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeFocus"];
            NSArray * focus = [NSJSONSerialization JSONObjectWithData:focusData
                                                            options:NSJSONReadingAllowFragments
                                                              error:nil];
            NSMutableArray * muarr = [NSMutableArray new];
            for (int i = 0; i<focus.count; i++) {
                NSDictionary * dic = focus[i];
                VideoFocusModel * model = [[VideoFocusModel alloc]initWithDictionary:dic];
                [muarr addObject:model];
            }
            self.headFocus = [NSArray arrayWithArray:muarr];
        }
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"homeNews"]) {
            NSData * newsData = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeNews"];
            NSArray * news = [NSJSONSerialization JSONObjectWithData:newsData
                                                              options:NSJSONReadingAllowFragments
                                                                error:nil];
            NSMutableArray * muarr = [NSMutableArray new];
            for (int i = 0; i<news.count; i++) {
                NSDictionary * dic = news[i];
                NewsListModel * model = [[NewsListModel alloc]initWithDictionary:dic];
                [muarr addObject:model];
            }
            self.news = [NSArray arrayWithArray:muarr];
        }
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"homeAd"]) {
            NSData * adData = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeAd"];
            NSArray * ads = [NSJSONSerialization JSONObjectWithData:adData
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
            if (ads.count>0) {
                self.adModel = [[HomeAdModel alloc]initWithDictionary:ads[0]];
            }
        }
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"homeVideos"]) {
            NSData * videoData = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeVideos"];
            NSArray * videos = [NSJSONSerialization JSONObjectWithData:videoData
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
            NSMutableArray * muarr = [NSMutableArray new];
            for (int i = 0; i<videos.count; i++) {
                NSDictionary * dic = videos[i];
                HomeVideoFocusModel * model = [[HomeVideoFocusModel alloc]initWithDictionary:dic];
                [muarr addObject:model];
            }
            self.videoFocus = [NSArray arrayWithArray:muarr];
        }
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"homeFixture"]) {
            NSData * fixtureData = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeFixture"];
            NSArray * fixtures = [NSJSONSerialization JSONObjectWithData:fixtureData
                                                               options:NSJSONReadingAllowFragments
                                                                 error:nil];
            NSMutableArray * muarr = [NSMutableArray new];
            for (int i = 0; i<fixtures.count; i++) {
                NSDictionary * dic = fixtures[i];
                FixtureModel * model = [[FixtureModel alloc]initWithDictionary:dic];
                [muarr addObject:model];
            }
            self.fixtures = [NSArray arrayWithArray:muarr];
        }
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"homeTeamers"]) {
            NSData * teamerData = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeTeamers"];
            NSArray * teamers = [NSJSONSerialization JSONObjectWithData:teamerData
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:nil];
            NSMutableArray * muarr = [NSMutableArray new];
            for (int i = 0; i<teamers.count; i++) {
                NSDictionary * dic = teamers[i];
                HomeTeamerModel * model = [[HomeTeamerModel alloc]initWithDictionary:dic];
                [muarr addObject:model];
            }
            self.teamers = [NSArray arrayWithArray:muarr];
        }

    }
    return self;
}

- (void)setFixtures:(NSArray<FixtureModel *> *)fixtures{
    _fixtures = fixtures;
    for (int i = 0; i<fixtures.count; i++) {
        if (fixtures[i].show_default) {
            self.index = i;
        }
    }
}
- (void)setHeadFocus:(NSArray<VideoFocusModel *> *)headFocus{
    _headFocus = headFocus;
    NSMutableArray * titles = [NSMutableArray new];
    NSMutableArray * images = [NSMutableArray new];
    for (int i = 0; i<headFocus.count; i++) {
        VideoFocusModel * model = headFocus[i];
        [titles addObject:model.title];
        NSString * imgstr = [NSString stringWithFormat:@"%@%@",Base_ImgHost,model.pic];
        [images addObject:imgstr];
    }
    self.HeadFocusTitles = [NSMutableArray arrayWithArray:titles];
    self.HeadFocusImages = [NSMutableArray arrayWithArray:images];
}
- (void)setVideoFocus:(NSArray<HomeVideoFocusModel *> *)videoFocus{
    _videoFocus = videoFocus;
    NSMutableArray * titles = [NSMutableArray new];
    NSMutableArray * images = [NSMutableArray new];
    for (int i = 0; i<videoFocus.count; i++) {
        HomeVideoFocusModel * model = videoFocus[i];
        [titles addObject:model.title];
        NSString * imgstr = [NSString stringWithFormat:@"%@%@",Base_ImgHost,model.pic];
        [images addObject:imgstr];
    }
    self.VideoFocusTitles = [NSMutableArray arrayWithArray:titles];
    self.VideoFocusImages = [NSMutableArray arrayWithArray:images];
}

@end
