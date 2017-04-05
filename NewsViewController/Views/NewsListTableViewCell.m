//
//  NewsListTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/31.
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
    self.imgView = [[UIImageView alloc]init];
    self.titleLabel = [BYFactory creatLabelWithText:@""
                                          fontValue:font750(30)
                                          textColor:BYColor_Title
                                      textAlignment:NSTextAlignmentLeft];
    self.contentLabel = [BYFactory creatLabelWithText:@""
                                            fontValue:font750(24)
                                            textColor:BYColor_Tag
                                        textAlignment:NSTextAlignmentLeft];
    self.contentLabel.numberOfLines = 0;
    self.timeLabel = [BYFactory creatLabelWithText:@""
                                         fontValue:font750(24)
                                         textColor:BYColor_Tag
                                     textAlignment:NSTextAlignmentLeft];
    self.line = [BYFactory creatLineView];
    
    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.line];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(@(Anno750(20)));
        make.bottom.equalTo(@(Anno750(-20)));
        make.width.equalTo(@(Anno750(200)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(Anno750(20));
        make.top.equalTo(self.imgView.mas_top);
        make.right.equalTo(@(Anno750(-24)));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(Anno750(-24)));
        make.bottom.equalTo(self.imgView.mas_bottom);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.titleLabel.mas_right);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.bottom.equalTo(self.timeLabel.mas_top);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@0);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(@0);
    }];
}
@end
