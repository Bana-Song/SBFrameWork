//
//  NetWorkListen.m
//  TempTest
//
//  Created by pg on 16/6/21.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "NetWorkListen.h"
#import "Reachability.h"
#import "TSMessage.h"
#import "TSMessageView.h"


@interface NetWorkListen(){
 Reachability *hostReach;
}
@end

@implementation NetWorkListen

+(id)sharedIntance{
    static NetWorkListen *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedManager == nil) {
            sharedManager = [[NetWorkListen alloc]init];
        }
    });
    return sharedManager;
}


-(void)addNetWorkListener{
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object: nil];
    
    hostReach = [Reachability reachabilityWithHostName:@"www.apple.com"];//可以以多种形式初始化
    [hostReach startNotifier];  //开始监听,会启动一个run loop
    
   // [self updateInterfaceWithReachability: hostReach];
}


- (void)reachabilityChanged:(NSNotification *)note

{
    [self updateInterfaceWithReachability: hostReach];
}


//处理连接改变后的情况
- (void) updateInterfaceWithReachability: (Reachability*) curReach

{
    //对连接改变做出响应的处理动作。
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if(status == ReachableViaWWAN)
    {
        [self.delegate netWorkListener:1];
        [TSMessage showNotificationWithTitle:@"提示" subtitle:@"请查看你的网络" type:TSMessageNotificationTypeWarning];
    }
    else if(status == ReachableViaWiFi)
    {
        [self.delegate netWorkListener:2];
        [TSMessage showNotificationWithTitle:@"提示" subtitle:@"请查看你的网络" type:TSMessageNotificationTypeWarning];
    }else
    {
        [self.delegate netWorkListener:0];
        [TSMessage showNotificationWithTitle:@"提示" subtitle:@"请查看你的网络" type:TSMessageNotificationTypeWarning];
    }
    
}

-(void)removeNetWorkListener{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end
