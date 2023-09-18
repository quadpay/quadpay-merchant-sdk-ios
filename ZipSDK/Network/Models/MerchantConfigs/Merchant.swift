//
//  Merchant.swift
//  QuadPaySDK
//
//  Created by Rhys John Williams on 15/05/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation

struct Merchant: Codable {
    let merchantId: String
    let merchantName: String
    let minimumOrderAmount: Int
    let maximumOrderAmount: Int
}
