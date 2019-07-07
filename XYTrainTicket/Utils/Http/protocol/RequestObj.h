//
//  RequestObj.h
//  XYTrainTicket
//
//  Created by apple on 2019/6/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HTTP_METHOD) {
    HTTP_METHOD_GET,
    HTTP_METHOD_POST
};

NS_ASSUME_NONNULL_BEGIN

@protocol RequestObj <NSObject>


/**
 返回请求的url

 @return 请求的url
 */
-(NSString*)url;

/**
 请求的方法

 @return 返回http请求的方法
 */
-(HTTP_METHOD)method;

/**
 获取请求参数

 @return 返回请求的参数
 */
-(NSDictionary*)params;

@optional

/**
 获取请求头

 @return 返回请求头
 */
-(NSDictionary*)headers;


@end

NS_ASSUME_NONNULL_END
