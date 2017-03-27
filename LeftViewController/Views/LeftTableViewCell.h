//
//  LeftTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface LeftTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * ZNLabel;
@property (nonatomic, strong) UILabel * ENlabel;
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UIView * redView;
@property (nonatomic, strong) UIView * grayView;
- (void)updateWithZnTitle:(NSString *)ZNtitle ENtitle:(NSString *)ENtitle iconName:(NSString *)iconName;
@end
