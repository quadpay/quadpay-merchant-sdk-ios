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

    public static func jbs_registerFont(withFilenameString filenameString: String, bundle: Bundle) {

           guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: nil, inDirectory: "Font") else {
               print("UIFont+:  Failed to register font - path for resource not found.")
               return
           }

           guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
               print("UIFont+:  Failed to register font - font data could not be loaded.")
               return
           }

           guard let dataProvider = CGDataProvider(data: fontData) else {
               print("UIFont+:  Failed to register font - data provider could not be loaded.")
               return
           }

           guard let font = CGFont(dataProvider) else {
               print("UIFont+:  Failed to register font - font could not be loaded.")
               return
           }

           var errorRef: Unmanaged<CFError>? = nil
           if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == false) {
               print("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
           }
       }
}

extension UIColor {
    static let zipBlack = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    static let zipPurple = UIColor(red: 0.67, green: 0.56, blue: 1.00, alpha: 1.00)
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (hexString.hasPrefix("#")) {
            hexString = String(hexString.dropFirst())
        }
        let scanner = Scanner(string: hexString)
       
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

public enum LogoType {
       case badge
       case lockup
       
       var heightMultiplier: Double {
           switch self {
           case .badge:
               return 1.8
           case .lockup:
               return 1
           }
       }
       
       var descenderMultiplier: Double {
           switch self {
           case .badge:
               return 1
           case .lockup:
               return 1.2
           }
       }
   }

public var logoType: LogoType = .badge

public var infoLink: URL {
    let urlPath = Bundle.qpResource.path(forResource: "index", ofType: "html", inDirectory: "www")
    let url  = URL(fileURLWithPath: urlPath!)
    return url
}

public var fontProvider: (UITraitCollection) -> UIFont = { traitCollection in
        .preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
}

func makeSymbolImageView(systemName: String, scale: UIImage.SymbolScale = .large) -> UIImageView{
    let configuration = UIImage.SymbolConfiguration(scale: scale)
    let image = UIImage(systemName: systemName, withConfiguration: configuration)
    
    return UIImageView(image: image)
}

func updateHtmlContent(learnMoreUrl: String, merchantId: String, isMFPPMerchant: String, minModal: String, hasFees: Bool, bankPartner: String) -> String {
    let urlPath = Bundle.qpResource.path(forResource: "index", ofType: "html", inDirectory: "www")
    do{
        var strHTMLContent = try String(contentsOfFile: urlPath!)
        strHTMLContent = strHTMLContent.replacingOccurrences(of: "%learnMoreUrl%", with: learnMoreUrl)
        strHTMLContent = strHTMLContent.replacingOccurrences(of: "%merchantId%", with: merchantId)
        strHTMLContent = strHTMLContent.replacingOccurrences(of: "%isMFPPMerchant%", with: isMFPPMerchant)
        strHTMLContent = strHTMLContent.replacingOccurrences(of: "%minModal%", with: minModal)
        strHTMLContent = strHTMLContent.replacingOccurrences(of: "%hasFees%", with: String(hasFees))
        strHTMLContent = strHTMLContent.replacingOccurrences(of: "%bankPartner%", with: bankPartner)
  
    
        let quadpayJS : String = Configuration.quadPayJSUrl.absoluteString
        
        strHTMLContent = strHTMLContent.replacingOccurrences(of: "%QuadPayJS%", with: quadpayJS)
        return strHTMLContent
    }
    catch let err{
        print(err)
        return ""
    }
}

func createInfoLink(link:URL) -> NSAttributedString{
    let moreInfoOptions = MoreInfoOptions()
    
    let textAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.zipBlack
    ]
    let attributedString = NSMutableAttributedString(string: "", attributes: textAttributes)
    
    let linkConfig = moreInfoOptions.modalLinkStyle.styleConfig
    let linkStyleAttributes = textAttributes.merging(linkConfig.attributes) { $1 }
    let linkAttributes = linkStyleAttributes.merging([.link: link]) { $1 }
    
    let link: NSMutableAttributedString? = {
        if linkConfig.customContent != nil {
            return linkConfig.customContent! as? NSMutableAttributedString
        } else if linkConfig.text != nil{
            return .init(string: linkConfig.text!)
        } else
        if let image = linkConfig.image, let renderMode = linkConfig.imageRenderingMode{
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
        attributedString.append(link!)
    }

    return attributedString
}

func makeText(text: String, size: String) -> NSAttributedString{
    var textAttributes : [NSAttributedString.Key: Any]
    let font = UIFont.preferredFont(forTextStyle: .body)
    let fontHeight = UIFont.preferredFont(forTextStyle: .body).ascender - UIFont.preferredFont(forTextStyle: .body).descender * CheckSize(size: size)
    
    if(text == "powered by"){
        textAttributes = [
            .foregroundColor: UIColor.zipBlack,
            .font: font.withSize(12)
        ]
    }else{
        textAttributes = [
            .foregroundColor: UIColor.zipBlack,
            .font: font.withSize(fontHeight)
        ]
       
    }
    let attributedString = NSMutableAttributedString(string: text, attributes: textAttributes)
        return attributedString
}

func makeAmountText(text: String, color: UIColor, size: String ) -> NSAttributedString{
    let font = UIFont.preferredFont(forTextStyle: .body)
    let fontHeight = UIFont.preferredFont(forTextStyle: .body).ascender - UIFont.preferredFont(forTextStyle: .body).descender * CheckSize(size: size)
    let textAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: color,
        .font: font.bold().withSize(fontHeight)
    ]
    let attributedString = NSMutableAttributedString(string: text, attributes: textAttributes)
    return attributedString
}


