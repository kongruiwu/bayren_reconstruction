//
//  RegitserTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "logoView.h"
@protocol RegitserTableViewCellDelegate <NSObject>

- (void)pushToProtocolViewController;
- (void)backToLoginViewController;
- (void)userRegisterWith:(NSString *)userName email:(NSString *)email password:(NSString *)pwd;

@end


@interface RegitserTableViewCell : UITableViewCell
@property (nonatomic, strong) logoView * logView;
@property (nonatomic, strong) UITextField * nameTextf;
@property (nonatomic, strong) UITextField * emailTextf;
@property (nonatomic, strong) UITextField * pwdTextf;
@property (nonatomic, strong) UIButton * imageBtn;
@property (nonatomic, strong) UIButton * selectBtn;
@property (nonatomic, strong) UIButton * protoBtn;
@property (nonatomic, strong) UIButton * registerButton;
@property (nonatomic, strong) UIButton * loginBtn;
@property (nonatomic, assign) id delegate;
@end
