//
//  MoreInfoOptions.swift
//  QuadPaySDK
//
//  Created by Lai Tang on 23/06/2022.
//

import Foundation

public struct MoreInfoOptions {
  public var modalLinkStyle: ModalLinkStyle = .circledInfoIcon
  public var modalId: String?

  /**
  Set up options for the more info link in AfterpayPriceBreakdown

  - Parameter modalId: the filename of a modal hosted on Afterpay static
  */
  public init(
    modalId: String? = nil,
    modalLinkStyle: ModalLinkStyle = .circledInfoIcon
  ) {
    self.modalId = modalId
    self.modalLinkStyle = modalLinkStyle
  }

  /**
  Set up options for the more info link in AfterpayPriceBreakdown

  **Notes:**
  - Not all combinations of Locales and CBT are available.

  - Parameter modalTheme: the color theme used when displaying the modal
  - Parameter isCbtEnabled: whether to show the Cross Border Trade details in the modal
  */
  public init(
    modalLinkStyle: ModalLinkStyle = .circledInfoIcon
  ) {
    self.modalLinkStyle = modalLinkStyle
  }

  func modalFile() -> String {
    if self.modalId != nil {
      return "\(self.modalId!).html"
    }

    return "https://laitangzip.github.io/"
  }
}

