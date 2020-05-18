//
//  UserCancelled.m
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCancelledMessage.h"

@implementation UserCancelledMessage

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSString* _messageName = dict[@"objectType"];
        assert([_messageName isEqualToString:@"UserCancelledMessage"]);
        _reason = dict[@"reason"];
    }
    return self;
}

@end
