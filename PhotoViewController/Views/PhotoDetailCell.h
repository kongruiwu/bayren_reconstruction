//
//  PhotoDetailCell.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "PhotoScrollView.h"
@protocol PhotoDetailCellDelegate <NSObject>

- (void)singleClick;

@end


@interface PhotoDetailCell : UICollectionViewCell<UIGestureRecognizerDelegate>




@property (nonatomic, strong) PhotoScrollView * photoView;

@property (nonatomic, assign) id<PhotoDetailCellDelegate> delegate;

- (void)updateWithPic:(NSString *)pic;
@end
