//
//  TeamListTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamListTableViewCell.h"

@implementation TeamListTableViewCell

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
    self.icon = [BYFactory creatImageViewWithImage:@"teamerDefault"];
    self.cateLabel = [BYFactory creatLabelWithText:@""
                                         fontValue:font750(30)
                                         textColor:BYColor_gray_3
                                     textAlignment:NSTextAlignmentLeft];
    self.CHNameLabel = [BYFactory creatLabelWithText:@""
                                           fontValue:font750(36)
                                           textColor:BYColor_gray_3
                                       textAlignment:NSTextAlignmentLeft];
    self.ENNameLabel = [BYFactory creatLabelWithText:@""
                                           fontValue:font750(36)
                                           textColor:BYColor_gray_3
                                       textAlignment:NSTextAlignmentLeft];
    self.birthLabel = [BYFactory creatLabelWithText:@""
                                          fontValue:font750(28)
                                          textColor:BYColor_Tag
                                      textAlignment:NSTextAlignmentLeft];
    self.teamNum = [BYFactory creatLabelWithText:@""
                                       fontValue:font750(42)
                                       textColor:BYColor_gray_3
                                   textAlignment:NSTextAlignmentCenter];
    self.lineView = [BYFactory creatLineView];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.cateLabel];
    [self.contentView addSubview:self.CHNameLabel];
    [self.contentView addSubview:self.ENNameLabel];
    [self.contentView addSubview:self.birthLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.teamNum];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(20)));
        make.top.equalTo(@(Anno750(30)));
        make.height.equalTo(@(Anno750(320)));
        make.width.equalTo(@(Anno750(190)));
    }];
    [self.cateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(Anno750(20));
        make.top.equalTo(@(Anno750(60)));
    }];
    [self.CHNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cateLabel.mas_left);
        make.top.equalTo(self.cateLabel.mas_bottom).offset(Anno750(30));
    }];
    [self.ENNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.CHNameLabel.mas_left);
        make.top.equalTo(self.CHNameLabel.mas_bottom).offset(Anno750(30));
    }];
    [self.birthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ENNameLabel.mas_left);
        make.top.equalTo(self.ENNameLabel.mas_bottom).offset(Anno750(30));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    [self.teamNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(40)));
        make.top.equalTo(@(Anno750(40)));
    }];
}
-(void)updateWithModel:(ListTeamerModel *)model{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_ImgHost,model.pic]] placeholderImage:[UIImage imageNamed:@"teamerDefault"]];
    self.teamNum.text = [NSString stringWithFormat:@"%@",model.No];
    self.cateLabel.text = model.cate;
    self.ENNameLabel.text = model.name_en;
    self.CHNameLabel.text = model.name;
    self.birthLabel.text = model.birthday;
    
}
@end
