//
//  StandingTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "StandingModel.h"
@interface StandingTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UIImageView * teamIcon;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * winLabel;
@property (nonatomic, strong) UILabel * drawLabel;
@property (nonatomic, strong) UILabel * lostLabel;
@property (nonatomic, strong) UILabel * hitLabel;
@property (nonatomic, strong) UILabel * scoreLabel;
@property (nonatomic, strong) UIView * line;
- (void)updateWithModel:(StandingModel *)model;
@end
