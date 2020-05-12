//
//  QuadPayCardholder.h
//  QuadPaySDK
//

//  Copyright © 2020 QuadPay. All rights reserved.
//

#ifndef QuadPayCardholder_h
#define QuadPayCardholder_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuadPayCardholder : NSObject

/**
 Cardholder's name as printed on card. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *name;

/**
 Cardholder's address line 1. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *addressLine1;

/**
 Cardholder's address line 2. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *addressLine2;

/**
 Cardholder's city. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *city;

/**
 Cardholder's state. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *state;

/**
 Cardholder's postal code. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *postalCode;


/**
 Initializer. See properties for more details.
 @param dict Data dictionary.
 @return The initialized credit card info.
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
#endif /* QuadPayCardholder_h */
