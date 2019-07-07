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

@interface ViewController (){
    NSArray* selectVerifyArr;
}
@property (weak) IBOutlet NSImageView *verifyImage;
@property (weak) IBOutlet NSTextField *userNameTF;
@property (weak) IBOutlet NSTextField *passWordTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    __weak typeof(self) ws = self;
    [self getVerifyImage:^(NSImage *image) {
        __strong typeof(ws) sws = ws;
        dispatch_async(dispatch_get_main_queue(), ^{
            [sws.verifyImage setImage:image];
        });
        
    }];
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

#pragma mark -- event
- (IBAction)onClickVerifyImage:(NSClickGestureRecognizer*)sender {
    
}

#pragma mark -- request
-(void)getVerifyImage:(void(^)(NSImage* image))complate{
    GetVerifyImage* request = [[GetVerifyImage alloc] init];
    [[[HttpUtil alloc] init] sendHttpRequest:request complate:^(NSError * _Nullable error, NSDictionary * _Nullable response) {
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
