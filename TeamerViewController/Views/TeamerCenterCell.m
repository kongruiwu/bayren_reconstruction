//
//  TeamerCenterCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamerCenterCell.h"

@implementation TeamerCenterCell

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
                                          fontValue:font750(26)
                                          textColor:BYColor_Tag
                                      textAlignment:NSTextAlignmentLeft];
    self.descLabel = [BYFactory creatLabelWithText:@""
                                         fontValue:font750(26)
                                         textColor:BYColor_Tag
                                     textAlignment:NSTextAlignmentRight];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(60)));
        make.centerY.equalTo(@0);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(60)));
        make.centerY.equalTo(@0);
    }];
}
- (void)updateWithTitle:(NSString *)titles descs:(NSString *)desc{
    self.titleLabel.text = titles;
    self.descLabel.text = desc;
}


@end
