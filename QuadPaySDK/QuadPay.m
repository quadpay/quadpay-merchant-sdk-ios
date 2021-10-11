//
//  QuadPayCustomer.m
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuadPay.h"

static QuadPay *__sharedInstance = nil;

@implementation QuadPay

+ (id)sharedInstance {
    static QuadPay *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)initialize:(NSString *)merchantId environment:(NSString* )environment locale:(NSString *)locale {
    QuadPay* instance = [QuadPay sharedInstance];
    instance.merchantId = merchantId;
    instance.environment = environment;
    instance.locale = locale;
}

- (NSString *)getBaseUrl {
    if ([_environment isEqualToString:@"production"]) {
        if ([_locale isEqualToString:@"US"]) {
            return @"https://gateway.quadpay.com/";
        }
        if ([_locale isEqualToString:@"MX"]) {
            return @"https://gateway.mx.zip.co/";
        }
        return @"https://gateway.quadpay.com/";
    }
    if ([_environment isEqualToString:@"sandbox"]) {
        if ([_locale isEqualToString:@"US"]) {
            return @"https://sandbox.gateway.quadpay.com/";
        }
        if ([_locale isEqualToString:@"MX"]) {
            return @"https://gateway.sand.mx.zip.co/";
        }
        return @"https://sandbox.gateway.quadpay.com/";
    }
    if ([_environment isEqualToString:@"development"]) {
        if ([_locale isEqualToString:@"US"]) {
            return @"https://master.gateway.quadpay.xyz/";
        }
        if ([_locale isEqualToString:@"MX"]) {
            return @"https://gateway.dev.mx.zip.co/";
        }
        return @"https://master.gateway.quadpay.xyz/";
    }
    [[NSException exceptionWithName:@"QuadPayException" reason:@"Must have environment" userInfo:NULL] raise];
    return NULL;
}

@end
