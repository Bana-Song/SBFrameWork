//
//  CustomAlertView.h
//  TempTest
//
//  Created by pg on 16/6/14.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CustomAlertViewDelegate <NSObject>

-(void)didSelectedIndex:(NSInteger)index andAcion:(NSString *)action;

@end

@interface CustomAlertView : UIView

@property (nonatomic,strong) id<CustomAlertViewDelegate> sbDelegate;


-(void)showWithActionArray:(NSArray *)actions
                  andTitle:(NSString *)title
                andMessage:(NSString *)message;

@end
