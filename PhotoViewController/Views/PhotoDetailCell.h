//
//  PhotoDetailCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface PhotoDetailCell : UICollectionViewCell

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UILabel * pageLabel;
@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UIScrollView * mainSc;
@property (nonatomic, strong) UIView * grayView;
@property (nonatomic, strong) UIButton * downLoadBtn;
@property (nonatomic, strong) UIImageView * imgView;

@end
