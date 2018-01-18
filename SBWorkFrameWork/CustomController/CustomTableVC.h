//
//  CustomTableVC.h
//  QWLProject
//
//  Created by pg on 16/3/11.
//  Copyright © 2016年 shiwenbin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    TDefault = 0, //没有刷新功能
    TUpPull, //上拉刷新
    TDownPull, //下拉刷新
    TAllPull //上下拉刷新
}TableRefrehType;



typedef void (^loadNewData) (void);
typedef void (^loadMoreData) (void);

@interface CustomTableVC : UITableViewController
//设置回调
@property (nonatomic, strong)loadNewData pullBlock;
@property (nonatomic, strong)loadMoreData pushBlock;

/** 添加上下拉刷新控件 */
-(void)addRefreshControllerWithType:(TableRefrehType)type PullBack:(loadNewData)pullBlock and:(loadMoreData)pushBlock;
/** 停止刷新头部 */
-(void)endheaderRefresh;
/** 停止刷新底部 */
-(void)endfooterRefresh;

//网络请求
-(void)SBRequestWithParams:(NSDictionary *)params //参数
                andApiName:(NSString *)apiName //api名称
                andBaseURL:(NSString *)serverURL //服务器地址
                  andIsGet:(BOOL)isGet    //get还是post请求方法
                andNeedHUD:(BOOL)isNeedHUD  //是否需要转圈提示
        andHUDLoadingTitle:(NSString *)loadTitle    //转圈提示文字
         andHUDSucessTitle:(NSString *)sucessTitle  //转圈结束成功提示文字
           andHUDFailTitle:(NSString *)failTitle    //转圈结束失败提示文字
              andOtherFlag:(NSString *)flag; //其它标志（用来处理特殊情况）

//请求成功
-(void)SBRequestSucess:(id)responseObject andApiName:(NSString *)ApiName andFlag:(NSString *)flag;

//请求失败
-(void)SBRequestFail:(id)error andApiName:(NSString *)ApiName andFlag:(NSString *)flag;


@end
