//
//  ViewController.m
//  FFmpegAudioTranscoder
//
//  Created by Rick on 2017/2/20.
//  Copyright © 2017年 Rick. All rights reserved.
//

#import "ViewController.h"
#import "FFmpegTranscoder.h"

@interface ViewController () {
    FFmpegTranscoder *ffmpegTranscoder;
    NSString *transcodeURL;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ffmpegProcessUpdate:)
                                                 name:@"ffmpegProcessUpdate"
                                               object:nil];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    transcodeURL = [paths objectAtIndex:0];
}

-(void)viewWillAppear:(BOOL)animated {
    transcodeURL = [transcodeURL stringByAppendingPathComponent:@"/TRACK01.wav"];
    if ([[transcodeURL pathExtension] isEqualToString:@"wav"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            ffmpegTranscoder = [FFmpegTranscoder alloc];
            [ffmpegTranscoder transcoderFileWithPath:transcodeURL Format:@"aac"];
        });
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification
- (void)ffmpegProcessUpdate:(NSNotification*)notification {
    NSString *process = [notification object];
    if ([process isEqualToString:@"100"]) {
        NSLog(@"Transfer Compeleted!!");
        ffmpegTranscoder = nil;
    }
    else {
        NSLog(@"Processing: %@%%", process);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
