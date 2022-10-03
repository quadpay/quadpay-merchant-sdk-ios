//
//  Configuration.swift
//  QuadPaySDK
//
//  Created by Alex Lane on 10/3/22.
//  Copyright © 2022 QuadPay. All rights reserved.
//

import Foundation

enum Configuration {
    
    static var segmentApiWriteKey: String {
        string(for: "SEGMENT_WRITE_KEY")
    }
    
    static private func string(for key: String) -> String {
        Bundle.main.infoDictionary?[key] as! String
    }
    
}
