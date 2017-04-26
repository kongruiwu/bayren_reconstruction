//
//  SettingCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

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
    self.titleLabel = [BYFactory creatLabelWithText:@""
                                          fontValue:font750(28)
                                          textColor:[UIColor blackColor]
                                      textAlignment:NSTextAlignmentLeft];
    self.descLabe = [BYFactory creatLabelWithText:@""
                                        fontValue:font750(28)
                                        textColor:BYColor_Tag
                                    textAlignment:NSTextAlignmentRight];
    self.nextIcon = [BYFactory creatArrowImage];
    self.lineView = [BYFactory creatLineView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabe];
    [self addSubview:self.nextIcon];
    [self addSubview:self.lineView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.nextIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(Anno750(-24)));
        make.centerY.equalTo(@0);
    }];
    [self.descLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.nextIcon.mas_left).offset(Anno750(-12));
        make.centerY.equalTo(@0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
}
- (void)updateWithTitle:(NSString *)title desc:(NSString *)desc rec:(BOOL)rec{
    self.nextIcon.hidden = rec;
    self.titleLabel.text = title;
    self.descLabe.text = desc;
}
@end
