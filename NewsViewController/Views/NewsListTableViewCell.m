//
//  NewsListTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "NewsListTableViewCell.h"

@implementation NewsListTableViewCell

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
    self.icon = [BYFactory creatImageViewWithImage:@"news_defult"];
    self.titleLabel = [BYFactory creatLabelWithText:@"太完美太惊艳了！我们是拜仁!"
                                          fontValue:font750(28)
                                          textColor:BYColor_Title
                                      textAlignment:NSTextAlignmentLeft];
    self.descLabel = [BYFactory creatLabelWithText:@""
                                         fontValue:font750(24)
                                         textColor:BYColor_Tag
                                     textAlignment:NSTextAlignmentLeft];
    self.descLabel.numberOfLines = 2;
    self.timeLabel = [BYFactory creatLabelWithText:@"22:12"
                                         fontValue:font750(24)
                                         textColor:BYColor_Tag
                                     textAlignment:NSTextAlignmentRight];
    self.line = [BYFactory creatLineView];
    [self addSubview:self.icon];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.line];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(15)));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(130)));
        make.width.equalTo(@(Anno750(200)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(Anno750(20));
        make.right.equalTo(@(-Anno750(20)));
        make.top.equalTo(@(Anno750(20)));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(@(-Anno750(20)));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Anno750(10));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(Anno750(-20)));
        make.bottom.equalTo(@(-Anno750(20)));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(@0);
    }];
}
- (void)updateWithModel:(NewsListModel *)model{
    NSURL * imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_ImgHost,model.pic]];
    [self.icon sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"news_defult"]];
    self.titleLabel.text = model.title;
    self.descLabel.text = model.content;
    self.timeLabel.text = model.date;
}
- (void)updateWithSerachModel:(SearchResultModel *)model{
    NSURL * imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_ImgHost,model.pic]];
    [self.icon sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"news_defult"]];
    self.titleLabel.text = model.title;
    self.descLabel.text = model.content;
    self.timeLabel.text = model.date;
}
@end
