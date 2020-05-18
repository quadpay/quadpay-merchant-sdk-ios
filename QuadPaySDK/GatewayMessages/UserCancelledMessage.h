//
//  UserCancelledMessage.h
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//
#ifndef UserCancelledMessage_h
#define UserCancelledMessage_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCancelledMessage : NSObject

/**
 A backend-verifiable signature that the message originated from QuadPay
*/
@property (nonatomic, copy, nonnull) NSString* signature;

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

#endif /* UserCancelledMessage_h */
