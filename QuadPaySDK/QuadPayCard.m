//
//  QuadPayCard.m
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuadPayCard.h"

@implementation QuadPayCard

- (NSString*)toString {
  return [NSString stringWithFormat:@"%@, %@, %@, %@",
          _number, _cvc, _expirationMonth, _expirationYear];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _cvc = dict[@"card"][@"cvc"];
        _expirationMonth = dict[@"card"][@"expirationMonth"];
        _expirationYear = dict[@"card"][@"expirationYear"];
        _number = dict[@"card"][@"number"];
    }
    return self;
}

@end
