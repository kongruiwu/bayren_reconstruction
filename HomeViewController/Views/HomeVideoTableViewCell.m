//
//  HomeVideoTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "HomeVideoTableViewCell.h"

@implementation HomeVideoTableViewCell

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
    
    self.mainSc = [[AutoScrollView alloc]initWithFrame:CGRectMake(Anno750(24), 0, Anno750(702), Anno750(380))];
    
    [self addSubview:self.mainSc];
}
- (void)updateWithImages:(NSArray *)images titles:(NSArray *)titles{
    [self.mainSc updateWithImages:images descs:titles];
}
@end
