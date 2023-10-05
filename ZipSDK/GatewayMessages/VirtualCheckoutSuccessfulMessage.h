//
//  VirtualCheckoutSuccessfulMessage.h
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//
#ifndef VirtualCheckoutSuccessfulMessage_h
#define VirtualCheckoutSuccessfulMessage_h

#import <Foundation/Foundation.h>
#import "ZipCard.h"
#import "ZipCardholder.h"
#import "ZipCustomer.h"

NS_ASSUME_NONNULL_BEGIN

@interface VirtualCheckoutSuccessfulMessage : NSObject

/**
 The card details for the order
*/
@property (nonatomic, copy, nonnull) ZipCard* card;

/**
 The card holder details for the order
*/
@property (nonatomic, copy, nonnull) ZipCardholder* cardholder;

/**
 The Zip customer data
*/
@property (nonatomic, copy, nonnull) ZipCustomer* customer;

/**
 The Zip OrderId
*/
@property (nonatomic, copy, nonnull) NSString* orderId;

/**
 Initializer. See properties for more details.
 @param dict Data dictionary.
 @return The initialized message
 */
- (instancetype)initWithDict: (NSDictionary *)dict
NS_SWIFT_NAME(init(dict:));

@end

NS_ASSUME_NONNULL_END

#endif /* VirtualCheckoutSuccessfulMessage_h */
