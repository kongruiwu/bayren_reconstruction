//
//  NavigationProtocol.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/7.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModel.h"
@protocol NavigationProtocol <NSObject>
- (void)pushViewModel:(ViewModel *)viewModel animated:(BOOL)animated;

- (void)popViewModelAnimated:(BOOL)animated;
@end
