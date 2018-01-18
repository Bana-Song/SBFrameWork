//
//  CustomCollectionVC.m
//  SBWorkFrameWork
//
//  Created by pg on 16/5/27.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "CustomCollectionVC.h"



@interface CustomCollectionVC ()


@end

@implementation CustomCollectionVC

static NSString * const reuseIdentifier = @"Cell";

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SBSharedMenu sharedIntance].sharedNav = (CustomNAVC *)self.navigationController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

//-------        添加刷新控件      --------/
-(void)addRefreshControllerWithType:(CustomTableRefrehType)type PullBack:(loadNewData)pullBlock and:(loadMoreData)pushBlock{
    self.pullBlock = pullBlock;
    self.pushBlock = pushBlock;
    switch (type) {
        case 0:
            break;
        case 1:
        {
            self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullMethod)];
        }
            break;
        case 2:{
            self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushMethod)];
        }
            break;
        case 3:{
            self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullMethod)];
            
            self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushMethod)];
        }
            break;
        default:
            break;
    }
    
}

-(void)beginLoad{
    [self.collectionView.mj_header beginRefreshing];
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
    [self.collectionView.mj_header endRefreshing];
}
-(void)endfooterRefresh{
    [self.collectionView.mj_footer endRefreshing];
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
