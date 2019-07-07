//
//  GetVerifyImage.m
//  XYTrainTicket
//
//  Created by apple on 2019/6/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "GetVerifyImage.h"

@implementation GetVerifyImage

#pragma mark -- RequestObj
-(NSString *)url{
    return @"https://kyfw.12306.cn/passport/captcha/captcha-image64";
}

-(HTTP_METHOD)method{
    return HTTP_METHOD_GET;
}

-(NSDictionary *)params{
    return @{
             @"login_site":@"E",
             @"module":@"login",
             @"rand":@"sjrand",
             @"":@(time(NULL))
             };
}

@end
