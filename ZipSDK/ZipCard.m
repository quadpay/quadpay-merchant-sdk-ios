//
//  QuadPayCard.m
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipCard.h"

@implementation ZipCard

- (NSString*)toString {
  return [NSString stringWithFormat:@"%@, %@, %@, %@",
          _number, _cvc, _expirationMonth, _expirationYear];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _cvc = dict[@"cvc"];
        _expirationMonth = dict[@"expirationMonth"];
        _expirationYear = dict[@"expirationYear"];
        _number = dict[@"number"];
        _brand = dict[@"brand"];
        
        NSAssert(_cvc != NULL, @"cvc cannot be null");
        NSAssert(_expirationMonth != NULL, @"exp month cannot be null");
        NSAssert(_expirationYear != NULL, @"exp year cannot be null");
        NSAssert(_number != NULL, @"number cannot be null");
        NSAssert(_brand != NULL, @"brand cannot be null");
    }
    return self;
}

@end
