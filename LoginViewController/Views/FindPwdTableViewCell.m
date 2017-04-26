//
//  FindPwdTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "FindPwdTableViewCell.h"

@implementation FindPwdTableViewCell

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
    self.nameTextf = [BYFactory creatLoginTextFieldWithPlaceHolder:@"用户名"
                                                      cornerRadius:Anno750(44)
                                                          textFont:font750(28)
                                                     textAlignment:NSTextAlignmentCenter];
    self.emailTextf = [BYFactory creatLoginTextFieldWithPlaceHolder:@"邮箱"
                                                     cornerRadius:Anno750(44)
                                                         textFont:font750(28)
                                                    textAlignment:NSTextAlignmentCenter];
    self.findButton = [BYFactory creatButtonWithTitle:@"找回密码"
                                       backGroundColor:BYColor_Main
                                             textColor:[UIColor whiteColor]
                                              textSize:font750(32)];
    self.findButton.layer.cornerRadius = Anno750(44);
    [self addSubview:self.logView];
    [self.logView addSubview:self.nameTextf];
    [self.logView addSubview:self.emailTextf];
    [self.logView addSubview:self.findButton];
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
    [self.emailTextf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextf.mas_bottom).offset(Anno750(40));
        make.left.equalTo(self.nameTextf.mas_left);
        make.right.equalTo(self.nameTextf.mas_right);
        make.height.equalTo(@(Anno750(88)));
    }];
    [self.findButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameTextf.mas_left);
        make.right.equalTo(self.nameTextf.mas_right);
        make.top.equalTo(self.emailTextf.mas_bottom).offset(Anno750(40));
        make.height.equalTo(@(Anno750(88)));
    }];

}
@end
