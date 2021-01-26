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
        if (![_messageName isEqualToString:@"CheckoutSuccessfulMessage"]) {
            @throw [NSException exceptionWithName:@"MessageTypeException" reason:@"Incorrect Message Type" userInfo:@{@"Message Name": _messageName, @"Expected Message Type": @"CheckoutSuccessfulMessage"}];
        }

        NSDictionary* customerData = [[dict objectForKey:@"message"] objectForKey:@"customer"];
        
        _orderId = dict[@"message"][@"orderId"];
        _customer = [[QuadPayCustomer alloc] initWithDict:customerData];
        
        NSAssert(_orderId != nil, @"Order id must not be nil");
    }
    return self;
}

@end
