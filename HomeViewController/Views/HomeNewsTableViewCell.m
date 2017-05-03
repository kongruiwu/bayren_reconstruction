//
//  HomeNewsTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "HomeNewsTableViewCell.h"

@implementation HomeNewsTableViewCell

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
    self.groundView = [BYFactory creatViewWithColor:BYColor_Alpha_gray];
    self.icon = [BYFactory creatImageViewWithImage:@"news_defult"];
    self.titleLabel = [BYFactory creatLabelWithText:@"太完美太惊艳了！我们是拜仁!"
                                          fontValue:font750(28)
                                          textColor:[UIColor whiteColor]
                                      textAlignment:NSTextAlignmentLeft];
    self.descLabel = [BYFactory creatLabelWithText:@""
                                         fontValue:font750(24)
                                         textColor:BYColor_Tag
                                     textAlignment:NSTextAlignmentLeft];
    self.descLabel.numberOfLines = 2;
//    self.timeLabel = [BYFactory creatLabelWithText:@"22:12"
//                                         fontValue:font750(26)
//                                         textColor:BYColor_Tag
//                                     textAlignment:NSTextAlignmentRight];
    [self addSubview:self.groundView];
    [self.groundView addSubview:self.icon];
    [self.groundView addSubview:self.titleLabel];
    [self.groundView addSubview:self.descLabel];
//    [self.groundView addSubview:self.timeLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.groundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(15)));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(115)));
        make.width.equalTo(@(Anno750(200)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(Anno750(20));
        make.top.equalTo(self.icon.mas_top);
        make.right.equalTo(@(-Anno750(24)));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.right.equalTo(@(-Anno750(24)));
        make.bottom.equalTo(@(-Anno750(10)));
    }];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(@(Anno750(-20)));
//        make.bottom.equalTo(self.icon.mas_bottom);
//    }];
}
- (void)updateWithModel:(NewsListModel *)model{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_ImgHost,model.pic]];
    [self.icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"news_defult"]];
    self.titleLabel.text = model.title;
    self.descLabel.text = model.content;
//    self.timeLabel.text = model.date;
}
@end
