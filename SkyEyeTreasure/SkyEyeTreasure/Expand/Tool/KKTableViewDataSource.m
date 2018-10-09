//
//  KKTableViewDataSource.m
//  KakaPersonal
//
//  Created by 王兵 on 2017/3/16.
//  Copyright © 2017年 kakayun. All rights reserved.
//

#import "KKTableViewDataSource.h"

@interface KKTableViewDataSource () {
    BOOL _kIsNib;
    NSString *_kcellName;
}

@property (nonatomic, copy) NSString *cellIdentifier;

@end

@implementation KKTableViewDataSource



- (id)initWithItems:(NSMutableArray *)items
     cellIdentifier:(NSString *)cellIdentifier isNib:(BOOL)isNib cellName:(NSString *)cellName configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock {
    self = [super init];
    if (self) {
        self.dataArray = items;
        self.cellIdentifier = cellIdentifier;
        _kIsNib = isNib;
        _kcellName = cellName;
        self.configureCellBlock = [configureCellBlock copy];
    }
    return self;
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Class cellClass = NSClassFromString(_kcellName);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    if (cell == nil) {
        // 加入使用nib的方法
        if (_kIsNib) {
            cell = [[[NSBundle mainBundle] loadNibNamed:_kcellName owner:nil options:nil] lastObject];
            
        } else {
            cell = [[[cellClass class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
            
        }
    }
    
    id item = self.dataArray[indexPath.row];
    self.configureCellBlock(cell, indexPath, item);
    return cell;
}




@end
