//
//  QuadPayCheckoutDetails.h
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#ifndef QuadPayCheckoutDetails_h
#define QuadPayCheckoutDetails_h

NS_ASSUME_NONNULL_BEGIN

@interface QuadPayCheckoutDetails : NSObject

/**
 Order Amount. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSDecimalNumber* amount;

/**
 A unique id for the order. Optional
*/
@property (nonatomic, copy, readonly, nullable) NSString* merchantReference;

/**
 Customer email. Optional
*/
@property (nonatomic, copy, readonly, nullable) NSString* customerEmail;

/**
 Customer first name. Optional
*/
@property (nonatomic, copy, readonly, nullable) NSString* customerFirstName;

/**
 Customer last name. Optional
*/
@property (nonatomic, copy, readonly, nullable) NSString* customerLastName;

/**
 Customer phone number. Optional
*/
@property (nonatomic, copy, readonly, nullable) NSString* customerPhoneNumber;

/**
 Customer address line 1. Optional
*/
@property (nonatomic, copy, readonly, nullable) NSString* customerAddressLine1;

/**
 Customer address line 2. Optional
*/
@property (nonatomic, copy, readonly, nullable) NSString* customerAddressLine2;

/**
 Customer address city. Optional
*/
@property (nonatomic, copy, readonly, nullable) NSString* customerCity;

/**
 Customer address state. Optional
*/
@property (nonatomic, copy, readonly, nullable) NSString* customerState;

/**
 Customer address postal code. Optional
*/
@property (nonatomic, copy, readonly, nullable) NSString* customerPostalCode;

/**
 Customer address country. Optional
*/
@property (nonatomic, copy, readonly, nullable) NSString* customerCountry;

@end

NS_ASSUME_NONNULL_END

#endif /* QuadPayCheckoutDetails_h */
