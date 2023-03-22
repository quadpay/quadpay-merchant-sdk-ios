//
//  LinkTextView.swift
//  QuadPaySDK
//
//  Created by Lai Tang on 22/06/2022.
//

import Foundation
import UIKit

final class LinkTextView: UITextView, UITextViewDelegate {

  var linkHandler: ((URL) -> Void)?

  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    translatesAutoresizingMaskIntoConstraints = false
    isEditable = false
    isScrollEnabled = false
    textContainerInset = .zero
    self.textContainer.lineFragmentPadding = .zero
    layoutManager.usesFontLeading = false
    backgroundColor = .clear
    delegate = self
  }

  // Override point inside to prevent interaction with anything that isn't the link.
  // Unfortunately implementing UITextViewDelegate textView(_:shouldInteractWith:in:interaction:)
  // for NSTextAttachments isn't enough to prevent drag and drop being initiated
  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let index = layoutManager.characterIndex(
      for: point,
      in: textContainer,
      fractionOfDistanceBetweenInsertionPoints: nil
    )

    let attribute = attributedText.attribute(.link, at: index, effectiveRange: nil)

    return attribute != nil
  }

  // MARK: UITextViewDelegate

  public func textViewDidChangeSelection(_ textView: UITextView) {
    textView.selectedTextRange = nil
  }

    @available(iOS 10.0, *)
    func textView(
    _ textView: UITextView,
    shouldInteractWith textAttachment: NSTextAttachment,
    in characterRange: NSRange,
    interaction: UITextItemInteraction
  ) -> Bool {
    false
  }

    @available(iOS 10.0, *)
    func textView(
    _ textView: UITextView,
    shouldInteractWith URL: URL,
    in characterRange: NSRange,
    interaction: UITextItemInteraction
  ) -> Bool {
    linkHandler?(URL)
    return false
  }

  // MARK: Unavailable

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

