//
//  PhotoListTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoListTableViewCell.h"

@implementation PhotoListTableViewCell

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
    self.backImg = [BYFactory creatImageViewWithImage:@"news_defult"];
    self.grayView = [BYFactory creatViewWithColor:UIColorFromRGBA(0x000000, 0.4)];
    self.titlelabel = [BYFactory creatLabelWithText:@"拜仁6:1大胜波尔图，挺进欧冠四强！"
                                          fontValue:font750(30)
                                          textColor:[UIColor whiteColor]
                                      textAlignment:NSTextAlignmentLeft];
    self.timeLabel = [BYFactory creatLabelWithText:@"2017-03-16   22:11"
                                         fontValue:font750(26)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentLeft];
    self.countImg = [BYFactory creatImageViewWithImage:@"iconImg"];
    self.countLabel = [BYFactory creatLabelWithText:@"10"
                                          fontValue:font750(24)
                                          textColor:[UIColor whiteColor]
                                      textAlignment:NSTextAlignmentRight];
    [self addSubview:self.backImg];
    [self addSubview:self.grayView];
    [self.grayView addSubview:self.titlelabel];
    [self.grayView addSubview:self.timeLabel];
    [self.grayView addSubview:self.countLabel];
    [self.grayView addSubview:self.countImg];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@(Anno750(90)));
    }];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(@(Anno750(10)));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(self.titlelabel.mas_bottom).offset(Anno750(5));
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.countImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.countLabel.mas_left).offset(Anno750(-10));
        make.centerY.equalTo(@0);
    }];
}

- (void)updateWithModel:(PhotoListModel *)model{
    NSURL * imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_ImgHost,model.pic]];
    [self.backImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"news_defult"]];
    self.titlelabel.text = model.title;
    self.timeLabel.text = model.date;
//    self.countLabel
}
@end
