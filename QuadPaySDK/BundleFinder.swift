//
//  File.swift
//  QuadPaySDK
//
//  Created by Lai Tang on 05/07/2022.
//

import Foundation

private class BundleFinder {}

internal extension Foundation.Bundle {


  static var qpResource: Bundle = {
    let moduleName = "QuadPaySDK"
    #if COCOAPODS
      let bundleName = moduleName
    #else
      let bundleName = "\(moduleName)_\(moduleName)"
    #endif

    let candidates = [
      // Bundle should be present here when the package is linked into an App.
      Bundle.main.resourceURL,

      // Bundle should be present here when the package is linked into a framework.
      Bundle(for: BundleFinder.self).resourceURL,

      // For command-line tools.
      Bundle.main.bundleURL,
    ]

    for candidate in candidates {
      let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
      if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
        return bundle
      }
    }

    let bundle2 = Bundle(for: BundleFinder.self)
    return bundle2
  }()
}
