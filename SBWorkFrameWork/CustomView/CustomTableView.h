//
//  CustomTableView.h
//  QWLProject
//
//  Created by pg on 16/3/11.
//  Copyright © 2016年 shiwenbin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  重写UITableView的touch相关的方法，然后通过委托的方式提供给外部对象使用。首先定义Delegate：
 */
@protocol TouchTableViewDelegate <NSObject>

@optional
/**
 *  重写touch方法时必须把父类实现方法写上，否则UITableViewCell将无法正常工作。所有的改写工作如下所示，新的TableView类具有touch事件响应了。
 */
- (void)tableView:(UITableView *)tableView
     touchesBegan:(NSSet *)touches
        withEvent:(UIEvent *)event;
@end

@interface CustomTableView : UITableView


//设置回调
@property (nonatomic, strong)loadNewData pullBlock;
@property (nonatomic, strong)loadMoreData pushBlock;

/** 添加上下拉刷新控件 */
-(void)addRefreshControllerWithType:(TableRefrehType)type PullBack:(loadNewData)pullBlock and:(loadMoreData)pushBlock;
/** 停止刷新头部 */
-(void)endheaderRefresh;
/** 停止刷新底部 */
-(void)endfooterRefresh;


//点击
@property (nonatomic,weak) id<TouchTableViewDelegate> touchDelegate;


@end
