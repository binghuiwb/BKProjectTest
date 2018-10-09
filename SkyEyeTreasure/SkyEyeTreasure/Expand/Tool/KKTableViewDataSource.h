//
//  KKTableViewDataSource.h
//  KakaPersonal
//
//  Created by 王兵 on 2017/3/16.
//  Copyright © 2017年 kakayun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id indexPath, id item);


@interface KKTableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;


- (id)initWithItems:(NSMutableArray *)items
     cellIdentifier:(NSString *)cellIdentifier isNib:(BOOL)isNib cellName:(NSString *)cellName configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;


@end
