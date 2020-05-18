//
//  CheckoutCancelledMessage.m
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckoutCancelledMessage.h"

@implementation CheckoutCancelledMessage

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSString* _messageName = dict[@"messageType"];
        NSAssert([_messageName isEqualToString:@"CheckoutCancelledMessage"], @"Correct message type");

        _reason = dict[@"message"][@"reason"];        
    }
    return self;
}

@end
