//
//  WJHomeViewModel.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/21.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJHomeViewModel : NSObject

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, copy) NSString *clientName;

@property (nonatomic, strong) RACSubject *homeClientInfoSubject;


- (void)gainHomeClientInfo;

@end