func createLogo(logoOption: String, logoSize: String) -> NSAttributedString{
    let logoView =  ZipPayLogo(logoOption: logoOption)
    let logoHeight = CGFloat(logoType.heightMultiplier)
    let logoRatio = logoView.ratio ?? 1
    let widthFittingFont = logoHeight / logoRatio
    let width = widthFittingFont > logoView.minimumWidth ? widthFittingFont : logoView.minimumWidth
    let logoSize = CGSize(width: width * CheckSize(size: logoSize), height: width * logoRatio * CheckSize(size: logoSize))
    
    let fontDescender = UIFont.preferredFont(forTextStyle: .body).descender
    let fontAscender = UIFont.preferredFont(forTextStyle: .body).ascender
    let fontHeight = fontAscender - fontDescender
    
    logoView.frame = CGRect(origin: .zero, size: logoSize)
    
    let badge: NSAttributedString = {
        let attachment = NSTextAttachment()
        attachment.image = logoView.image
        
        let centerY = fontHeight / 2
        var yPos: CGFloat = 0.0
        if(logoOption.lowercased() == "secondary" || logoOption.lowercased() == "secondary-light"){
            yPos = centerY - (logoView.frame.height / 2) + (fontDescender * CGFloat(logoType.descenderMultiplier))
        }else{
            yPos = centerY - (logoView.frame.height / 2)
        }
        attachment.bounds = CGRect(origin: .init(x: 0, y: yPos), size: logoView.bounds.size)
        attachment.isAccessibilityElement = true
        attachment.accessibilityLabel = logoView.accessibilityLabel
        return .init(attachment: attachment)
    }()
    
    return badge
    
}

func createMerchantLogo() -> NSAttributedString{
    let logoView =  ZipPayLogo(logoOption: "logo_main")
    let logoRatio = logoView.ratio ?? 1
    let merchantLogo =  ZipPayLogo(logoOption: "welcome_pay")
    let merchantLogoHeight =  CGFloat(logoType.heightMultiplier)
    
    let merchantRatio = 0.37
    let fontDescender = UIFont.preferredFont(forTextStyle: .body).descender
    let fontAscender = UIFont.preferredFont(forTextStyle: .body).ascender
    let fontHeight = fontAscender - fontDescender
    
    let widthMerchantFittingFont = merchantLogoHeight / logoRatio
    let width = widthMerchantFittingFont > merchantLogo.minimumWidth ? widthMerchantFittingFont : merchantLogo.minimumWidth

    let merchantSize = CGSize(width: width+50, height: width * merchantRatio)
    
    merchantLogo.frame = CGRect(origin: .zero, size: merchantSize)
    
    let merchantBadge: NSAttributedString = {
        let attachment = NSTextAttachment()
        attachment.image = merchantLogo.image
        
        let centerY = fontHeight / 2
        let yPos = centerY - (merchantLogo.frame.height / 2) + (fontDescender * CGFloat(logoType.descenderMultiplier))
        
        attachment.bounds = CGRect(origin: .init(x: 0, y: yPos), size: merchantLogo.bounds.size)
        attachment.isAccessibilityElement = true
        attachment.accessibilityLabel = merchantLogo.accessibilityLabel
        return .init(attachment: attachment)
    }()
    
    return merchantBadge
}

func CheckSize(size:String) -> CGFloat{
    var sizeValue = Int(size.replacingOccurrences(of: "%", with: "")) ?? 100
    if (sizeValue >= 120)
    {
        sizeValue = 120
    }
    else if(sizeValue <= 80){
        sizeValue = 80
    }
    return CGFloat(sizeValue)/CGFloat(100)
}

func makeHeaderText(headerText : String, link: URL) -> NSAttributedString{
    let moreInfoOptions = MoreInfoOptions()
    
    let attributedString = NSMutableAttributedString(string: headerText)
    
    let textAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.zipBlack,
        .font: UIFont.preferredFont(forTextStyle: .body)
        
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
        attributedString.append(link!)
    }

    return attributedString
}


