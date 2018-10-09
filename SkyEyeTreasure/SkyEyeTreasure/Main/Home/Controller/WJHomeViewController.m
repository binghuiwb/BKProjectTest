//
//  WJHomeViewController.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/13.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJHomeViewController.h"
#import "WJHomeHeaderView.h"
#import "WJOrderViewController.h"
#import "WJHomeCell.h"
#import "WJHomeSearchViewController.h"
#import "WJUpdateNotificationView.h"
#import "WJHomeViewModel.h"
#import "WJHomeResultModel.h"

@interface WJHomeViewController ()<UITableViewDelegate>

@property (nonatomic, strong) KKTableViewDataSource *dataSource;
@property (nonatomic, strong) UITableView *homeTableView;

@property (nonatomic, strong) WJHomeViewModel *homeViewModel;
@property (nonatomic, strong) WJHomeResultModel *homeResultModel;


@end

@implementation WJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightButton:@[@"home_search"]];

    [self.view addSubview:self.homeTableView];
    
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    [self setUpHomeInfoViewModel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    
    
    [self.homeViewModel gainHomeClientInfo];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (self.homeResultModel.light.count == 3) {
        WJHomeHeaderView *homeHeader = [[WJHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 102)];
        
        [homeHeader reloadData:self.homeResultModel];
        
        homeHeader.delegateSignal = [RACSubject subject];
        
        @WJWeak(self);
        [homeHeader.delegateSignal subscribeNext:^(NSNumber *index) {
            @WJStrong(self);
            
            WJOrderLaterModel *orderLaterModel = self.homeResultModel.light[[index integerValue]];
            
            if ([orderLaterModel.num integerValue] > 0) {
                WJOrderViewController *orderViewController = [[WJOrderViewController alloc] init];
                
                [self.navigationController pushViewController:orderViewController animated:YES];
            } else {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"暂无迟到订单"];
            }
            
        }];
        
        return homeHeader;

    } else {
        return [[UIView alloc] init];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 102;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    WJOrderViewController *orderViewController = [[WJOrderViewController alloc] init];
    
    
    [self.navigationController pushViewController:orderViewController animated:YES];

}

- (void)doRightAction:(UIButton *)sender
{
    WJHomeSearchViewController *homeSearchVC = [[WJHomeSearchViewController alloc] init];
    
    [self.navigationController pushViewController:homeSearchVC animated:YES];
}

#pragma mark - 上拉刷新
- (void)headerRefreshOrderList
{
    self.homeViewModel.currentPage = 1;
    
    [self.homeViewModel gainHomeClientInfo];
}

#pragma mark - 下拉刷新
- (void)footerRefreshOrderList
{
    ++self.homeViewModel.currentPage;
    
    [self.homeViewModel gainHomeClientInfo];
}

- (void)setUpHomeInfoViewModel
{
    self.homeViewModel = [[WJHomeViewModel alloc] init];
    self.homeViewModel.currentPage = 1;
    
    self.homeViewModel.homeClientInfoSubject =[RACSubject subject];
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    [self.homeViewModel.homeClientInfoSubject subscribeNext:^(WJHomeResultModel *homeResultModel) {
        [SVProgressHUD dismiss];
        
        self.homeResultModel = homeResultModel;
        
        if (self.homeViewModel.currentPage == 1) {
            [self.homeTableView.mj_header endRefreshing];
            [self.dataSource.dataArray removeAllObjects];
        }
        
        
        if ([homeResultModel.totalPage integerValue] == self.homeViewModel.currentPage) {
            [self.homeTableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.homeTableView.mj_footer endRefreshing];
        }
        
        [self.dataSource.dataArray addObjectsFromArray:homeResultModel.orderList];
        [self.homeTableView reloadData];
        
    } error:^(NSError *error) {
        [SVProgressHUD dismiss];
        
        [self.homeTableView.mj_header endRefreshing];
        [self.homeTableView.mj_footer endRefreshing];
        
    }];

}


- (KKTableViewDataSource *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [[KKTableViewDataSource alloc] initWithItems:nil cellIdentifier:@"WJHomeCell" isNib:NO cellName:@"WJHomeCell" configureCellBlock:^(WJHomeCell *cell, NSIndexPath *indexPath, WJClientOrderInfoModel *clientInfoModel) {
//            cell.textLabel.text = item[@"name"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell reloadData:clientInfoModel];
        }];
        
        self.dataSource.dataArray = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (UITableView *)homeTableView {
    
    if (!_homeTableView) {
        
        _homeTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight-   kTabBarHeight) style:UITableViewStyleGrouped];
        
        _homeTableView.dataSource= self.dataSource;
        _homeTableView.delegate = self;
        _homeTableView.rowHeight = 90;
        _homeTableView.showsVerticalScrollIndicator = NO;
//        _homeTableView.tableFooterView = [[UIView alloc] init];
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeTableView.backgroundColor = [UIColor clearColor];
        
        _homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshOrderList)];
        _homeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshOrderList)];
        
        if ([_homeTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_homeTableView   setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            
        }
        
        if ([_homeTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_homeTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
            
        }
    }
    
    return _homeTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
