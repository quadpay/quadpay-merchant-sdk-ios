//
//  ApiRequest.swift
//  QuadPaySDK
//
//  Created by Rhys John Williams on 15/05/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation

class ApiRequest<Resource: ApiResource> {
    let resource: Resource
    
    init(resource: Resource){
        self.resource = resource
    }
}

extension ApiRequest : NetworkRequest {
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        
        do {
            let parsedData = try decoder.decode(Resource.ModelType.self, from: data)
            return parsedData
        } catch {
            print("Error parsing data: \(error)")
            return nil
        }
    }
    
    func execute(withCompletion completion: @escaping (Result<Resource.ModelType?, Error>) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}
