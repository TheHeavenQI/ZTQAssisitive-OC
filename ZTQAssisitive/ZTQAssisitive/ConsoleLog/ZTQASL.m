//
//  ZTQASL.m
//  ZTQAssisitive
//
//  Created by Ztq on 2017/4/13.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#import "ZTQASL.h"

@implementation ZTQASL

+ (NSMutableArray<SystemLogMessage *> *)allLogMessagesForCurrentProcess
{
    NSMutableArray *logMessages = [NSMutableArray array];
    
    asl_object_t query = asl_new(ASL_TYPE_QUERY);
    
    // Filter for messages from the current process. Note that this appears to happen by default on device, but is required in the simulator.
    NSString *pidString = [NSString stringWithFormat:@"%d", [[NSProcessInfo processInfo] processIdentifier]];
    asl_set_query(query, ASL_KEY_PID, [pidString UTF8String], ASL_QUERY_OP_EQUAL);
    
    aslresponse response = asl_search(NULL, query);
    aslmsg aslMessage = NULL;
    
    while ((aslMessage = asl_next(response))) {
        [logMessages addObject:[SystemLogMessage logMessageFromASLMessage:aslMessage]];
    }
    asl_release(response);
    
    
    return logMessages;
}


////这个是怎么从日志的对象aslmsg中获取我们需要的数据
//+(instancetype)logMessageFromASLMessage:(aslmsg)aslMessage
//{
//    SystemLogMessage *logMessage = [[SystemLogMessage alloc] init];
//    
//    const char *timestamp = asl_get(aslMessage, ASL_KEY_TIME);
//    if (timestamp) {
//        NSTimeInterval timeInterval = [@(timestamp) integerValue];
//        const char *nanoseconds = asl_get(aslMessage, ASL_KEY_TIME_NSEC);
//        if (nanoseconds) {
//            timeInterval += [@(nanoseconds) doubleValue] / NSEC_PER_SEC;
//        }
//        logMessage.timeInterval = timeInterval;
//        logMessage.date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
//    }
//    
//    const char *sender = asl_get(aslMessage, ASL_KEY_SENDER);
//    if (sender) {
//        logMessage.sender = @(sender);
//    }
//    
//    const char *messageText = asl_get(aslMessage, ASL_KEY_MSG);
//    if (messageText) {
//        logMessage.messageText = @(messageText);//NSLog写入的文本内容
//    }
//    
//    const char *messageID = asl_get(aslMessage, ASL_KEY_MSG_ID);
//    if (messageID) {
//        logMessage.messageID = [@(messageID) longLongValue];
//    }
//    
//    return logMessage;
//}

@end
