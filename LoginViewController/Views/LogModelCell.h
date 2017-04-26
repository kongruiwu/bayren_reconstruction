//
//  LogModelCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/6.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "logoView.h"
@interface LogModelCell : UITableViewCell

@property (nonatomic, strong) logoView * logView;
@property (nonatomic, strong) UITextField * nameTextf;
@property (nonatomic, strong) UITextField * pwdTextf;
@property (nonatomic, strong) UIButton * loginButton;
@property (nonatomic, strong) UIView * line;
@property (nonatomic, strong) UIButton * findPwdBtn;
@property (nonatomic, strong) UIButton * regiserBtn;

@property (nonatomic, strong) RACSubject * subJect;

@end
