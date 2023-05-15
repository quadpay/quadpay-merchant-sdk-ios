//
//  FeeTier.swift
//  QuadPaySDK
//
//  Created by Rhys John Williams on 15/05/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation

struct FeeTier: Codable {
    let feeStartsAt: Double
    let totalFeePerOrder: Double
    
    enum CodingKeys: String, CodingKey{
        case feeStartsAt
        case totalFeePerOrder
    }
}
