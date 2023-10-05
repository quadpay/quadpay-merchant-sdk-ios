//
//  GatewayService.swift
//  QuadPaySDK
//
//  Created by Rhys John Williams on 15/05/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation

struct GatewayService {
    static let instance = GatewayService()
 
    private init() {
        
    }
    
    let basePath : String = Configuration.gatewayUrl.absoluteString
    
    func fetchWidgetData(merchantId: String, withCompletion completion: @escaping (Result<WidgetData?, Error>) -> Void) -> ApiRequest<WidgetDataResource> {
        let resource = WidgetDataResource(basePath: basePath, merchantId: merchantId)
        let request = ApiRequest(resource: resource)
        request.execute(withCompletion: completion)
        return request
    }
}
