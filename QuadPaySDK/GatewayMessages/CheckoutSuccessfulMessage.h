//
//  CheckoutSuccessfulMessage.h
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//
#ifndef CheckoutSuccessfulMessage_h
#define CheckoutSuccessfulMessage_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckoutSuccessfulMessage : NSObject

/**
 The checkout order id used to confirm the order from a backend server
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

#endif /* CheckoutSuccessfulMessage_h */
