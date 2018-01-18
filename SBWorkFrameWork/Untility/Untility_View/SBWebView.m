//
//  SBWebView.m
//  SBWebView
//
//  Created by pg on 16/7/8.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "SBWebView.h"
#import <WebKit/WebKit.h>

@interface SBWebView()<WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate>

@property (nonatomic,strong) WKWebView *webView;//NS_CLASS_AVAILABLE(10_10, 8_0)
@property (nonatomic,strong) UIWebView *myWebView;


@property (nonatomic, strong) NSURLRequest *originRequest; //最初的请求
@property (nonatomic, strong) NSURLRequest *currentRequest;//当前请求

@property (nonatomic,assign) BOOL isOldWebView;

@end

@implementation SBWebView

-(BOOL)canBack{
    return _webView.canGoBack;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            _isOldWebView = NO;
        }else{
            _isOldWebView = YES;
        }
        if (_isOldWebView) {
            _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame. size.width, frame.size.height)];
            _myWebView.delegate = self;
            [self addSubview:_myWebView];
        }else{
            _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, frame. size.width, frame.size.height)];
            _webView.UIDelegate = self;
            _webView.navigationDelegate = self;
            [self addSubview:_webView];
        }
    }
    return self;
}

-(void)loadRequest:(NSURLRequest *)request{
    
    self.originRequest = request;
    self.currentRequest = request;
    
    if (_isOldWebView) {
        [_myWebView loadRequest:request];
        return;
    }
    [_webView loadRequest:request];
}

-(void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL{
    if (_isOldWebView) {
        [_myWebView loadHTMLString:string baseURL:baseURL];
        return;
    }
    [_webView loadHTMLString:string baseURL:baseURL];
}

-(void)goBack{
    if (_isOldWebView) {
        [_myWebView goBack];
        return;
    }
    [_webView goBack];
}

-(void)goForward{
    if (_isOldWebView) {
        [_myWebView goForward];
        return;
    }
    [_webView goForward];
}

-(void)reload {
    if (_isOldWebView) {
        [_myWebView reload];
        return;
    }
    [_webView reload];
}
-(void)reloadFromOrigin{
    if (_isOldWebView) {
        if(self.originRequest)
        {
            [self evaluateJavaScript:[NSString stringWithFormat:@"window.location.replace('%@')",self.originRequest.URL.absoluteString] completionHandler:nil];
        }
        return;
    }
    [_webView reloadFromOrigin];
}
-(void)stopLoading{
    [_webView stopLoading];
}

#pragma mark -- WKWebViewDelegate
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    if([self.delegate respondsToSelector:@selector(sbWebViewDidStartLoad:)]){
        [self.delegate sbWebViewDidStartLoad:self];
    }
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if([self.delegate respondsToSelector:@selector(sbWebViewDidFinshLoad:)]){
        [self.delegate sbWebViewDidFinshLoad:self];
    }
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    if([self.delegate respondsToSelector:@selector(sbWebView:didFailureWithError:)]){
        [self.delegate sbWebView:self didFailureWithError:error];
    }
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    if([self.delegate respondsToSelector:@selector(sbWebView:didFailureWithError:)]){
        [self.delegate sbWebView:self didFailureWithError:error];
    }
}

#pragma mark -- UIWebViewDelegate 
-(void)webViewDidStartLoad:(UIWebView *)webView{
    if([self.delegate respondsToSelector:@selector(sbWebViewDidStartLoad:)]){
        [self.delegate sbWebViewDidStartLoad:self];
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if(self.originRequest == nil)
    {
        self.originRequest = webView.request;
    }

    if([self.delegate respondsToSelector:@selector(sbWebViewDidFinshLoad:)]){
        [self.delegate sbWebViewDidFinshLoad:self];
    }
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if([self.delegate respondsToSelector:@selector(sbWebView:didFailureWithError:)]){
        [self.delegate sbWebView:self didFailureWithError:error];
    }
}

#pragma  mark -- 其他

-(void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler{
    if(_isOldWebView)
    {
        NSString* result = [_myWebView stringByEvaluatingJavaScriptFromString:javaScriptString];
        if(completionHandler)
        {
            completionHandler(result,nil);
        }
        return;
    }
    [_webView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
}

-(NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)javaScriptString
{
    if(_isOldWebView)
    {
        NSString* result = [_myWebView stringByEvaluatingJavaScriptFromString:javaScriptString];
        return result;
    }
    else
    {
        __block NSString* result = nil;
        __block BOOL isExecuted = NO;
        [_webView evaluateJavaScript:javaScriptString completionHandler:^(id obj, NSError *error) {
            result = obj;
            isExecuted = YES;
        }];
        
        while (isExecuted == NO) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        return result;
    }
}

-(void)sizeScalesToFit:(BOOL)sizeToFit{
        NSString *jScript = @"var meta = document.createElement('meta'); \
        meta.name = 'viewport'; \
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'; \
        var head = document.getElementsByTagName('head')[0];\
        head.appendChild(meta);";
        
        if(sizeToFit)
        {
            WKUserScript *wkUScript = [[NSClassFromString(@"WKUserScript") alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
            [_webView.configuration.userContentController addUserScript:wkUScript];
        }
        else
        {
            NSMutableArray* array = [NSMutableArray arrayWithArray:_webView.configuration.userContentController.userScripts];
            for (WKUserScript *wkUScript in array)
            {
                if([wkUScript.source isEqual:jScript])
                {
                    [array removeObject:wkUScript];
                    break;
                }
            }
            for (WKUserScript *wkUScript in array)
            {
                [_webView.configuration.userContentController addUserScript:wkUScript];
            }
        }
}




@end
