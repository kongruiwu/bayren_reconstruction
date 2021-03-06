//
//  BYFactory.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BYFactory : NSObject

+ (UITableView *)creatTabviewWithFrame:(CGRect)frame style:(UITableViewStyle)style;

+ (UILabel *)creatLabelWithText:(NSString *)title fontValue:(float)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment;

+ (UIButton *)creatButtonWithTitle:(NSString *)title backGroundColor:(UIColor *)groundColor textColor:(UIColor *)textColor textSize:(float)fontValue;
+ (UIButton *)creatButtonWithNormalImage:(NSString *)normalImage selectImage:(NSString *)selectImage;

+ (UIImageView *)creatArrowImage;

+ (UIImageView *)creatImageViewWithImage:(NSString *)imageName;

+ (UIView *)creatLineView;

+ (UIView *)creatViewWithColor:(UIColor *)color;

+ (UITextField *)creatLoginTextFieldWithPlaceHolder:(NSString *)placeHolder cornerRadius:(CGFloat)cornerRadius textFont:(CGFloat)font textAlignment:(NSTextAlignment)aligment;

+ (UITextField *)creatTextFieldWithPlaceHolder:(NSString *)placeHolder textAlignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor;

+ (CGSize)getSize:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont*)font;
@end
