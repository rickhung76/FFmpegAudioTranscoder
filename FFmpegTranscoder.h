//
//  FFmpegTranscoder.h
//  DVDMediaCenter
//
//  Created by TRDC Mac Pro on 2016/6/30.
//  Copyright © 2016年 HoldingTOP INFO CO., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFmpegTranscoder : NSObject
- (void)transcoderFileWithPath:(NSString*)inFilePath Format:(NSString*)outputFormat;
@end
