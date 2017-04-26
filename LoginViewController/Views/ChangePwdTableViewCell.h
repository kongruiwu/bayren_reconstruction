//
//  ChangePwdTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "logoView.h"
@interface ChangePwdTableViewCell : UITableViewCell
@property (nonatomic, strong) logoView * logoView;
@property (nonatomic, strong) UITextField * oldPwdTextf;
@property (nonatomic, strong) UITextField * pwdTextf;
@property (nonatomic, strong) UITextField * aginTextf;
@property (nonatomic, strong) UIButton * changeButton;

@end
