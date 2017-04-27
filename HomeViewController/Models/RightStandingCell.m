//
//  RightStandingCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "RightStandingCell.h"

@implementation RightStandingCell

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
    self.numLabel =[self creatLabeL];
    self.icon = [BYFactory creatImageViewWithImage:@""];
    self.nameLabel = [self creatLabeL];
    self.resultLabel = [self creatLabeL];
    self.ballLabel = [self creatLabeL];
    self.scoreLabel = [self creatLabeL];
    [self addSubview:self.icon];
}
- (UILabel *)creatLabeL{
    UILabel * label = [BYFactory creatLabelWithText:@""
                                          fontValue:font750(28)
                                          textColor:[UIColor whiteColor]
                                      textAlignment:NSTextAlignmentCenter];
    [self addSubview:label];
    return label;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@((Anno750(20))));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(30)));
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numLabel.mas_right).offset(Anno750(5));
        make.centerY.equalTo(@0);
        make.height.width.equalTo(@(Anno750(50)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(Anno750(15));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(150)));
    }];
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(140)));
    }];
    [self.ballLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.resultLabel.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(140)));
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ballLabel.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(100)));
    }];
}
- (void)updateWithTeamRankModel:(RightStandModel *)model{
    self.nameLabel.text = model.name_zh;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.team_logo] placeholderImage:[UIImage imageNamed:@"logoDefalut"]];
    self.resultLabel.text = model.winString;
    self.ballLabel.text = model.basllNumberStr;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@",model.score];
    self.numLabel.text = [NSString stringWithFormat:@"%@",model.rank_index];
    if (model.isHomeTeam) {
        self.backgroundColor = BYColor_Main;
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
