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

        NSDictionary* cardData = [[dict objectForKey:@"message"] objectForKey:@"card"];
        NSDictionary* cardholderData = [[dict objectForKey:@"message"] objectForKey:@"cardholder"];
        _card = [[QuadPayCard alloc] initWithDict:cardData];
        _cardholder = [[QuadPayCardholder alloc] initWithDict:cardholderData];
    }
    return self;
}

@end
