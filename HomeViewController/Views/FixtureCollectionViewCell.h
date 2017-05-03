//
//  FixtureCollectionViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/28.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FixtureModel.h"
#import "ConfigHeader.h"
@interface FixtureCollectionViewCell : UICollectionViewCell
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

- (void)updateWithHomeGameModel:(FixtureModel *)model;
@end
