//
//  QuadPayURLBuilder.h
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#ifndef QuadPayURLBuilder_h
#define QuadPayURLBuilder_h
#import "Zip.h"
#import "QuadPayCheckoutDetails.h"

@interface QuadPayURLBuilder : NSObject

+(NSString *) buildVirtualCheckoutURL:(QuadPayCheckoutDetails*) details;
+(NSString *) buildCheckoutURL:(QuadPayCheckoutDetails*) details;

+(NSString *) assembleParams:(QuadPayCheckoutDetails*) details;

@end

#endif /* QuadPayURLBuilder_h */
