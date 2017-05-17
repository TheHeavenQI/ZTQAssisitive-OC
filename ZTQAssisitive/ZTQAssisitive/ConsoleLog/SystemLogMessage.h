//
//  SystemLogMessage.h
//  ZTQAssisitive
//
//  Created by Ztq on 2017/4/13.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <asl.h>
#import <os/log.h>

@interface SystemLogMessage : NSObject

+ (instancetype)logMessageFromASLMessage:(aslmsg)aslMessage;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, copy) NSString *sender;
@property (nonatomic, copy) NSString *messageText;
@property (nonatomic, assign) long long messageID;



- (NSString *)displayedTextForLogMessage;
+ (NSString *)logTimeStringFromDate:(NSDate *)date;

@end
