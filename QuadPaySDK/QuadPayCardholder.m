//
//  QuadPayCardholder.m
//  QuadPaySDK
//
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
        _name = dict[@"name"];
        _addressLine1 = dict[@"address1"];
        _addressLine2 = dict[@"address2"];
        _city = dict[@"city"];
        _state = dict[@"state"];
        _postalCode = dict[@"postalCode"];
        
        NSAssert(_name != NULL, @"name cannot be null");
        NSAssert(_addressLine1 != NULL, @"address line 1 cannot be null");
        NSAssert(_city != NULL, @"city cannot be null");
        NSAssert(_state != NULL, @"state cannot be null");
        NSAssert(_postalCode != NULL, @"postal code cannot be null");
    }
    return self;
}

@end
