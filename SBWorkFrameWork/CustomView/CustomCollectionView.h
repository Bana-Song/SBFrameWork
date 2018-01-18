//
//  CustomCollectionView.h
//  com.kexs.chaoxin
//
//  Created by pg on 16/10/17.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionView : UICollectionView


//设置回调
@property (nonatomic, strong)loadNewData pullBlock;
@property (nonatomic, strong)loadMoreData pushBlock;

/** 添加上下拉刷新控件 */
-(void)addRefreshControllerWithType:(TableRefrehType)type PullBack:(loadNewData)pullBlock and:(loadMoreData)pushBlock;
/** 停止刷新头部 */
-(void)endheaderRefresh;
/** 停止刷新底部 */
-(void)endfooterRefresh;

@end
