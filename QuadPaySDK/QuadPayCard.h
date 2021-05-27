//
//  QuadPayCard.h
//  QuadPaySDK
//

//  Copyright © 2020 QuadPay. All rights reserved.
//

#ifndef QuadPayCard_h
#define QuadPayCard_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuadPayCard : NSObject

/**
 Card CVC. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *cvc;

/**
 Card number. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSString *number;

/**
 Card expiration month. Required
 */
@property (nonatomic, copy, readonly, nonnull) NSNumber *expirationMonth;

/**
Card expiration year. Required
*/
@property (nonatomic, copy, readonly, nonnull) NSNumber *expirationYear;

/**
Card brand. Required
*/
@property (nonatomic, copy, readonly, nonnull) NSString *brand;

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
#endif /* QuadPayCard_h */
