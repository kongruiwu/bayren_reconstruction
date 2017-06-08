//
//  LeftViewModel.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LeftViewModel.h"

@implementation LeftViewModel
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setDefaultData];
    }
    return self;
}
- (void)setDefaultData{
    self.icons = @[@"left_home",@"left_news",@"left_photo",
                   @"left_video",@"left_playList",@"left_score",
                   @"left_team",@"left_club",@"left_shop",
                   @"left_set"];
    self.ZNtitles = @[@"首   页",@"新   闻",@"图   片",
                    @"视   频",@"赛   程",@"积   分",
                    @"球   队",@"俱乐部",@"商   店",
                    @"设   置"];
    self.ENtitles = @[@"Home",@"News",@"Photos",
                      @"Videos",@"Fixtures",@"Standings",
                      @"Team",@"Club",@"Fan Shop",
                      @"Setting"];
}
@end
