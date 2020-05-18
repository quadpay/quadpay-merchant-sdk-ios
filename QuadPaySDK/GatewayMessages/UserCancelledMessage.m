//
//  UserCancelled.m
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCancelledMessage.h"

@implementation UserCancelledMessage

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSString* _messageName = dict[@"messageType"];
        NSAssert([_messageName isEqualToString:@"UserCancelledMessage"], @"Correct message type");
        _reason = dict[@"message"][@"reason"];
    }
    return self;
}

@end
