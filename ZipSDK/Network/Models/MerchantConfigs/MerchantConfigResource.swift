//
//  MerchantConfigResource.swift
//  QuadPaySDK
//
//  Created by Rhys John Williams on 15/05/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation

struct MerchantConfigResource : ApiResource {
    typealias ModelType = Merchant
    let merchantId: String
    let basePath: String
    
    init(basePath: String, merchantId: String){
        self.basePath = basePath
        self.merchantId = merchantId
    }
    
    var methodPath: String {
        return "/merchant-configs/" + merchantId + ".json"
    }
    
    var queryParams: [URLQueryItem]?
}
