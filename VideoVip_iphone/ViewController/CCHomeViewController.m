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
#import <Masonry.h>

@interface CCHomeViewController ()<WKNavigationDelegate,WKUIDelegate,UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
//@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation CCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.selectIndexPath = [NSIndexPath indexPathForRow:999 inSection:0];
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
    [self setTableViewAnimation:!self.tableView.alpha];
}

#pragma mark - common

- (void)setupWebView:(CCURLModel *)model{
    
    NSString *url = [self.webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];

    NSString *originUrl = [[url componentsSeparatedByString:@"url="] lastObject];

    if (![url hasPrefix:@"http"]) {
        return ;
    }

    NSString *finalUrl = [NSString stringWithFormat:@"%@%@", model.url?:@"",originUrl?:@""];
    NSLog(@"finalUrl = %@", finalUrl);

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:finalUrl]];
    [self.webView loadRequest:request];
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
    [self.view addSubview:self.tableView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(KDeviceWidth/2);
    }];
    
}

- (void)initNar{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backItemClick)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"vip" style:UIBarButtonItemStyleDone target:self action:@selector(vipItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setTableViewAnimation:(int)alpha{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.tableView.alpha = alpha;
    } completion:^(BOOL finished) {
    }];
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

#pragma mark - view

- (UITableView *)tableView {
    if (!_tableView) {
        
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(KDeviceWidth/2, 0.0, KDeviceWidth/2, KDeviceHeight) style:UITableViewStylePlain];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.backgroundColor = [UIColor whiteColor];
        tableview.tableFooterView = [UIView new];
        [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tableview.layer.cornerRadius = 10;
        tableview.layer.masksToBounds = YES;
        tableview.alpha = 0;
        
        _tableView = tableview;
    }
    return _tableView;
    
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.modelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    CCURLModel *model = self.modelsArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    
    if (self.selectIndexPath.row == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.selectIndexPath];
    if (oldCell) {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    self.selectIndexPath = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [self setupWebView:self.modelsArray[indexPath.row]];
    [self setTableViewAnimation:0];
}


@end
