//
//  QuadPayCardholder.m
//  QuadPaySDK
//
//  Created by Paul Sauer on 5/12/20.
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuadPayCardholder.h"

@implementation QuadPayCardholder

- (NSString*)toString {
  return [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@",
          _name, _addressLine1, _addressLine2, _city, _state, _postalCode];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _name = dict[@"cardHolder"][@"name"];
        _addressLine1 = dict[@"cardHolder"][@"address1"];
        _addressLine2 = dict[@"cardHolder"][@"address2"];
        _city = dict[@"cardHolder"][@"city"];
        _state = dict[@"cardHolder"][@"state"];
        _postalCode = dict[@"cardHolder"][@"postalCode"];
    }
    return self;
}

@end
