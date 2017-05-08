//
//  PhotoDetailCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoDetailCell.h"

@implementation PhotoDetailCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    
    UITapGestureRecognizer * signleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(signleTapAction)];
    [self addGestureRecognizer:signleTap];
    
    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapAction)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    
    [signleTap requireGestureRecognizerToFail:doubleTap];
    
    self.photoView = [[PhotoScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.photoView];
}

- (void)signleTapAction{
    if ([self.delegate respondsToSelector:@selector(singleClick)]) {
        [self.delegate singleClick];
    }
    
}
- (void)doubleTapAction{
    [self.photoView doubleTapAction];
}
- (void)layoutSubviews{
    [super layoutSubviews];
}
- (void)updateWithPic:(NSString *)pic{
    [self.photoView updateImageviewWithurl:pic];
}
@end
