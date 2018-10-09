//
//  WJHomeViewModel.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/21.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJHomeViewModel.h"
#import "WJHomeResultModel.h"

@implementation WJHomeViewModel

- (void)gainHomeClientInfo
{
    
//    _homeClientInfoSubject = [RACSubject subject];
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    
    [paramDic setValue:WJHomeClientInfoAction forKey:@"action"];
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
    if (![WJUtilityHelper isBlank:self.clientName]) {
        [dataDic setValue:self.clientName forKey:@"clientName"];
    }
    
    [dataDic setValue:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"currentPage"];
    
    [paramDic setValue:dataDic forKey:@"data"];
    
    [[WJNetWorkingManage sharedManager] AFNHttpRequestPOSTParameters:paramDic success:^(NSDictionary *responseDic) {
        if ([responseDic[WJCode] integerValue] == 200) {
            
            WJHomeResultModel *homeResultModel = [[WJHomeResultModel alloc] initWithDictionary:responseDic[WJResult] error:nil];
            
            [self.homeClientInfoSubject sendNext:homeResultModel];
            
        } else {
            [self.homeClientInfoSubject sendError:nil];
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseDic[WJMsg]];
        }
        
    } failure:^(NSError *error) {
        [self.homeClientInfoSubject sendError:error];

        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:WJNetWorkMessage];
    }];
}

@end
