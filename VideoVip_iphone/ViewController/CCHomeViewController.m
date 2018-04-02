//
//  CCHomeViewController.m
//  VideoVip_iphone
//
//  Created by chenchao on 2018/3/30.
//  Copyright © 2018年 chenchao. All rights reserved.
//

#import "CCHomeViewController.h"
#import <WebKit/WebKit.h>
#import "JSONKit.h"

@interface CCHomeViewController ()<WKNavigationDelegate,WKUIDelegate,UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
//@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, strong) CCURLModel *vipmodel;
@property (nonatomic, strong) UIView *vipsView;

@end

@implementation CCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    [self initNar];
    [self initSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action

- (void)backItemClick{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)vipItemClick{
    
    for (UIView *view in [self.view subviews]) {
        if (self.vipsView == view) {
            [view removeFromSuperview];
            return;
        }
    }
    
    [self.view addSubview:self.vipsView];
    
//    self.vipmodel = [CCURLModel createTitle:@"万能接口3" url:@"http://vip.jlsprh.com/index.php?url="];
//
//    NSString *url = [self.webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
//
//    NSString *originUrl = [[url componentsSeparatedByString:@"url="] lastObject];
//
//    if (![url hasPrefix:@"http"]) {
//        return ;
//    }
//
//    NSString *finalUrl = [NSString stringWithFormat:@"%@%@", self.vipmodel.url?:@"",originUrl?:@""];
//    NSLog(@"finalUrl = %@", finalUrl);
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:finalUrl]];
//    [self.webView loadRequest:request];
}



#pragma mark - view

- (UIView *)vipsView{
    
    if (!_vipsView) {
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        
        _vipsView = view;
    }
    
    return _vipsView;
}

#pragma mark - common

- (void)setupVipsView{
    
}

- (void)initSubView{
    
    //    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    // 启动驱动，否则flash不可播
    //    configuration.preferences.plugInsEnabled = YES;
    //    configuration.preferences.javaEnabled = YES;
    
    //    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:configuration];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //    self.webView.UIDelegate = self;
    //    self.webView.navigationDelegate = self;
    self.webView.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.model.url]];
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    
    [self setupVipsView];
}

- (void)initNar{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backItemClick)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"vip" style:UIBarButtonItemStyleDone target:self action:@selector(vipItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
}



#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *requestUrl = navigationAction.request.URL.absoluteString;
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    if (navigationAction.request.URL.absoluteString.length > 0) {
        
        // 拦截广告
        if ([requestUrl containsString:@"ynjczy.net"] ||
            [requestUrl containsString:@"ylbdtg.com"] ||
            [requestUrl containsString:@"662820.com"] ||
            [requestUrl containsString:@"api.vparse.org"] ||
            [requestUrl containsString:@"hyysvip.duapp.com"]||
            [requestUrl containsString:@"f.qcwzx.net.cn"]
            ) {
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
        NSLog(@"request.URL.absoluteString = %@",requestUrl);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *requestUrl = request.URL.absoluteString;
    if ([requestUrl containsString:@"ynjczy.net"] ||
        [requestUrl containsString:@"ylbdtg.com"] ||
        [requestUrl containsString:@"662820.com"] ||
        [requestUrl containsString:@"api.vparse.org"] ||
        [requestUrl containsString:@"hyysvip.duapp.com"]||
        [requestUrl containsString:@"f.qcwzx.net.cn"]
        ) {
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    ;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    ;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    ;
}

@end
