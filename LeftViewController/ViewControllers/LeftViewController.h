//
//  LeftViewController.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseViewController.h"

@interface LeftViewController : UIViewController
@property (nonatomic, strong) UITableView * tabview;
//当前被选位置  默认为1 首页
@property (nonatomic, assign) NSInteger index;
@end
