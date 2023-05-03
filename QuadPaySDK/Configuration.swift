//
//  Configuration.swift
//  QuadPaySDK
//
//  Created by Petros Andreou on 02/05/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation


enum Configuration{
    
    static var apiGatewayUrl: URL {
        URL(string: string(for: "GATEWAY_URL"))!
    }
    
    static private func string(for key: String) -> String {
        Bundle.qpResource.infoDictionary?[key] as! String
    }
}

