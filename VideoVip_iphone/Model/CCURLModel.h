//
//  CCURLModel.h
//  VideoVip_iphone
//
//  Created by chenchao on 2018/3/30.
//  Copyright © 2018年 chenchao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface CCURLModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;

+ (instancetype)createTitle:(NSString *)title url:(NSString *)url;

@end
