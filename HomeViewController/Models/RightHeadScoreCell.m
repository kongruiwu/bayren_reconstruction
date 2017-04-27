//
//  RightHeadScoreCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "RightHeadScoreCell.h"

@implementation RightHeadScoreCell

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
    self.nameLabel = [self creatLabelWithTitle:@"俱乐部"];
    self.winLabel = [self creatLabelWithTitle:@"胜/平/负"];
    self.ballLabel = [self creatLabelWithTitle:@"进/失球"];
    self.scroeLabel = [self creatLabelWithTitle:@"积分"];
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.winLabel];
    [self.contentView addSubview:self.ballLabel];
    [self.contentView addSubview:self.scroeLabel];
    
}
- (UILabel *)creatLabelWithTitle:(NSString *)title{
    UILabel * label = [BYFactory creatLabelWithText:title fontValue:font750(28) textColor:[UIColor whiteColor]
                                      textAlignment:NSTextAlignmentCenter];
    label.font = [UIFont boldSystemFontOfSize:font750(28)];
    return label;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.equalTo(@(Anno750(270)));
        make.centerY.equalTo(@0);
    }];
    [self.winLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right);
        make.width.equalTo(@(Anno750(140)));
        make.centerY.equalTo(@0);
    }];
    [self.ballLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.winLabel.mas_right);
        make.width.equalTo(@(Anno750(140)));
        make.centerY.equalTo(@0);
    }];
    [self.scroeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ballLabel.mas_right);
        make.width.equalTo(@(Anno750(100)));
        make.centerY.equalTo(@0);
    }];
    
}
@end
