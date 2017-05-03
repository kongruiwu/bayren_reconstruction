//
//  PhotoListTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "PhotoListModel.h"
#import "SearchResultModel.h"
@interface PhotoListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * backImg;
@property (nonatomic, strong) UIView * grayView;
@property (nonatomic, strong) UILabel * titlelabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIImageView * countImg;
@property (nonatomic, strong) UILabel * countLabel;
- (void)updateWithModel:(PhotoListModel *)model;
- (void)updateWithSearchModel:(SearchResultModel *)model;
@end
