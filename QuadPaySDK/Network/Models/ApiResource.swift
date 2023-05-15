//
//  ApiResource.swift
//  QuadPaySDK
//
//  Created by Rhys John Williams on 15/05/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation

protocol ApiResource {
    associatedtype ModelType: Decodable
    var basePath: String { get }
    var methodPath: String { get }
    var queryParams: [URLQueryItem]? { get }
}

extension ApiResource {
    var url : URL {
        var components = URLComponents(string: basePath)!
        components.path = methodPath
        
        if(queryParams != nil){
            components.queryItems = queryParams
        }
        
        return components.url!
    }
}
