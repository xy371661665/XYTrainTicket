//
//  XYCover.m
//  XYTrainTicket
//
//  Created by apple on 2019/7/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "XYCover.h"

@implementation XYCover

+(NSDictionary *)point2Dictionary:(CGPoint)point{
    return @{
             @"x":@(point.x),
             @"y":@(point.y)
             };
}

+(CGPoint)Dictionary2Point:(NSDictionary *)dic{
    CGFloat x = [[dic objectForKey:@"x"] floatValue];
    CGFloat y = [[dic objectForKey:@"y"] floatValue];
    return NSMakePoint(x, y);
}

@end
