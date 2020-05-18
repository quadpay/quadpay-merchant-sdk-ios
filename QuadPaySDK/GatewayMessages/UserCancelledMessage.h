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
 A string describing the reason for cancellation
*/
@property (nonatomic, copy, nonnull) NSString* reason;

/**
 Initializer. See properties for more details.
 @param dict Data dictionary.
 @return The initialized credit card info.
 */
- (instancetype)initWithDict: (NSDictionary *)dict
NS_SWIFT_NAME(init(dict:));

@end

NS_ASSUME_NONNULL_END

#endif /* UserCancelledMessage_h */
