//
//  TeamerBottomCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamerBottomCell.h"

@implementation TeamerBottomCell

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
                                          textColor:BYColor_Title
                                      textAlignment:NSTextAlignmentLeft];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:font750(28)];
    self.lineView = [BYFactory creatLineView];
    self.descLabel = [BYFactory creatLabelWithText:@""
                                         fontValue:font750(26)
                                         textColor:BYColor_Tag
                                     textAlignment:NSTextAlignmentLeft];
    self.descLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.descLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(60)));
        make.top.equalTo(@(Anno750(20)));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(@(Anno750(20)));
        make.right.equalTo(@(Anno750(-20)));
        make.height.equalTo(@0.5);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(60)));
        make.right.equalTo(@(-Anno750(20)));
        make.top.equalTo(self.lineView.mas_bottom).offset(Anno750(20));
    }];
}
- (void)updateWithCate:(NSString *)cate descStr:(NSString *)str{
    self.titleLabel.text = cate;
    self.descLabel.text = str;
}
@end
