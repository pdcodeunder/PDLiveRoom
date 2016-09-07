//
//  PDTableViewModel.h
//  PDLiveRoom
//
//  Created by 彭懂 on 16/9/6.
//  Copyright © 2016年 彭懂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef UITableViewCell *(^PDTableViewCellBlock)(UIColor *color, id model);
@interface PDTableViewDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

/**
 *  设置数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

/**
 *  设置cell配置block
 */
@property (nonatomic, copy) PDTableViewCellBlock tableViewCell;

/**
 *  设置是否是按组还是row  yes : row   no : section  默认是yes
 */
@property (nonatomic, assign) BOOL isRow;

/**
 *  设置tableviewcell的高度
 */
@property (nonatomic, assign) CGFloat rowHeight;

/**
 *  设置tableview头部view  默认无
 */
@property (nonatomic, strong) UIView *headView;


@end
