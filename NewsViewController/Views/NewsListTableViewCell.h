//
//  NewsListTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "NewsListModel.h"
#import "SearchResultModel.h"
@interface NewsListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIView * line;
- (void)updateWithModel:(NewsListModel *)model;
- (void)updateWithSerachModel:(SearchResultModel *)model;
@end
