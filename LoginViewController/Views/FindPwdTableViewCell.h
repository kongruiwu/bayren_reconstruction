//
//  FindPwdTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "logoView.h"
@interface FindPwdTableViewCell : UITableViewCell
@property (nonatomic, strong) logoView * logView;
@property (nonatomic, strong) UITextField * nameTextf;
@property (nonatomic, strong) UITextField * emailTextf;
@property (nonatomic, strong) UIButton * findButton;
@end
