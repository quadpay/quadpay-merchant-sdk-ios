//
//  QuadPayCustomer.h
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#ifndef QuadPayCustomer_h
#define QuadPayCustomer_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuadPayCustomer : NSObject

/**
 Customer's first name. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *firstName;

/**
 Customer's last name. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *lastName;

/**
 Customer's address line 1. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *address1;

/**
 Customer's address line 2. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *address2;

/**
 Customer's address city. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *city;

/**
 Customer's address state. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *state;

/**
 Customer's address postal code. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *postalCode;

/**
 Customer's address country. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *country;

/**
 Customer's email address. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *email;

/**
 Customer's phone number. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *phoneNumber;

/**
 Initializer. See properties for more details.
 @param dict Data dictionary.
 @return The initialized customer info.
 */
- (instancetype)initWithDict: (NSDictionary *)dict
NS_SWIFT_NAME(init(dict:));

/**
 Convenience method for simple serialization
 @return String with all fields
 */
- (NSString*)toString
NS_SWIFT_NAME(toString());

@end

NS_ASSUME_NONNULL_END

#endif /* QuadPayCustomer_h */
