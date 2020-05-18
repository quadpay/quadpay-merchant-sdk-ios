//
//  ExceptionMessage.m
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExceptionMessage.h"

@implementation ExceptionMessage

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSString* _messageName = dict[@"messageType"];
        NSAssert([_messageName isEqualToString:@"ExceptionMessage"], @"Correct message type");
        _signature = dict[@"signature"];
        NSAssert(_signature != nil, @"Signature must not be nil");

        _message = dict[@"message"][@"message"];
    }
    return self;
}

@end
