//
//  TeamerHeadCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamerHeadCell.h"

@implementation TeamerHeadCell

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
    self.numLabel = [BYFactory creatLabelWithText:@""
                                        fontValue:font750(60)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.numLabel.backgroundColor = BYColor_Main;
    
    self.cateLabel = [BYFactory creatLabelWithText:@""
                                         fontValue:font750(30)
                                         textColor:BYColor_Tag
                                     textAlignment:NSTextAlignmentLeft];
    self.ZnNameLabel = [BYFactory creatLabelWithText:@""
                                           fontValue:font750(30)
                                           textColor:BYColor_Main
                                       textAlignment:NSTextAlignmentLeft];
    self.EnNameLabel = [BYFactory creatLabelWithText:@""
                                           fontValue:font750(30)
                                           textColor:BYColor_Main
                                       textAlignment:NSTextAlignmentLeft];
    self.teamerImg = [BYFactory creatImageViewWithImage:@"teamerDefault"];
    self.titleLabel = [BYFactory creatLabelWithText:@"个人简介"
                                          fontValue:font750(28)
                                          textColor:BYColor_Title
                                      textAlignment:NSTextAlignmentLeft];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:font750(28)];
    self.lineView = [BYFactory creatLineView];
    [self addSubview:self.numLabel];
    [self addSubview:self.cateLabel];
    [self addSubview:self.ZnNameLabel];
    [self addSubview:self.EnNameLabel];
    [self addSubview:self.teamerImg];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(20)));
        make.top.equalTo(@(Anno750(30)));
        make.width.equalTo(@(Anno750(80)));
        make.height.equalTo(@(Anno750(120)));
    }];
    [self.teamerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(Anno750(30)));
        make.right.equalTo(@(-Anno750(20)));
        make.height.equalTo(@(Anno750(450)));
        make.width.equalTo(@(Anno750(270)));
    }];
    [self.cateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numLabel.mas_right).offset(Anno750(20));
        make.right.equalTo(self.teamerImg.mas_right).offset(-Anno750(20));
        make.top.equalTo(@(Anno750(30)));
    }];
    [self.ZnNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cateLabel.mas_left);
        make.right.equalTo(self.cateLabel.mas_right);
        make.centerY.equalTo(self.numLabel.mas_centerY);
    }];
    [self.EnNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cateLabel.mas_left);
        make.right.equalTo(self.cateLabel.mas_right);
        make.bottom.equalTo(self.numLabel.mas_bottom);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(20)));
        make.right.equalTo(@(Anno750(-20)));
        make.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(60)));
        make.bottom.equalTo(@0);
    }];
}
- (void)updateWithModel:(TeamerModel *)model{
    if ([model.is_coach boolValue]) {
        self.numLabel.text = [NSString stringWithFormat:@"%@",model.No];
        self.cateLabel.text = model.type;
    }else{
        self.numLabel.text = @"";
        self.cateLabel.text = model.title;
    }
    
    self.ZnNameLabel.text = model.name;
    self.EnNameLabel.text = model.name_en;
    [self.teamerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_ImgHost,model.pic]] placeholderImage:[UIImage imageNamed:@"teamerDefault"]];
}
@end
