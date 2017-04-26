//
//  HomeAdTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface HomeAdTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView * backImg;
- (void)updateWithImageUrlStr:(NSString *)imageUlr;
@end
