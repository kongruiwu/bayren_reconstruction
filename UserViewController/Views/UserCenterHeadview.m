//
//  UserCenterHeadview.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "UserCenterHeadview.h"

@implementation UserCenterHeadview
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.topImageView = [BYFactory creatImageViewWithImage:@"regist_back"];
    [self addSubview:self.topImageView];
    
    
    self.userIcon = [BYFactory creatImageViewWithImage:@"porfile_avatar"];
    self.userIcon.layer.masksToBounds = YES;
    self.userIcon.layer.cornerRadius = Anno750(80);
    [self addSubview:self.userIcon];

    self.userName = [BYFactory creatLabelWithText:@""
                                        fontValue:font750(30)
                                        textColor:BYColor_Main
                                    textAlignment:NSTextAlignmentCenter];
    [self addSubview:self.userName];

    self.timeLabel = [BYFactory creatLabelWithText:@""
                                         fontValue:font750(24)
                                         textColor:BYColor_Tag
                                     textAlignment:NSTextAlignmentCenter];
    [self addSubview:self.timeLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@(Anno750(200)+64));
    }];
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topImageView.mas_bottom);
        make.centerX.equalTo(@0);
        make.width.height.equalTo(@(Anno750(160)));
    }];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIcon.mas_bottom).offset(Anno750(30));
        make.centerX.equalTo(@0);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom).offset(Anno750(30));
        make.centerX.equalTo(@0);
    }];
}
- (void)updateUI{
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:[UserManager manager].user.avatar] placeholderImage:[UIImage imageNamed:@"porfile_avatar"]];
    self.userName.text = [UserManager manager].user.username;
    self.timeLabel.text = [NSString stringWithFormat:@"注册时间：%@",[UserManager manager].user.reg_date];
}
@end
