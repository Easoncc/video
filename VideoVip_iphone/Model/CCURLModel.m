//
//  CCURLModel.m
//  VideoVip_iphone
//
//  Created by chenchao on 2018/3/30.
//  Copyright © 2018年 chenchao. All rights reserved.
//

#import "CCURLModel.h"

@implementation CCURLModel

+ (instancetype)createTitle:(NSString *)title url:(NSString *)url{
    CCURLModel *model = [[CCURLModel alloc] init];
    model.title = title;
    model.url = url;
    return model;
}

@end
