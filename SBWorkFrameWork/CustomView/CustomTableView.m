//
//  CustomTableView.m
//  QWLProject
//
//  Created by pg on 16/3/11.
//  Copyright © 2016年 shiwenbin. All rights reserved.
//

#import "CustomTableView.h"
@interface CustomTableView()
@end
@implementation CustomTableView

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
        }
            break;
        case 2:{
            self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushMethod)];
        }
            break;
        case 3:{
            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullMethod)];
            
            self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushMethod)];
        }
            break;
        default:
            break;
    }
    
}

-(void)beginHeaderRefresh{
    [self.mj_header beginRefreshing];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        [_touchDelegate respondsToSelector:@selector(tableView:touchesBegan:withEvent:)])
    {
        [_touchDelegate tableView:self touchesBegan:touches withEvent:event];
    }
}
@end
