//
//  RightStandingCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "RightStandModel.h"
@interface RightStandingCell : UITableViewCell

@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * resultLabel;
@property (nonatomic, strong) UILabel * ballLabel;
@property (nonatomic, strong) UILabel * scoreLabel;
- (void)updateWithTeamRankModel:(RightStandModel *)model;
@end
