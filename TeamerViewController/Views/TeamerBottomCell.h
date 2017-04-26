//
//  TeamerBottomCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface TeamerBottomCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UILabel * descLabel;
- (void)updateWithCate:(NSString *)cate descStr:(NSString *)str;
@end
