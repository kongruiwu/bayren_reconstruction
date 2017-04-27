//
//  LeftUserHeadCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LeftUserHeadCell.h"

@implementation LeftUserHeadCell

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
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)creatUI{
    self.headIcon = [[UIImageView alloc]init];
    self.nameLabel = [BYFactory creatLabelWithText:@"" fontValue:font750(30)
                                         textColor:BYColor_Main textAlignment:NSTextAlignmentCenter];
    self.redView = [BYFactory creatViewWithColor:BYColor_Main];
    self.grayView = [BYFactory creatViewWithColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]];
    self.redView.hidden = YES;
    self.grayView.hidden = YES;
    [self addSubview:self.redView];
    [self addSubview:self.grayView];
    [self addSubview:self.headIcon];
    [self addSubview:self.nameLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(Anno750(20)));
        make.centerX.equalTo(@(-Anno750(20)));
        make.height.equalTo(@(Anno750(100)));
        make.width.equalTo(@(Anno750(100)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headIcon.mas_bottom).offset(Anno750(30));
        make.centerX.equalTo(@(-Anno750(20)));
    }];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(10)));
    }];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redView.mas_right);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}
- (void)updateUserInfo{
    self.headIcon.image = [UIImage imageNamed:@"leftnav_avatar"];
    self.nameLabel.text = @"登 录 / 注 册";
}


@end
