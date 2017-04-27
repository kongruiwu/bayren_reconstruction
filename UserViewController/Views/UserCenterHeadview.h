//
//  UserCenterHeadview.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "UserManager.h"
@interface UserCenterHeadview : UIView
@property (nonatomic, strong) UIImageView * topImageView;
@property (nonatomic, strong) UIImageView * userIcon;
@property (nonatomic, strong) UILabel * userName;
@property (nonatomic, strong) UILabel * timeLabel;
- (void)updateUI;
@end
