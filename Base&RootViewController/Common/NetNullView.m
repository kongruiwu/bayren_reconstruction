//
//  NetNullView.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/28.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "NetNullView.h"

@implementation NetNullView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = BYColor_Ground;
    self.imgView = [BYFactory creatImageViewWithImage:@"icon_loading_failure"];
    self.titleLabel = [BYFactory creatLabelWithText:@"信号出小差了"
                                          fontValue:font750(30)
                                          textColor:BYColor_Main textAlignment:NSTextAlignmentCenter];
    self.reloadButton = [BYFactory creatButtonWithTitle:@"点我刷新"
                                        backGroundColor:[UIColor clearColor]
                                              textColor:BYColor_Main textSize:font750(30)];
    self.reloadButton.layer.borderColor = BYColor_Main.CGColor;
    self.reloadButton.layer.borderWidth = 1.0f;
    self.reloadButton.layer.cornerRadius = 2.0f;
    [self addSubview:self.reloadButton];
    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@(Anno750(40)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(Anno750(20));
        make.centerX.equalTo(@0);
    }];
    [self.reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(Anno750(280)));
        make.height.equalTo(@(Anno750(80)));
        make.centerX.equalTo(@0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Anno750(20));
    }];
}
@end
