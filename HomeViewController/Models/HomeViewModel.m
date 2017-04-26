//
//  HomeViewModel.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

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
