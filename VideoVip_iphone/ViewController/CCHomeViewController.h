//
//  CCHomeViewController.h
//  VideoVip_iphone
//
//  Created by chenchao on 2018/3/30.
//  Copyright © 2018年 chenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCURLModel.h"

@interface CCHomeViewController : UIViewController

@property (nonatomic, strong) CCURLModel *model;
@property (nonatomic, strong) NSMutableArray *modelsArray;

@end
