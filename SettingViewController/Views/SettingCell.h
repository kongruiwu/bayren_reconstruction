//
//  SettingCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface SettingCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * descLabe;;
@property (nonatomic, strong) UIImageView * nextIcon;
@property (nonatomic, strong) UIView * lineView;

- (void)updateWithTitle:(NSString *)title desc:(NSString *)desc rec:(BOOL)rec;
@end
