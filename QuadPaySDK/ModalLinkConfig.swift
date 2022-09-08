//
//  ModalLinkStyle.swift
//  QuadPaySDK
//
//  Created by Lai Tang on 23/06/2022.
//

import Foundation
import UIKit

internal struct ModalLinkConfig {
  var text: String?
  var image: UIImage?
  var imageRenderingMode: UIImage.RenderingMode?
  var customContent: NSAttributedString?
  var attributes: [NSAttributedString.Key: Any] = [:]
}


public enum ModalLinkStyle {
  case circledInfoIcon
  case none


  var styleConfig: ModalLinkConfig {
    switch self {
    case .circledInfoIcon:
      return ModalLinkConfig(
        text: "\u{24D8}",
        attributes: [NSAttributedString.Key.underlineColor: UIColor.clear]
      )
    case .none:
      return ModalLinkConfig()
    }
  }
}
