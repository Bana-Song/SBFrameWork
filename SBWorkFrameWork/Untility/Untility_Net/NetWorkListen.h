//
//  NetWorkListen.h
//  TempTest
//
//  Created by pg on 16/6/21.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol NetWorkListenDelegate <NSObject>


/**
    网络监听回调
    0.无网络
    1.流量
    2.wifi
 */
-(void)netWorkListener:(NSInteger)netType;

@end

@interface NetWorkListen : NSObject

@property (nonatomic,strong) id <NetWorkListenDelegate> delegate;

+(id)sharedIntance;

/** 添加监听 */
-(void)addNetWorkListener;

/** 移除监听 */
-(void)removeNetWorkListener;





@end
