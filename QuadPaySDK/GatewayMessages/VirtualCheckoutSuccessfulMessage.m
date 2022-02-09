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
        if (![_messageName isEqualToString:@"VirtualCheckoutSuccessfulMessage"]) {
            @throw [NSException exceptionWithName:@"MessageTypeException" reason:@"Incorrect Message Type" userInfo:@{@"Message Name": _messageName, @"Expected Message Type": @"VirtualCheckoutSuccessfulMessage"}];
        }

        NSDictionary* cardData = [[dict objectForKey:@"message"] objectForKey:@"card"];
        NSDictionary* cardholderData = [[dict objectForKey:@"message"] objectForKey:@"cardholder"];
        NSDictionary* customerData = [[dict objectForKey:@"message"] objectForKey:@"customer"];
        NSString* orderId = [[dict objectForKey:@"message"] objectForKey:@"orderId"];
        _card = [[QuadPayCard alloc] initWithDict:cardData];
        _cardholder = [[QuadPayCardholder alloc] initWithDict:cardholderData];
        _customer = [[QuadPayCustomer alloc] initWithDict:customerData];
        _orderId = orderId;
    }
    return self;
}

@end
