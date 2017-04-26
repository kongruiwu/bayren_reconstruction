//
//  LogModelCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/6.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LogModelCell.h"

@interface LogModelCell()


@end


@implementation LogModelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = [UIColor clearColor];
    self.logView = [[logoView alloc]init];
    self.nameTextf = [BYFactory creatLoginTextFieldWithPlaceHolder:@"用户名/邮箱"
                                                      cornerRadius:Anno750(44)
                                                          textFont:font750(28)
                                                     textAlignment:NSTextAlignmentCenter];
    self.pwdTextf = [BYFactory creatLoginTextFieldWithPlaceHolder:@"密码"
                                                     cornerRadius:Anno750(44)
                                                         textFont:font750(28)
                                                    textAlignment:NSTextAlignmentCenter];
    self.pwdTextf.secureTextEntry = YES;
    self.loginButton = [BYFactory creatButtonWithTitle:@"登录"
                                       backGroundColor:BYColor_Main
                                             textColor:[UIColor whiteColor]
                                              textSize:font750(32)];
    self.loginButton.layer.cornerRadius = Anno750(44);
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = [UIColor whiteColor];

    self.findPwdBtn = [BYFactory creatButtonWithTitle:@"找回密码"
                                      backGroundColor:[UIColor clearColor]
                                            textColor:[UIColor whiteColor]
                                             textSize:font750(30)];
    self.regiserBtn = [BYFactory creatButtonWithTitle:@"10秒新人注册"
                                      backGroundColor:[UIColor clearColor]
                                            textColor:[UIColor whiteColor]
                                             textSize:font750(30)];
    [self.findPwdBtn addTarget:self action:@selector(pushToFindPasswordViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.regiserBtn addTarget:self action:@selector(pushToRegisterViewController) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.logView];
    [self.logView addSubview:self.nameTextf];
    [self.logView addSubview:self.pwdTextf];
    [self.logView addSubview:self.loginButton];
    [self.logView addSubview:self.line];
    [self.logView addSubview:self.findPwdBtn];
    [self.logView addSubview:self.regiserBtn];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.logView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@(Anno750(90)));
        make.bottom.equalTo(@0);
    }];
    [self.nameTextf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logView.entitle.mas_bottom).offset(Anno750(40));
        make.left.equalTo(self.logView.blackView.mas_left).offset(Anno750(40));
        make.right.equalTo(self.logView.blackView.mas_right).offset(-Anno750(40));
        make.height.equalTo(@(Anno750(88)));
    }];
    [self.pwdTextf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextf.mas_bottom).offset(Anno750(40));
        make.left.equalTo(self.nameTextf.mas_left);
        make.right.equalTo(self.nameTextf.mas_right);
        make.height.equalTo(@(Anno750(88)));
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pwdTextf.mas_left);
        make.right.equalTo(self.pwdTextf.mas_right);
        make.top.equalTo(self.pwdTextf.mas_bottom).offset(Anno750(40));
        make.height.equalTo(@(Anno750(88)));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.equalTo(@1);
        make.height.equalTo(@(Anno750(25)));
        make.top.equalTo(self.loginButton.mas_bottom).offset(Anno750(50));
    }];
    [self.findPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.line.mas_left).offset(Anno750(-40));
        make.centerY.equalTo(self.line.mas_centerY);
    }];
    [self.regiserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_right).offset(Anno750(40));
        make.centerY.equalTo(self.line.mas_centerY);
    }];
    
}
- (void)pushToFindPasswordViewController{
    if (self.subJect) {
        [self.subJect sendNext:@"找回密码"];
    }
}
- (void)pushToRegisterViewController{
    if (self.subJect) {
        [self.subJect sendNext:@"注册"];
    }
}

@end
