//
//  SBWebView.h
//  SBWebView
//
//  Created by pg on 16/7/8.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBWebView;

@protocol SBWebViewDelegate <NSObject>

@optional
    -(void)sbWebViewDidStartLoad:(SBWebView *)webView;
    -(void)sbWebViewDidFinshLoad:(SBWebView *)webView;
    -(void)sbWebView:(SBWebView *)webView didFailureWithError:(NSError *)error;


@end

@interface SBWebView : UIView

@property (nonatomic,strong) id <SBWebViewDelegate> delegate;

//是否还能返回上一层
@property (nonatomic,readonly) BOOL canBack;


//加载
- (void)loadRequest:(NSURLRequest *)request;
- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;

- (void)goBack;
- (void)goForward;
- (void)reload;
- (void)reloadFromOrigin;
- (void)stopLoading;

//和js交互
- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler;

//自适应
-(void)sizeScalesToFit:(BOOL)sizeToFit;

@end
