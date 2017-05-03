//
//  HomeTeamerTableViewCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTeamerView.h"
#import "HomeTeamerModel.h"
@protocol HomeTeamerDelegate <NSObject>

- (void)homeTeamerClickWithTeamerid:(NSNumber *)teamerid isTeamer:(BOOL)rec;

@end


@interface HomeTeamerTableViewCell : UITableViewCell

@property (nonatomic, strong) HomeTeamerView * teamerOne;
@property (nonatomic, strong) HomeTeamerView * teamerTwo;
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, assign) id<HomeTeamerDelegate> delegate;
- (void)updateWithArrays:(NSArray<HomeTeamerModel *> *)arr;
@end
