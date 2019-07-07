//
//  HttpUtil.m
//  XYTrainTicket
//
//  Created by apple on 2019/6/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HttpUtil.h"
#import <AFNetworking/AFNetworking.h>

@implementation HttpUtil
-(void)sendHttpRequest:(id<RequestObj>)request complate:(void (^)(NSError * _Nullable, NSDictionary * _Nullable))complate{
    if (request.method == HTTP_METHOD_GET) {
        [[AFHTTPSessionManager manager] GET:[request url] parameters:[request params] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            complate(nil,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            complate(error,nil);
        }];
    }
}

@end
