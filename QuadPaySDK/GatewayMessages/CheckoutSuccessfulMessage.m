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
        NSString* _messageName = dict[@"objectType"];
        assert([_messageName isEqualToString:@"CheckoutSuccessfulMessage"]);
        _token = dict[@"token"];
        if (_token == nil) {
            [[NSException exceptionWithName:@"DecodeError" reason:@"Could not decode message from gateway (token)" userInfo:NULL] raise];
        }
    }
    return self;
}

@end
