//
//  LeftTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell

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
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)creatUI{
    self.icon = [[UIImageView alloc]init];
    self.ZNLabel = [BYFactory creatLabelWithText:@"" fontValue:font750(36)
                                       textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    self.ENlabel = [BYFactory creatLabelWithText:@"" fontValue:font750(24)
                                       textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    self.ENlabel.font =[UIFont boldSystemFontOfSize:font750(20)];
    self.redView = [[UIView alloc]init];
    self.redView.backgroundColor = BYColor_Main;
    
    self.grayView = [[UIView alloc]init];
    self.grayView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    self.redView.hidden = YES;
    self.grayView.hidden = YES;
    [self addSubview:self.redView];
    [self addSubview:self.grayView];
    [self addSubview:self.ZNLabel];
    [self addSubview:self.ENlabel];
    [self addSubview:self.icon];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(10)));
    }];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redView.mas_right);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redView).offset(Anno750(100));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(50)));
        make.height.equalTo(@(Anno750(50)));
    }];
    [self.ZNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(Anno750(20));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(120)));
    }];
    [self.ENlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ZNLabel.mas_right).offset(Anno750(20));
        make.centerY.equalTo(@0);
    }];
}
- (void)updateWithZnTitle:(NSString *)ZNtitle ENtitle:(NSString *)ENtitle iconName:(NSString *)iconName{
    self.ZNLabel.text =ZNtitle;
    self.ENlabel.text = ENtitle;
    self.icon.image = [UIImage imageNamed:iconName];
}
@end
