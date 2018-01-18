//
//  CustomTableVC.m
//  QWLProject
//
//  Created by pg on 16/3/11.
//  Copyright © 2016年 shiwenbin. All rights reserved.
//

#import "CustomTableVC.h"
@interface CustomTableVC ()
@end

@implementation CustomTableVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SBSharedMenu sharedIntance].sharedNav = (CustomNAVC *)self.navigationController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


//-------        添加刷新控件      --------/
-(void)addRefreshControllerWithType:(TableRefrehType)type PullBack:(loadNewData)pullBlock and:(loadMoreData)pushBlock{
    self.pullBlock = pullBlock;
    self.pushBlock = pushBlock;
    switch (type) {
        case 0:
            break;
        case 1:
        {
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullMethod)];
        }
            break;
        case 2:{
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushMethod)];
        }
            break;
        case 3:{
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullMethod)];
            
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushMethod)];
        }
            break;
        default:
            break;
    }
    
}

-(void)beginHeaderRelaod{
    [self.tableView.mj_header beginRefreshing];
}

-(void)pullMethod{
    self.pullBlock();
    [self endheaderRefresh];
}
-(void)pushMethod{
    self.pushBlock();
    [self endfooterRefresh];
}
-(void)endheaderRefresh{
    [self.tableView.mj_header endRefreshing];
}
-(void)endfooterRefresh{
    [self.tableView.mj_footer endRefreshing];
}


//-------        添加网络相关      --------/
-(void)SBRequestWithParams:(NSDictionary *)params andApiName:(NSString *)apiName andBaseURL:(NSString *)serverURL andIsGet:(BOOL)isGet andNeedHUD:(BOOL)isNeedHUD andHUDLoadingTitle:(NSString *)loadTitle andHUDSucessTitle:(NSString *)sucessTitle andHUDFailTitle:(NSString *)failTitle andOtherFlag:(NSString *)flag{
    SBNetWork *netWork = [[SBNetWork alloc] init];
    [netWork SBRequestWithParams:params andApiName:apiName andBaseURL:serverURL andIsGet:isGet andNeedHUD:isNeedHUD andHUDLoadingTitle:loadTitle andHUDSucessTitle:sucessTitle andHUDFailTitle:failTitle netSucess:^(NSString *ApiName, id responseObject, NSString *otherFlag) {
        [self SBRequestSucess:responseObject andApiName:ApiName andFlag:otherFlag];
    } netFail:^(NSString *ApiName, id responseObject, NSString *otherFlag) {
        [self SBRequestFail:responseObject andApiName:ApiName andFlag:otherFlag];
    } andOtherFlag:flag];
}

-(void)SBRequestSucess:(id)responseObject andApiName:(NSString *)ApiName andFlag:(NSString *)flag{
    
}

-(void)SBRequestFail:(id)error andApiName:(NSString *)ApiName andFlag:(NSString *)flag{
    
}

@end
