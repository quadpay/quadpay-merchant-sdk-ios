//
//  QuadPayURLBuilder.h
//  QuadPaySDK
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#ifndef ZipURLBuilder_h
#define ZipURLBuilder_h
#import "Zip.h"
#import "ZipCheckoutDetails.h"

@interface QuadPayURLBuilder : NSObject

+(NSString *) buildVirtualCheckoutURL:(ZipCheckoutDetails*) details;
+(NSString *) buildCheckoutURL:(ZipCheckoutDetails*) details;

+(NSString *) assembleParams:(ZipCheckoutDetails*) details;

@end

#endif /* QuadPayURLBuilder_h */
