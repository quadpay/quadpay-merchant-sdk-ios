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

@available(iOS 13.0, *)
func makeSymbolImageView(systemName: String, scale: UIImage.SymbolScale = .large) -> UIImageView{
    let configuration = UIImage.SymbolConfiguration(scale: scale)
    let image = UIImage(systemName: systemName, withConfiguration: configuration)
    
    return UIImageView(image: image)
}
