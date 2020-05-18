//
//  CheckoutCancelledMessage.h
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//
#ifndef CheckoutCancelledMessage_h
#define CheckoutCancelledMessage_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckoutCancelledMessage : NSObject

/**
 A string describing the reason for cancellation
*/
@property (nonatomic, copy, nonnull) NSString* reason;

/**
 Initializer. See properties for more details.
 @param dict Data dictionary.
 @return The initialized message
 */
- (instancetype)initWithDict: (NSDictionary *)dict
NS_SWIFT_NAME(init(dict:));

@end

NS_ASSUME_NONNULL_END

#endif /* CheckoutCancelledMessage_h */
