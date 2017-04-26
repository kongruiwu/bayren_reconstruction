//
//  FixtureTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "FixtureModel.h"
@protocol FixtureCellDelegate<NSObject>

- (void)checkNewsDetail:(NSNumber *)newsid;
- (void)checkPicsDetail:(NSNumber *)picid;

@end


@interface FixtureTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * dayTimeLable;//欧冠 2015-3-11
@property (nonatomic, strong) UIImageView * homeIcon;
@property (nonatomic, strong) UIImageView * awayIcon;
@property (nonatomic, strong) UILabel * homeLabel;
@property (nonatomic, strong) UILabel * awayLabel;
@property (nonatomic, strong) UILabel * scoreLabel;
@property (nonatomic, strong) UILabel * halfScoreLabel;
@property (nonatomic, strong) UIButton * detailButton;//查看详情
@property (nonatomic, strong) UILabel * infoLabel;//未开赛  显示 具体地址
@property (nonatomic, strong) UIButton * newsButton;
@property (nonatomic, strong) UIButton * picButton;
@property (nonatomic, strong) UIView * bottomLine;
@property (nonatomic, assign) id <FixtureCellDelegate> delegtae;
@property (nonatomic, strong) FixtureModel * model;
- (void)cellUpdateWithModel:(FixtureModel *)model;
@end
