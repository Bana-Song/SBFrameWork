//
//  CustomUIView.m
//  QWLProject
//
//  Created by pg on 16/3/11.
//  Copyright © 2016年 shiwenbin. All rights reserved.
//

#import "CustomUIView.h"

@implementation CustomUIView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


/*
 //-------        添加网络相关      --------/
 */
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
