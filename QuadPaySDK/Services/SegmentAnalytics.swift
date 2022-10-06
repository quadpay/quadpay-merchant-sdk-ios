//
//  SegmentAnalytics.swift
//  QuadPaySDK
//
//  Created by Alex Lane on 9/27/22.
//  Copyright © 2022 QuadPay. All rights reserved.
//

import Foundation
import Segment
import FingerprintJS

@objc class SegmentAnalytics : NSObject {
    private var viewStandardWidgetEventName: String = "Viewed Standard Widget"
    private var trackingProperties: [String: String?] = [:]

    @objc override init() {
        // Override point for customization after application launch
        let keys = QuadPaySDKXcodeprojKeys()
        let configuration = AnalyticsConfiguration(writeKey: keys.segmentWriteKey)
        configuration.trackApplicationLifecycleEvents = true

        Analytics.setup(with: configuration)
        
        let fingerprinter = FingerprinterFactory.getInstance()
        var fingerprint: String? = ""
        
        fingerprinter.getFingerprint {
            result in fingerprint = result
        }
        
        trackingProperties = ["userId": fingerprint]
    }

    @objc public func trackViewedStandardWidget() {
        Analytics.shared().track(viewStandardWidgetEventName, properties: trackingProperties as [String: Any])
    }
}
