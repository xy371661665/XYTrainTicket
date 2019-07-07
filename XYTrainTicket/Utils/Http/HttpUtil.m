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

singleton_implementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSessionManager];
    }
    return self;
}

-(void)initSessionManager{
    AFHTTPSessionManager* manager =[AFHTTPSessionManager manager];
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"trainTicket" ofType:@"cer"];
    NSData* fileData =[[NSData alloc] initWithContentsOfFile:filePath];
    NSSet* fileSet = [NSSet setWithObject:fileData];
    AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:fileSet];
    policy.allowInvalidCertificates = YES;
    manager.securityPolicy = policy;
}

-(void)sendHttpRequest:(id<RequestObj>)request complate:(void (^)(NSError * _Nullable, NSDictionary * _Nullable))complate{
    
    [[AFHTTPSessionManager manager].requestSerializer setValue:@"no-store" forHTTPHeaderField:@"Cache-Control"];
    
    if (request.method == HTTP_METHOD_GET) {
        [[AFHTTPSessionManager manager] GET:[request url] parameters:[request params] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            complate(nil,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            complate(error,nil);
        }];
    }
}

@end
