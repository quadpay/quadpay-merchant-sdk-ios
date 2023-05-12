//
//  MerchantService.swift
//  QuadPaySDK
//
//  Created by Petros Andreou on 16/01/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation

struct Merchant: Codable {
    let MerchantId: String
    let MerchantName: String
    let MinimumOrderAmount: Int
    let MaximumOrderAmount: Int
//    let IsLongDurationLendingEnabled: Bool
//    let LongDurationLendingMinimumAmount: String
//    let LongDurationLendingMaximumAmount: String
//    let ApplyGrayLabel: Bool
//    let ModalGrayLabelName: String
//    let LogoUrl: String
//    let ModalTopColor: String
//    let LinkTextColor: String
//    let ModalHeadersFontStyle: String
//    let ModalBodyFontStyle: String
//    let ZipWidgetFontStyle: String
//    let TimelineColor: String
//    let PaymentWidgetHeaderFontStyle: String
//    let PaymentWidgetBodyFontStyle: String
//    let CheckoutButtonColor: String
    //Many more to add later
}

enum ServiceError: Error {
    case server
    case parsing
}

struct MerchantService {
    static let shared = MerchantService()
    
    func fetchMerchants(merchantId: String ,completion: @escaping((Result<Merchant, Error>) -> Void )){
        
        let url = URL(string: "\(Configuration.cdnUrl.absoluteString)/merchant-configs/" + merchantId + ".json")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(Result.failure(error))
                }
            }
            
            guard let data = data else { return }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(Result.failure(ServiceError.server))
            return
            }
            
            let decoder = JSONDecoder()

            
            do {
                let result = try decoder.decode(Merchant.self, from: data)
                DispatchQueue.main.async {
                    completion(Result.success(result))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(Result.failure(ServiceError.parsing))
                }
            }
        }
        task.resume()
    }
}
