//
//  CheckoutSuccessfulMessage.m
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckoutSuccessfulMessage.h"

@implementation CheckoutSuccessfulMessage

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSString* _messageName = dict[@"messageType"];
        NSAssert([_messageName isEqualToString:@"CheckoutSuccessfulMessage"], @"Correct message type");

        _orderId = dict[@"message"][@"orderId"];
        NSAssert(_orderId != nil, @"Order id must not be nil");
    }
    return self;
}

@end