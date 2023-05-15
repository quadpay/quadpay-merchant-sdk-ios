//
//  MerchantConfigService.swift
//  QuadPaySDK
//
//  Created by Rhys John Williams on 15/05/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation

struct MerchantConfigService {
    static let instance = MerchantConfigService()
    
    let basePath : String = Configuration.cdnUrl.absoluteString
    
    private init() {
        
    }
    
    func fetchMerchants(merchantId: String ,completion: @escaping((Result<Merchant?, Error>) -> Void )) -> ApiRequest<MerchantConfigResource> {
        let resource = MerchantConfigResource(basePath: basePath, merchantId: merchantId)
        let request = ApiRequest(resource: resource)
        request.execute(withCompletion: completion)
        return request
    }
}
