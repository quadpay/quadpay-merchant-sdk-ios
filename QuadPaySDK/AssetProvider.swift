//
//  AssetProvider.swift
//  QuadPaySDK
//
//  Created by Lai Tang on 05/07/2022.
//

import Foundation

import UIKit

internal class AssetProvider {
  internal static func image(named: String) -> UIImage? {
      return UIImage(named: named, in: Bundle.qpResource, compatibleWith: nil)
  }
}
