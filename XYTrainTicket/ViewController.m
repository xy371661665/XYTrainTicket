//
//  ViewController.m
//  XYTrainTicket
//
//  Created by apple on 2019/6/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ViewController.h"
#import "HttpUtil.h"
#import "GetVerifyImage.h"
#import "CheckVerify.h"
#import "XYCover.h"

@interface ViewController (){
    NSMutableArray<NSDictionary*>* selectPoints;
}
@property (weak) IBOutlet NSImageView *verifyImage;
@property (weak) IBOutlet NSTextField *userNameTF;
@property (weak) IBOutlet NSTextField *passWordTF;
@property (weak) IBOutlet NSTextField *errorLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    // Do any additional setup after loading the view.
    __weak typeof(self) ws = self;
    [self getVerifyImage:^(NSImage *image) {
        __strong typeof(ws) sws = ws;
        dispatch_async(dispatch_get_main_queue(), ^{
            [sws.verifyImage setImage:image];
        });
        
    }];
    
}

-(void)initData{
    selectPoints = [NSMutableArray array];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

#pragma mark -- ui

/**
 添加点击红点试图

 @param point 红点的坐标
 */
-(void)addSelectPoint:(CGPoint)point{
    [selectPoints addObject:[XYCover point2Dictionary:point]];
    // 显示选中图标
    NSView* view = [[NSView alloc] initWithFrame:NSMakeRect(point.x, point.y, 10, 10)];
    view.wantsLayer = YES;
    [view.layer setBackgroundColor:[NSColor redColor].CGColor];
    NSClickGestureRecognizer* clickGesture = [[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(onClickSelectView:)];
    [view addGestureRecognizer:clickGesture];
    [view setNeedsDisplay:YES];
    [self.verifyImage addSubview:view];
}


#pragma mark -- event

- (IBAction)onClickLogin:(id)sender {
    
    // 获取验证码字符串
    NSMutableString* answer = [NSMutableString string];
    [selectPoints enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint point = [XYCover Dictionary2Point:obj];
        NSNumber* x = [NSNumber numberWithFloat:point.x];
        NSNumber* y = [NSNumber numberWithFloat:point.y];
        [answer appendFormat:@"%d,%d,",[x intValue],[y intValue]];
    }];
    [answer replaceCharactersInRange:NSMakeRange(answer.length-1, 1) withString:@""];
    __weak typeof(self) ws = self;
    [self checkVerify:answer complate:^(NSError *error) {
        __strong typeof(ws) sws = ws;
        if (error) {
            [sws.errorLabel setStringValue:error.domain];
        }
    }];
    
    
}

-(void)onClickSelectView:(NSClickGestureRecognizer*)sender{
    NSView* view = [sender view];
    CGFloat x = view.frame.origin.x;
    CGFloat y = view.frame.origin.y;
    __block NSUInteger removeIndex = -1;
    [selectPoints enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint temp = CGPointMake(x, y);
        CGPoint el = [XYCover Dictionary2Point:obj];
        if (CGPointEqualToPoint(temp, el)) {
            removeIndex = idx;
            *stop = YES;
            return ;
        }
    }];
    if (removeIndex >= 0 ) {
        [selectPoints removeObjectAtIndex:removeIndex];
    }
    [view removeFromSuperview];
}

- (IBAction)onClickVerifyImage:(NSClickGestureRecognizer*)sender {
    CGPoint point = [sender locationInView:self.verifyImage];
    [self addSelectPoint:point];
}

#pragma mark -- request

-(void)checkVerify:(NSString*)anwser complate:(void (^)(NSError* error))complate{
    CheckVerify* request = [[CheckVerify alloc] init];
    request.anwser = anwser;
    [[HttpUtil getInstance] sendHttpRequest:request complate:^(NSError * _Nullable error, NSDictionary * _Nullable response) {
        NSLog(@"request check verify complate error is : %@ response is : %@",error,response);
        if ([[response objectForKey:@"result_code"] intValue] != 4) {
            complate([NSError errorWithDomain:[response objectForKey:@"result_message"] code:[[response objectForKey:@"result_code"] intValue] userInfo:nil]);
        }else{
            complate(nil);
        }
    }];
}

-(void)getVerifyImage:(void(^)(NSImage* image))complate{
    GetVerifyImage* request = [[GetVerifyImage alloc] init];
    [[HttpUtil getInstance] sendHttpRequest:request complate:^(NSError * _Nullable error, NSDictionary * _Nullable response) {
        NSLog(@"request complate error is : %@ response is : %@",error,response);
        if ([[response objectForKey:@"result_code"] intValue] == 0) {
            NSString* base64ImageStr = [response objectForKey:@"image"];
            NSData* base64Data =  [[NSData alloc] initWithBase64EncodedString:base64ImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
            NSImage* base64Image = [[NSImage alloc] initWithData:base64Data];
            complate(base64Image);
        }else{
            complate(nil);
        }
    }];
}

@end
