//
//  LeftUserHeadCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface LeftUserHeadCell : UITableViewCell

@property (nonatomic, strong) UIImageView * headIcon;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIView * redView;
@property (nonatomic, strong) UIView * grayView;

- (void)updateUserInfo;

@end
