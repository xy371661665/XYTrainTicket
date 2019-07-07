//
//  HttpUtil.h
//  XYTrainTicket
//
//  Created by apple on 2019/6/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestObj.h"

NS_ASSUME_NONNULL_BEGIN


@interface HttpUtil : NSObject

singleton_interface

-(void)sendHttpRequest:(id<RequestObj>)request complate:(void (^)(NSError* _Nullable error,NSDictionary* _Nullable response))complate;


@end

NS_ASSUME_NONNULL_END
