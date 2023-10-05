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
        if (![_messageName isEqualToString:@"ExceptionMessage"]) {
            @throw [NSException exceptionWithName:@"MessageTypeException" reason:@"Incorrect Message Type" userInfo:@{@"Message Name": _messageName, @"Expected Message Type": @"ExceptionMessage"}];
        }


        _message = dict[@"message"][@"message"];
    }
    return self;
}

@end
