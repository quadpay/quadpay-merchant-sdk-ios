//
//  NewMerchantService.swift
//  Pods-SDKDemo
//
//  Created by Petros Andreou on 17/04/2023.
//

import Foundation

struct WidgetDataModel: Codable {
  //  let featureFlats: FeatureFlagsDictionary
    let bankPartner: String
    let feeTiers: [MerchantFeeTier]
}

struct MerchantFeeTier: Codable {
    let feeStartsAt: Double
    let totalFeePerOrder: Double
    
    enum CodingKeys: String, CodingKey{
        case feeStartsAt
        case totalFeePerOrder
    }
}

struct FeatureFlagsDictionary: Codable {
    
}


struct WidgetDataService {
    static let shared = WidgetDataService()
    
    func fetchWidgetData(merchantId: String ,completion: @escaping((Result<WidgetDataModel, Error>) -> Void )){
      
        let WidgetDataUrl = URL(string: "\(Configuration.gatewayUrl.absoluteString)virtual/widget-data")!
        var components = URLComponents(url: WidgetDataUrl, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "merchantId", value: merchantId),
                                  URLQueryItem(name: "websiteUrl", value: nil),
                                  URLQueryItem(name: "environmentName", value: nil),
                                  URLQueryItem(name: "userId", value: nil)]

        let task = URLSession.shared.dataTask(with: (components?.url!)!) { data, response, error in
            
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
                let result = try decoder.decode(WidgetDataModel.self, from: data)
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
