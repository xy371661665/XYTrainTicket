//
//  CheckVerify.m
//  XYTrainTicket
//
//  Created by apple on 2019/7/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CheckVerify.h"

@implementation CheckVerify

-(NSString *)url{
    return @"https://kyfw.12306.cn/passport/captcha/captcha-check";
}

-(HTTP_METHOD)method{
    return HTTP_METHOD_GET;
}

-(NSDictionary *)params{
    return @{
             @"anwser":self.anwser,
             @"rand":@"sjrand",
             @"login_site":@"E"
             };
}

@end
