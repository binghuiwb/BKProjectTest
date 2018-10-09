//
//  WJHomeSearchViewController.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/14.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJHomeSearchViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "WJHomeCell.h"
#import "WJHomeResultModel.h"



@interface WJHomeSearchViewController ()
<UISearchBarDelegate,UITableViewDelegate>

@property (nonatomic, strong) UITableView *homeSearchTableView;
@property (nonatomic, strong) KKTableViewDataSource *dataSource;

//数据源
@property (strong,nonatomic) NSMutableArray  *dataList;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, assign) NSInteger currentPage;


@end

@implementation WJHomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBarButtonItem];
    
    [self.view addSubview:self.homeSearchTableView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.searchBar becomeFirstResponder];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.searchBar resignFirstResponder];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)setBarButtonItem
{
    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, kScreenWidth, 30)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(titleView.frame) - 30, 30)];
    searchBar.placeholder = @"请输入客户名称";
    searchBar.delegate = self;
    searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor]];
    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"home_searchBack"] forState:UIControlStateNormal];
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    searchField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_search"]];
    searchField.textColor = [UIColor whiteColor];
    searchField.font = FONT(15);
    [searchField setValue:[UIColor hex_colorWithHex:@"#e5e4e4"] forKeyPath:@"_placeholderLabel.textColor"];
    
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setHidesBackButton:YES];

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = FONT(15);
    self.searchBar.frame = CGRectMake(20, 0, kScreenWidth - 30, 30);
    
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    self.searchBar.frame = CGRectMake(20, 0, kScreenWidth - 50, 30);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}                     

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([WJUtilityHelper isBlank:searchText]) {
        [self.dataSource.dataArray removeAllObjects];
        [self.homeSearchTableView reloadData];
    } else {
        [self gainHomeClientInfo:searchText];
    }
    
}

#pragma mark - 下拉刷新
- (void)footerRefreshOrderList
{
    ++self.currentPage;
    
    [self gainHomeClientInfo:nil];
}



- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)gainHomeClientInfo:(NSString *)clientName
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    
    [paramDic setValue:WJHomeClientInfoAction forKey:@"action"];
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
    if (![WJUtilityHelper isBlank:clientName]) {
        [dataDic setValue:clientName forKey:@"clientName"];
    }
    
    [dataDic setValue:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"currentPage"];
    
    [paramDic setValue:dataDic forKey:@"data"];
    
    
    [[WJNetWorkingManage sharedManager] AFNHttpRequestPOSTParameters:paramDic success:^(NSDictionary *responseDic) {
        
        if ([responseDic[WJCode] integerValue] == 200) {
            
            WJHomeResultModel *homeResultModel = [[WJHomeResultModel alloc] initWithDictionary:responseDic[WJResult] error:nil];
            
            self.dataSource.dataArray = [homeResultModel.orderList mutableCopy];
            [self.homeSearchTableView reloadData];
            
        } else {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseDic[WJMsg]];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:WJNetWorkMessage];
    }];
}


- (KKTableViewDataSource *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [[KKTableViewDataSource alloc] initWithItems:nil cellIdentifier:@"WJHomeCell" isNib:NO cellName:@"WJHomeCell" configureCellBlock:^(WJHomeCell *cell, NSIndexPath *indexPath, WJClientOrderInfoModel *clientInfoModel) {

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell reloadData:clientInfoModel];
            
        }];
    }
    
    return _dataSource;
}

- (UITableView *)homeSearchTableView {
    
    if (!_homeSearchTableView) {
        
        _homeSearchTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight-   kTabBarHeight) style:UITableViewStylePlain];
        
        _homeSearchTableView.dataSource= self.dataSource;
        _homeSearchTableView.delegate = self;
        _homeSearchTableView.rowHeight = 90;
        _homeSearchTableView.showsVerticalScrollIndicator = NO;
        _homeSearchTableView.tableFooterView = [[UIView alloc] init];
        _homeSearchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeSearchTableView.backgroundColor = [UIColor clearColor];
        
        _homeSearchTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshOrderList)];
        
        if ([_homeSearchTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_homeSearchTableView   setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            
        }
        
        if ([_homeSearchTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_homeSearchTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
            
        }
    }
    
    return _homeSearchTableView;
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
