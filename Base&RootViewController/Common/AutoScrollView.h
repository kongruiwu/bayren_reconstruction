//
//  AutoScrollView.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/21.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "BYPageControl.h"
@interface AutoScrollView : UIView

@property (nonatomic, assign) float with;

@property (nonatomic, strong) BYPageControl * pageControl;
/**轮播图描述*/
@property (nonatomic, strong) NSArray * descs;
/**轮播图资源*/
@property (nonatomic, strong) NSArray * images;

- (void)updateWithImages:(NSArray *)imgArray descs:(NSArray *)descs;
@end
