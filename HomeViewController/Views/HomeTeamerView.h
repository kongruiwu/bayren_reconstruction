//
//  HomeTeamerView.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTeamerModel.h"
#import "ConfigHeader.h"
@interface HomeTeamerView : UIView

@property (nonatomic, strong) UIImageView * teamerImg;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UIView * grayView;
- (void)updateWithModel:(HomeTeamerModel *)model;
@end
