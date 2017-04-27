//
//  StandingTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "StandingTableViewCell.h"

@implementation StandingTableViewCell

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
    self.backgroundColor = [UIColor whiteColor];
    self.numLabel = [self creatLabeL];
    self.nameLabel = [self creatLabeL];
    self.winLabel = [self creatLabeL];
    self.drawLabel = [self creatLabeL];
    self.lostLabel = [self creatLabeL];
    self.hitLabel = [self creatLabeL];
    self.scoreLabel = [self creatLabeL];
    self.line = [BYFactory creatLineView];
    self.teamIcon = [[UIImageView alloc]init];
    [self addSubview:self.line];
    [self addSubview:self.teamIcon];
}
- (UILabel *)creatLabeL{
    UILabel * label = [BYFactory creatLabelWithText:@""
                                          fontValue:font750(28)
                                          textColor:BYColor_Title
                                      textAlignment:NSTextAlignmentCenter];
    [self addSubview:label];
    return label;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(20)));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(30)));
    }];
    [self.teamIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numLabel.mas_right).offset(Anno750(10));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(40)));
        make.height.equalTo(@(Anno750(40)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teamIcon.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(150)));
    }];
    [self.winLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(250/3)));
    }];
    [self.drawLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.winLabel.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(250/3)));
    }];
    [self.lostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.drawLabel.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(250/3)));
    }];
    [self.hitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lostLabel.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(125)));
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hitLabel.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(125)));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(20)));
        make.right.equalTo(@(Anno750(-20)));
        make.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
}
- (void)updateWithModel:(StandingModel *)model{
    if (model.isBer) {
        self.backgroundColor = BYColor_Main;
        self.numLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.winLabel.textColor = [UIColor whiteColor];
        self.drawLabel.textColor = [UIColor whiteColor];
        self.lostLabel.textColor = [UIColor whiteColor];
        self.hitLabel.textColor = [UIColor whiteColor];
        self.scoreLabel.textColor = [UIColor whiteColor];
        self.line.backgroundColor = BYColor_Main;
    }else{
        self.backgroundColor = [UIColor whiteColor];
        self.numLabel.textColor = BYColor_Title;
        self.nameLabel.textColor = BYColor_Title;
        self.winLabel.textColor = BYColor_Title;
        self.drawLabel.textColor = BYColor_Title;
        self.lostLabel.textColor = BYColor_Title;
        self.hitLabel.textColor = BYColor_Title;
        self.scoreLabel.textColor = BYColor_Title;
        self.line.backgroundColor = BYColor_Line;
    }
    self.numLabel.text = [NSString stringWithFormat:@"%@",model.rank_index];
    [self.teamIcon sd_setImageWithURL:[NSURL URLWithString:model.team_logo] placeholderImage:[UIImage imageNamed:@"logoDefalut"]];
    self.nameLabel.text = model.known_name_zh;
    self.winLabel.text = [NSString stringWithFormat:@"%@",model.win];
    self.drawLabel.text = [NSString stringWithFormat:@"%@",model.draw];
    self.lostLabel.text = [NSString stringWithFormat:@"%@",model.lost];
    self.hitLabel.text = [NSString stringWithFormat:@"%@/%@",model.hits,model.miss];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@",model.score];
}
@end
