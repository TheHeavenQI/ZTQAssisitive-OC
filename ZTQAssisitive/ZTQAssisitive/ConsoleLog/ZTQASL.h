//
//  ZTQASL.h
//  ZTQAssisitive
//
//  Created by Ztq on 2017/4/13.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemLogMessage.h"

@interface ZTQASL : NSObject

+ (NSMutableArray<SystemLogMessage *> *)allLogMessagesForCurrentProcess;

@end
