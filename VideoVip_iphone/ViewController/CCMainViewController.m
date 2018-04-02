//
//  CCMainViewController.m
//  VideoVip_iphone
//
//  Created by chenchao on 2018/3/30.
//  Copyright © 2018年 chenchao. All rights reserved.
//

#import "CCMainViewController.h"
#import "JSONKit.h"
#import "CCURLModel.h"
#import "CCHomeViewController.h"
#import "CCMainTableViewCell.h"

@interface CCMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *videoArray;
@property (nonatomic, strong) NSMutableArray *urlArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.videoArray = [NSMutableArray new];
    self.urlArray = [NSMutableArray new];
    
    //初始化视频厂家
    CCURLModel *model = [CCURLModel createTitle:@"腾讯视频" url:@"http://m.v.qq.com/"];
    [self.videoArray addObject:model];
    CCURLModel *model1 = [CCURLModel createTitle:@"爱奇艺视频" url:@"http://vip.iqiyi.com/"];
    [self.videoArray addObject:model1];
    CCURLModel *model2 = [CCURLModel createTitle:@"优酷" url:@"http://vip.youku.com/"];
    [self.videoArray addObject:model2];
    CCURLModel *model3 = [CCURLModel createTitle:@"芒果" url:@"https://www.mgtv.com/vip/"];
    [self.videoArray addObject:model3];
    
    //初始化接口解析地址
    NSError *error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"viplist" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:&error];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSLog(@"%@,error %@",dict, error);
    
    [self transformJsonToModel:dict[@"list"] changeArray:self.urlArray];
    
    [self.view addSubview:self.tableView];
    
    [self initVipURLs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)transformJsonToModel:(NSArray *)jsonArray changeArray:(NSMutableArray *)changeArray
{
    if ([jsonArray isKindOfClass:[NSArray class]]) {
        
        NSMutableArray *urlsArray = [NSMutableArray array];
        for (NSDictionary *dict in jsonArray) {
            CCURLModel *item = [CCURLModel createTitle:dict[@"name"] url:dict[@"url"]];
            [urlsArray addObject:item];
        }

        [changeArray removeAllObjects];
        [changeArray addObjectsFromArray:urlsArray];
    }
}

- (void)initVipURLs{
    
    NSURL *url = [NSURL URLWithString:@"https://iodefog.github.io/text/viplist.json"];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response,
                                               NSData * _Nullable data,
                                               NSError * _Nullable connectionError) {
                               if(!connectionError){
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                   NSLog(@"%@",dict);
                                   
                                   //初始化视频厂家
                                   [self transformJsonToModel:dict[@"platformlist"] changeArray:self.videoArray];
                                   //初始化接口解析地址
                                   [self transformJsonToModel:dict[@"list"]changeArray:self.urlArray];
                                   
                                   [self.tableView reloadData];
                                   
                               }else {
                                   NSLog(@"connectionError = %@",connectionError);
                               }
                           }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, KDeviceWidth, KDeviceHeight) style:UITableViewStylePlain];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.backgroundColor = [UIColor whiteColor];
        tableview.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
        tableview.layer.masksToBounds = NO;
        tableview.tableFooterView = [UIView new];
        [tableview registerClass:[CCMainTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableView = tableview;
    }
    return _tableView;
    
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.videoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CCMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    CCURLModel *model = self.videoArray[indexPath.row];
    cell.nameLabel.text = model.title;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    CCHomeViewController *view = [CCHomeViewController new];
    view.model = self.videoArray[indexPath.row];
    [self.navigationController pushViewController:view animated:YES];
    
}



@end
