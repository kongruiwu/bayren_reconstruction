//
//  HomeNewsTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "NewsListModel.h"
@interface HomeNewsTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView * groundView;
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UILabel * timeLabel;

- (void)updateWithModel:(NewsListModel *)model;
@end
