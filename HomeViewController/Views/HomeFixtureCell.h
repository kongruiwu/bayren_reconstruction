//
//  HomeFixtureCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/28.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@protocol HomeFixtureDelegate <NSObject>

- (void)checkNewDetailWithNewsid:(NSNumber *)newsid;
- (void)checkPicDetailWithPicid:(NSNumber *)picid;

@end


@interface HomeFixtureCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray * fixtures;

@property (nonatomic, strong) UIView * groundView;
@property (nonatomic, strong) UIButton * leftBtn;
@property (nonatomic, strong) UIButton * rightBtn;
@property (nonatomic, strong) UICollectionView * fixtureView;

@property (nonatomic, assign) id<HomeFixtureDelegate> delegate;

- (void)updateWithFixtures:(NSArray *)fixtures andindex:(NSInteger)index;
@end
