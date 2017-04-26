//
//  TeamListTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "ListTeamerModel.h"
@interface TeamListTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * CHNameLabel;
@property (nonatomic, strong) UILabel * ENNameLabel;
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UILabel * cateLabel;
@property (nonatomic, strong) UILabel * teamNum;
@property (nonatomic, strong) UILabel * birthLabel;
-(void)updateWithModel:(ListTeamerModel *)model;
@end
