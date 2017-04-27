//
//  HomeTeamerView.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "HomeTeamerView.h"

@implementation HomeTeamerView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = BYColor_Alpha_gray;
    self.teamerImg = [BYFactory creatImageViewWithImage:@"teamerDefault"];
    self.numLabel = [BYFactory creatLabelWithText:@"25"
                                        fontValue:font750(26)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.numLabel.backgroundColor = BYColor_Main;
    
    self.grayView = [BYFactory creatViewWithColor:BYColor_Alpha_gray];
    self.nameLabel = [BYFactory creatLabelWithText:@"托马斯穆勒"
                                         fontValue:font750(26)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentLeft];
    
    [self addSubview:self.teamerImg];
    [self addSubview:self.numLabel];
    [self addSubview:self.grayView];
    [self.grayView addSubview:self.nameLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.teamerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(40)));
        make.height.equalTo(@(Anno750(40)));
    }];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numLabel.mas_right);
        make.bottom.equalTo(@0);
        make.height.equalTo(@(Anno750(40)));
        make.right.equalTo(@0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(20)));
        make.centerY.equalTo(@0);
    }];
}
- (void)updateWithModel:(HomeTeamerModel *)model{
    NSString * imageStr = [NSString stringWithFormat:@"%@",model.pic];
    [self.teamerImg sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"teamerDefault"]];
    self.numLabel.text = model.number;
    self.nameLabel.text = model.name;
}
@end
