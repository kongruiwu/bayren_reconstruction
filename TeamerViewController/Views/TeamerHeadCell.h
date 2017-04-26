//
//  TeamerHeadCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "TeamerModel.h"
@interface TeamerHeadCell : UITableViewCell
@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UILabel * cateLabel;
@property (nonatomic, strong) UILabel * EnNameLabel;
@property (nonatomic, strong) UILabel * ZnNameLabel;
@property (nonatomic, strong) UIImageView * teamerImg;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIView * lineView;
- (void)updateWithModel:(TeamerModel *)model;
@end
