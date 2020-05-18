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
    if ([_environment isEqualToString:@"prod"]) {
        return @"https://master.gateway.quadpay.xyz/";
    }
    if ([_environment isEqualToString:@"sandbox"]) {
        return @"https://master.gateway.quadpay.xyz/";
    }
    if ([_environment isEqualToString:@"ci"]) {
        return @"https://master.gateway.quadpay.xyz/";
    }
    [[NSException exceptionWithName:@"QuadPayException" reason:@"Must have environment" userInfo:NULL] raise];
    return NULL;
}

@end
