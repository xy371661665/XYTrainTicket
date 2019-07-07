//
//  XYCover.h
//  XYTrainTicket
//
//  Created by apple on 2019/7/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYCover : NSObject

+(NSDictionary*)point2Dictionary:(CGPoint)point;
+(CGPoint)Dictionary2Point:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
