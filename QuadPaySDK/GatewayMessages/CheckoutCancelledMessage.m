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
        if (![_messageName isEqualToString:@"CheckoutCancelledMessage"]) {
            @throw [NSException exceptionWithName:@"MessageTypeException" reason:@"Incorrect Message Type" userInfo:@{@"Message Name": _messageName, @"Expected Message Type": @"CheckoutCancelledMessage"}];
        }

        _reason = dict[@"message"][@"reason"];        
    }
    return self;
}

@end
