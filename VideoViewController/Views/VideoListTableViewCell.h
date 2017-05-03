//
//  VideoListTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "VideoListModel.h"
#import "SearchResultModel.h"
@interface VideoListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * videoIcon;
@property (nonatomic, strong) UILabel * tagLabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIImageView * playIcon;
@property (nonatomic, strong) UIView * line;
- (void)updateWithModel:(VideoListModel *)model;
- (void)updateWithSearchModel:(SearchResultModel *)model;
@end
