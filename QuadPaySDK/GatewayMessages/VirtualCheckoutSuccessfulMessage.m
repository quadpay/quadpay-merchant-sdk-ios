//
//  CheckoutSuccessfulMessage.m
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VirtualCheckoutSuccessfulMessage.h"

@implementation VirtualCheckoutSuccessfulMessage

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSString* _messageName = dict[@"messageType"];
        NSAssert([_messageName isEqualToString:@"VirtualCheckoutSuccessfulMessage"], @"Correct message type");
        _signature = dict[@"signature"];
        NSAssert(_signature != nil, @"Signature must not be nil");
    }
    return self;
}

@end
