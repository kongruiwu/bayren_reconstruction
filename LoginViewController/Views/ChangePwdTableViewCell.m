//
//  ChangePwdTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ChangePwdTableViewCell.h"

@implementation ChangePwdTableViewCell

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
    self.logoView = [[logoView alloc]init];
    self.oldPwdTextf = [BYFactory creatLoginTextFieldWithPlaceHolder:@"请输入旧密码"
                                                      cornerRadius:Anno750(44)
                                                          textFont:font750(28)
                                                     textAlignment:NSTextAlignmentCenter];
    self.pwdTextf = [BYFactory creatLoginTextFieldWithPlaceHolder:@"请输入新密码"
                                                     cornerRadius:Anno750(44)
                                                         textFont:font750(28)
                                                    textAlignment:NSTextAlignmentCenter];
    self.aginTextf = [BYFactory creatLoginTextFieldWithPlaceHolder:@"确认新密码"
                                                      cornerRadius:Anno750(44)
                                                          textFont:font750(28)
                                                     textAlignment:NSTextAlignmentCenter];
    self.changeButton = [BYFactory creatButtonWithTitle:@"修改密码"
                                          backGroundColor:BYColor_Main
                                                textColor:[UIColor whiteColor]
                                                 textSize:font750(32)];
    self.changeButton.layer.cornerRadius = Anno750(44);
    [self addSubview:self.logoView];
    [self.logoView addSubview:self.oldPwdTextf];
    [self.logoView addSubview:self.pwdTextf];
    [self.logoView addSubview:self.aginTextf];
    [self.logoView addSubview:self.changeButton];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@(Anno750(90)));
        make.bottom.equalTo(@0);
    }];
    [self.oldPwdTextf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoView.entitle.mas_bottom).offset(Anno750(40));
        make.left.equalTo(self.logoView.blackView.mas_left).offset(Anno750(40));
        make.right.equalTo(self.logoView.blackView.mas_right).offset(-Anno750(40));
        make.height.equalTo(@(Anno750(88)));
    }];
    [self.pwdTextf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oldPwdTextf.mas_left);
        make.right.equalTo(self.oldPwdTextf.mas_right);
        make.height.equalTo(@(Anno750(88)));
        make.top.equalTo(self.oldPwdTextf.mas_bottom).offset(Anno750(40));
    }];
    [self.aginTextf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oldPwdTextf.mas_left);
        make.right.equalTo(self.oldPwdTextf.mas_right);
        make.height.equalTo(@(Anno750(88)));
        make.top.equalTo(self.pwdTextf.mas_bottom).offset(Anno750(40));
    }];
    
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oldPwdTextf.mas_left);
        make.right.equalTo(self.oldPwdTextf.mas_right);
        make.height.equalTo(@(Anno750(88)));
        make.top.equalTo(self.aginTextf.mas_bottom).offset(Anno750(40));
    }];
}
@end
