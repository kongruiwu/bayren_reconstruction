//
//  BYFactory.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BYFactory.h"
#import "ConfigHeader.h"
@implementation BYFactory
/**
 creat tabview
 */
+ (UITableView *)creatTabviewWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    UITableView * tabview = [[UITableView alloc]initWithFrame:frame style:style];
    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabview.showsVerticalScrollIndicator = NO;
    tabview.showsHorizontalScrollIndicator = NO;
    tabview.backgroundColor = [UIColor clearColor];
    return tabview;
}

/**
 creat Label
 */
+ (UILabel *)creatLabelWithText:(NSString *)title fontValue:(float)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment{
    UILabel * label = [[UILabel alloc]init];
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = alignment;
    return label;
}

/**
 creat button
 */
+ (UIButton *)creatButtonWithTitle:(NSString *)title backGroundColor:(UIColor *)groundColor textColor:(UIColor *)textColor textSize:(float)fontValue{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:groundColor];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontValue];
    return button;
}
+ (UIButton *)creatButtonWithNormalImage:(NSString *)normalImage selectImage:(NSString *)selectImage{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    if (selectImage != nil) {
        [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    }
    return button;
}

/**
 creat imgView with img
 */
+ (UIImageView *)creatImageViewWithImage:(NSString *)imageName{
    UIImageView * imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:imageName];
    return imgView;
}
/**
 creat arrrowimage
 */
+ (UIImageView *)creatArrowImage{
    UIImageView * imgview = [[UIImageView alloc]init];
    imgview.image = [UIImage imageNamed:@"arrows"];
    return imgview;
}
/**
 creat line
 */
+ (UIView *)creatLineView{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = BYColor_Line;
    return view;
}
/**
 creat color view
 */
+ (UIView *)creatViewWithColor:(UIColor *)color{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = color;
    return view;
}
/**
 creat TextField
 */
+ (UITextField *)creatLoginTextFieldWithPlaceHolder:(NSString *)placeHolder cornerRadius:(CGFloat)cornerRadius textFont:(CGFloat)font textAlignment:(NSTextAlignment)aligment{
    UITextField * textF = [[UITextField alloc]init];
    textF.layer.borderColor = [UIColor whiteColor].CGColor;
    textF.layer.borderWidth = 1.0f;
    textF.font = [UIFont systemFontOfSize:font];
    textF.layer.cornerRadius = cornerRadius;
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:placeHolder];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, placeHolder.length)];
    textF.attributedPlaceholder = attStr;
    textF.textAlignment = aligment;
    textF.textColor = [UIColor whiteColor];
    return textF;
}

+ (UITextField *)creatTextFieldWithPlaceHolder:(NSString *)placeHolder textAlignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor{
    UITextField * textfield = [[UITextField alloc]init];
    textfield.placeholder = placeHolder;
    textfield.textAlignment = alignment;
    textfield.textColor = textColor;
    return textfield;
}

+ (CGSize)getSize:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont*)font{
    CGSize sizeFirst = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
    return sizeFirst;
}
@end
