//
//  QuadPayURLBuilder.m
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuadPayURLBuilder.h"

@implementation  QuadPayURLBuilder

+ (NSString *) buildVirtualCheckoutURL:(QuadPayCheckoutDetails*) details {
    NSString* base = [[QuadPay sharedInstance] getBaseUrl];
    base = [base stringByAppendingString:@"mobile/virtual/authorize?"];
    NSString* params = [QuadPayURLBuilder assembleParams:details];
    return [base stringByAppendingString:params];
}

+ (NSString *) buildCheckoutURL:(QuadPayCheckoutDetails*) details {
    NSString* base = [[QuadPay sharedInstance] getBaseUrl];
    base = [base stringByAppendingString:@"mobile/authorize?"];
    NSString* params = [[QuadPayURLBuilder assembleParams:details] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];;
    return [base stringByAppendingString:params];
}

+ (NSString *) assembleParams:(QuadPayCheckoutDetails*) details {
    if (details == NULL) {
        @throw [NSException exceptionWithName:@"DetailsNullException" reason:@"Checkout details cannot be null" userInfo:NULL];
    }
    NSString* merchantId = [[QuadPay sharedInstance] merchantId];
    NSString * base = [NSString stringWithFormat:@"MerchantId=%@&Order.Amount=%@", merchantId, details.amount];

    if (details.merchantReference) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&merchantReference=%@", details.merchantReference]];
    }
    if (details.customerEmail) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.Email=%@", details.customerEmail]];
    }
    if (details.customerFirstName) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.FirstName=%@", details.customerFirstName]];
    }
    if (details.customerLastName) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.LastName=%@", details.customerLastName]];
    }
    if (details.customerPhoneNumber) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.Phone=%@", details.customerPhoneNumber]];
    }
    if (details.customerAddressLine1) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.BillingAddress.Line1=%@", details.customerAddressLine1]];
    }
    if (details.customerAddressLine2) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.BillingAddress.Line2=%@", details.customerAddressLine2]];
    }
    if (details.customerCity) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.BillingAddress.City=%@", details.customerCity]];
    }
    if (details.customerState) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.BillingAddress.State=%@", details.customerState]];
    }
    if (details.customerPostalCode) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.BillingAddress.PostalCode=%@", details.customerPostalCode]];
    }
    if (details.customerCountry) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.BillingAddress.Country=%@", details.customerCountry]];
    }
    return base;
}

@end

