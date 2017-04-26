//
//  logoView.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/6.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "logoView.h"

@implementation logoView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.blackView = [BYFactory creatViewWithColor:BYColor_login];
    self.logo = [BYFactory creatImageViewWithImage:@"Logo_big"];
    self.zntitle = [BYFactory creatLabelWithText:@"拜仁慕尼黑"
                                       fontValue:font750(46)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentCenter];
    self.zntitle.font = [UIFont boldSystemFontOfSize:font750(46)];
    self.entitle = [BYFactory creatLabelWithText:@"FC Bayern Munchen"
                                       fontValue:font750(28)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentCenter];
    self.entitle.font = [UIFont boldSystemFontOfSize:font750(28)];
    [self addSubview:self.blackView];
    [self addSubview:self.logo];
    [self addSubview:self.zntitle];
    [self addSubview:self.entitle];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(@0);
        make.width.height.equalTo(@(Anno750(200)));
    }];
    [self.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logo.mas_centerY);
        make.left.equalTo(@(Anno750(40)));
        make.right.equalTo(@(Anno750(-40)));
        make.bottom.equalTo(@0);
    }];
    
    [self.zntitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logo.mas_bottom).offset(Anno750(40));
        make.centerX.equalTo(@0);
    }];
    [self.entitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zntitle.mas_bottom);
        make.centerX.equalTo(@0);
    }];
    
}

@end
