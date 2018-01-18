//
//  CustomCollectionView.m
//  com.kexs.chaoxin
//
//  Created by pg on 16/10/17.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "CustomCollectionView.h"

@implementation CustomCollectionView


//-------        添加刷新控件      --------/
-(void)addRefreshControllerWithType:(TableRefrehType)type PullBack:(loadNewData)pullBlock and:(loadMoreData)pushBlock{
    self.pullBlock = pullBlock;
    self.pushBlock = pushBlock;
    switch (type) {
        case 0:
            break;
        case 1:
        {
            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullMethod)];
            [self.mj_header beginRefreshing];
        }
            break;
        case 2:{
            self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushMethod)];
        }
            break;
        case 3:{
            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullMethod)];
            [self.mj_header beginRefreshing];
            
            self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushMethod)];
        }
            break;
        default:
            break;
    }
    
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
    [self.mj_header endRefreshing];
}
-(void)endfooterRefresh{
    [self.mj_footer endRefreshing];
}


@end
