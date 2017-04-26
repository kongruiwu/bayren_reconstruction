//
//  RegitserTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "RegitserTableViewCell.h"

@implementation RegitserTableViewCell

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
    self.nameTextf = [BYFactory creatLoginTextFieldWithPlaceHolder:@"用户名，长度为3-15个字符"
                                                      cornerRadius:Anno750(44)
                                                          textFont:font750(28)
                                                     textAlignment:NSTextAlignmentCenter];
    self.emailTextf = [BYFactory creatLoginTextFieldWithPlaceHolder:@"电子邮箱"
                                                       cornerRadius:Anno750(44)
                                                           textFont:font750(28)
                                                      textAlignment:NSTextAlignmentCenter];
    self.pwdTextf = [BYFactory creatLoginTextFieldWithPlaceHolder:@"填写密码，最小长度为6个字符"
                                                     cornerRadius:Anno750(44)
                                                         textFont:font750(28)
                                                    textAlignment:NSTextAlignmentCenter];
    self.pwdTextf.secureTextEntry = YES;
    self.imageBtn = [BYFactory creatButtonWithNormalImage:@"unselected" selectImage:@"selected"];
    self.selectBtn = [BYFactory creatButtonWithTitle:@"我已阅读并同意"
                                     backGroundColor:[UIColor clearColor]
                                           textColor:[UIColor whiteColor]
                                            textSize:font750(30)];
    self.protoBtn = [BYFactory creatButtonWithTitle:@"网站服务及隐私协议"
                                    backGroundColor:[UIColor clearColor]
                                          textColor:BYColor_Main
                                           textSize:font750(30)];
    self.registerButton = [BYFactory creatButtonWithTitle:@"注册"
                                      backGroundColor:BYColor_Main
                                            textColor:[UIColor whiteColor]
                                             textSize:font750(32)];
    self.registerButton.layer.cornerRadius = Anno750(44);
    NSString * logstr = @"已有账户？立即登陆";
    self.loginBtn = [BYFactory creatButtonWithTitle:@""
                                    backGroundColor:[UIColor clearColor]
                                          textColor:[UIColor whiteColor]
                                           textSize:font750(30)];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:logstr];
    [attStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(logstr.length - 4, 4)];
     [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, logstr.length)];
    [self.loginBtn setAttributedTitle:attStr forState:UIControlStateNormal];
   
    [self addSubview:self.logView];
    [self.logView addSubview:self.nameTextf];
    [self.logView addSubview:self.emailTextf];
    [self.logView addSubview:self.pwdTextf];
    [self.logView addSubview:self.imageBtn];
    [self.logView addSubview:self.selectBtn];
    [self.logView addSubview:self.protoBtn];
    [self.logView addSubview:self.registerButton];
    [self.logView addSubview:self.loginBtn];
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
    [self.pwdTextf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailTextf.mas_bottom).offset(Anno750(40));
        make.left.equalTo(self.nameTextf.mas_left);
        make.right.equalTo(self.nameTextf.mas_right);
        make.height.equalTo(@(Anno750(88)));
    }];
    NSString * str1 = @"我已阅读并同意";
    NSString * str2 = @"网站服务及隐私协议";
    CGSize size1 = [BYFactory getSize:str1 maxSize:CGSizeMake(UI_WIDTH, 999999) font:[UIFont systemFontOfSize:font750(30)]];
    CGSize size2 = [BYFactory getSize:str2 maxSize:CGSizeMake(UI_WIDTH, 999999) font:[UIFont systemFontOfSize:font750(30)]];
    float width = size1.width + size2.width;
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@((UI_WIDTH - width)/2 + Anno750(15)));
        make.top.equalTo(self.pwdTextf.mas_bottom).offset(Anno750(10));
    }];
    [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.selectBtn.mas_left);
        make.centerY.equalTo(self.selectBtn.mas_centerY);
        make.height.width.equalTo(@(font750(30)));
    }];
    [self.protoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBtn.mas_right);
        make.top.equalTo(self.selectBtn.mas_top);
    }];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTextf.mas_bottom).offset(Anno750(80));
        make.left.equalTo(self.nameTextf.mas_left);
        make.right.equalTo(self.nameTextf.mas_right);
        make.height.equalTo(@(Anno750(88)));
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.registerButton.mas_bottom).offset(Anno750(20));
    }];
}
@end
