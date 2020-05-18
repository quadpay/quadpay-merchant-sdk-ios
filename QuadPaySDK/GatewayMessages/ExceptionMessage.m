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
        NSString* _messageName = dict[@"objectType"];
        assert([_messageName isEqualToString:@"ExceptionMessage"]);
        _message = dict[@"message"];
    }
    return self;
}

@end
