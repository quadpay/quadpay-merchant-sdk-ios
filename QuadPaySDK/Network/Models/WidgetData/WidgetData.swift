//
//  WidgetData.swift
//  QuadPaySDK
//
//  Created by Rhys John Williams on 15/05/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation

struct WidgetData: Codable {
    let bankPartner: String
    let feeTiers: [FeeTier]
}
