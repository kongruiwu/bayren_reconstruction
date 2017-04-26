//
//  HomeVideoTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoScrollView.h"
#import "ConfigHeader.h"
@interface HomeVideoTableViewCell : UITableViewCell

@property (nonatomic, strong) AutoScrollView * mainSc;
- (void)updateWithImages:(NSArray *)images titles:(NSArray *)titles;
@end
