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

        _message = dict[@"message"][@"message"];
    }
    return self;
}

@end
