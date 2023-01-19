//
//  Factories.swift
//  QuadPaySDK
//
//  Created by Petros Andreou on 13/01/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import UIKit

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
}

extension UIColor {
    static let zipBlack = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    static let zipPurple = UIColor(red: 0.67, green: 0.56, blue: 1.00, alpha: 1.00)
}

func makeSymbolImageView(systemName: String, scale: UIImage.SymbolScale = .large) -> UIImageView{
    let configuration = UIImage.SymbolConfiguration(scale: scale)
    let image = UIImage(systemName: systemName, withConfiguration: configuration)
    
    return UIImageView(image: image)
}

func makeHeaderText(headerText : String, link: URL) -> NSAttributedString{
    let moreInfoOptions = MoreInfoOptions()
    
    let attributedString = NSMutableAttributedString(string: headerText)
    
    let space = NSAttributedString(string: " ")
    
    let textAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.black
    ]
    
    let linkConfig = moreInfoOptions.modalLinkStyle.styleConfig
    let linkStyleAttributes = textAttributes.merging(linkConfig.attributes) { $1 }
    let linkAttributes = linkStyleAttributes.merging([.link: link]) { $1 }

    let link: NSMutableAttributedString? = {
      if linkConfig.customContent != nil {
        return linkConfig.customContent! as? NSMutableAttributedString
      } else if linkConfig.text != nil {
        return .init(string: linkConfig.text!)
      } else
        if let image = linkConfig.image, let renderMode = linkConfig.imageRenderingMode {
        let attachment = NSTextAttachment()
        let imageRatio = image.size.width / image.size.height
        let attachmentHeight = 10 * 0.8

        attachment.image = image.withRenderingMode(renderMode)
        attachment.bounds = CGRect(
            origin: .init(x: 0, y: 10 * 0.6),
          size: CGSize(width: attachmentHeight * imageRatio * 150/100, height: attachmentHeight * 150/100)
        )
        return .init(attachment: attachment)
      }

      return nil
    }()
    
    if link != nil {
      link?.addAttributes(linkAttributes, range: NSRange(location: 0, length: link!.length))
        attributedString.append(space)
        attributedString.append(link!)
    }

    return attributedString
}


