//
//  QuadPay.h
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#ifndef QuadPay_h
#define QuadPay_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuadPay : NSObject

@property (nonatomic, copy, nonnull) NSString* merchantId;
@property (nonatomic, copy, nonnull) NSString* environment;
@property (nonatomic, copy, nonnull) NSString* locale;

+ (instancetype)sharedInstance;

- (void)initialize:(NSString *)merchantId environment:(NSString* )environment locale:(NSString *)locale;

- (NSString *)getBaseUrl;

@end

NS_ASSUME_NONNULL_END

#endif /* QuadPay_h */
