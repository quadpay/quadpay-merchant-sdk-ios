//
//  QuadPayCheckoutDetails.h
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#ifndef ZipCheckoutDetails_h
#define ZipCheckoutDetails_h

NS_ASSUME_NONNULL_BEGIN

@interface ZipCheckoutDetails : NSObject

/**
 Order Amount. Required
 */
@property (nonatomic, copy, nonnull) NSDecimalNumber* amount;

/**
 A unique id for the order. Optional
*/
@property (nonatomic, copy, nullable) NSString* merchantReference;

/**
 Customer email. Optional
*/
@property (nonatomic, copy, nullable) NSString* customerEmail;

/**
 Customer first name. Optional
*/
@property (nonatomic, copy, nullable) NSString* customerFirstName;

/**
 Customer last name. Optional
*/
@property (nonatomic, copy, nullable) NSString* customerLastName;

/**
 Customer phone number. Optional
*/
@property (nonatomic, copy, nullable) NSString* customerPhoneNumber;

/**
 Customer address line 1. Optional
*/
@property (nonatomic, copy, nullable) NSString* customerAddressLine1;

/**
 Customer address line 2. Optional
*/
@property (nonatomic, copy, nullable) NSString* customerAddressLine2;

/**
 Customer address city. Optional
*/
@property (nonatomic, copy, nullable) NSString* customerCity;

/**
 Customer address state. Optional
*/
@property (nonatomic, copy, nullable) NSString* customerState;

/**
 Customer address postal code. Optional
*/
@property (nonatomic, copy, nullable) NSString* customerPostalCode;

/**
 Customer address country. Optional
*/
@property (nonatomic, copy, nullable) NSString* customerCountry;

/**
 Merchant Fee for Payment Plan. Optional
*/
@property (nonatomic, copy, nullable) NSString* merchantFeeForPaymentPlan;

/**
 Checkout flow for Checkout. Optional
*/
@property (nonatomic, copy, nullable) NSString* checkoutFlow;

@end

NS_ASSUME_NONNULL_END

#endif /* QuadPayCheckoutDetails_h */
