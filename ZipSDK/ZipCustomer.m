//
//  QuadPayCustomer.m
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipCustomer.h"

@implementation ZipCustomer

- (NSString*)toString {
  return [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@, %@, %@, %@, %@",
          _firstName, _lastName, _address1, _address2, _postalCode, _city, _state, _country, _email, _phoneNumber];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _firstName = dict[@"firstName"];
        _lastName = dict[@"lastName"];
        _address1 = dict[@"address1"];
        _address2 = dict[@"address2"];
        _city = dict[@"city"];
        _state = dict[@"state"];
        _postalCode = dict[@"postalCode"];
        _country = dict[@"country"];
        _email = dict[@"email"];
        _phoneNumber = dict[@"phoneNumber"];
        
        NSAssert(_firstName != NULL, @"first nanme cannot be null");
        NSAssert(_lastName != NULL, @"last name cannot be null");
        NSAssert(_address1 != NULL, @"address line 1 cannot be null");
        NSAssert(_address2 != NULL, @"address line 2 cannot be null");
        NSAssert(_city != NULL, @"address city cannot be null");
        NSAssert(_state != NULL, @"address state cannot be null");
        NSAssert(_postalCode != NULL, @"address postal code cannot be null");
        NSAssert(_country != NULL, @"address country cannot be null");
        NSAssert(_email != NULL, @"email address cannot be null");
        NSAssert(_phoneNumber != NULL, @"phone number cannot be null");
    }
    return self;
}

@end
