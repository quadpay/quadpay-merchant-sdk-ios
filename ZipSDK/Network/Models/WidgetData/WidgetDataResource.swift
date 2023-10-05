//
//  WidgetDataResource.swift
//  QuadPaySDK
//
//  Created by Rhys John Williams on 15/05/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation

struct WidgetDataResource : ApiResource {
    typealias ModelType = WidgetData
    let merchantId: String
    let basePath: String
    
    init(basePath: String, merchantId: String){
        self.basePath = basePath
        self.merchantId = merchantId
    }
    
    var methodPath: String {
        return "/virtual/widget-data"
    }
    
    var queryParams: [URLQueryItem]? {
        return [URLQueryItem(name: "merchantId", value: merchantId),
                URLQueryItem(name: "websiteUrl", value: nil),
                URLQueryItem(name: "environmentName", value: nil),
                URLQueryItem(name: "userId", value: nil)]
    }
}
