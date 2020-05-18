//
//  VirtualCheckoutSuccessfulMessage.h
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//
#ifndef VirtualCheckoutSuccessfulMessage_h
#define VirtualCheckoutSuccessfulMessage_h

#import <Foundation/Foundation.h>
#import "QuadPayCard.h"
#import "QuadPayCardholder.h"

NS_ASSUME_NONNULL_BEGIN

@interface VirtualCheckoutSuccessfulMessage : NSObject

/**
 A backend-verifiable signature that the message originated from QuadPay
*/
@property (nonatomic, copy, nonnull) NSString* signature;

/**
 The card details for the order
*/
@property (nonatomic, copy, nonnull) QuadPayCard* card;

/**
 The card holder details for the order
*/
@property (nonatomic, copy, nonnull) QuadPayCardholder* cardholder;

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
