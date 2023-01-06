//
//  QuadPayWidget.swift
//  QuadPaySDK
//
//  Created by Lai Tang on 22/06/2022.
//

import Foundation
import UIKit

/// Implementing this delegate protocol allows launching of the info link modally in app.
public protocol QuadPayWidgetComponentDelegate: AnyObject {

  /// The view controller for which the modal info web view controller should be presented on.
  /// - Returns: The view controller for modal presentation.
  func viewControllerForPresentation() -> UIViewController

}

/// A view that displays informative text, the Afterpay badge and an info link. The info link will
/// launch externally by default but can launch modally in app by implementing
/// PriceBreakdownViewDelegate. This view updates in response to Afterpay configuration changes
/// as well as changes to the `totalAmount`.
@available(iOS 10.0, *)
@available(iOS 12.0, *)
public final class QuadPayWidgetComponent: UIView {

  /// The price breakdown view delegate. Not setting this delegate will cause the info link to open
  /// externally.
    public weak var delegate: QuadPayWidgetComponentDelegate?
    
    public var grayLabelMerchant: Bool = false{
        didSet{
            updateAttributedText()
        }
    }
    
    @objc public var displayMode: String = ""{
        didSet{
          updateAttributedText()
        }
    }
    
    @objc public var isMFPPMerchant: String = ""{
        didSet{
            updateAttributedText()
        }
    }
    
    @objc public var minModal: String = "false"{
        didSet{
            updateAttributedText()
        }
    }
    
    @objc public var learnMoreUrl: String = ""{
        didSet{
            updateAttributedText()
        }
    }
    
    @objc public var merchantId: String = ""{
        didSet{
            updateAttributedText()
        }
    }
    
    
    @objc public var logoOption: String = "logo_main"{
        didSet{
          updateAttributedText()
        }
    }
    
    @objc public var logoSize: String = "100%"{
        didSet{
          updateAttributedText()
        }
    }
  
    @objc public var size: String = "100%"{
      didSet{
          updateAttributedText()
      }
  }
  
   @objc public var min:String = "35" {
      didSet{
          updateAttributedText()
      }
  }
  
   @objc public var max: String = "1500"{
      didSet{
          updateAttributedText()
      }
  }
  
    @objc public var amount: String = "" {
      didSet {
        updateAttributedText()
      }
  }
  
    @objc public var colorPrice: String = ""{
      didSet{
          updateAttributedText()
      }
  }
    
    @objc public var alignment: String = "left"{
        didSet{
            updateAttributedText()
        }
    }

  public var textColor: UIColor = {
      if #available(iOS 13.0, *) {
        return .label
      } else {
        return .black
      }
  }()

  public var linkColor: UIColor = {
    if #available(iOS 13.0, *) {
      return .secondaryLabel
    } else {
      return UIColor(red: 60 / 255, green: 60 / 255, blue: 67 / 255, alpha: 0.6)
    }
  }()

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

  public var logoType: LogoType = .badge {
    didSet { updateAttributedText() }
  }

  public var fontProvider: (UITraitCollection) -> UIFont = { traitCollection in
    .preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
  }

  public var moreInfoOptions: MoreInfoOptions = MoreInfoOptions() {
    didSet { updateAttributedText() }
  }
    

  private let linkTextView = LinkTextView()

    private var infoLink: URL {
        let urlPath = Bundle.qpResource.path(forResource: "index", ofType: "html", inDirectory: "www")
        let url  = URL(fileURLWithPath: urlPath!)
        return url

    }
    
    private var contentHtml: String{
        let urlPath = Bundle.qpResource.path(forResource: "index", ofType: "html", inDirectory: "www")
        do{
            var strHTMLContent = try String(contentsOfFile: urlPath!)
            strHTMLContent = strHTMLContent.replacingOccurrences(of: "%learnMoreUrl%", with: learnMoreUrl)
            strHTMLContent = strHTMLContent.replacingOccurrences(of: "%merchantId%", with: merchantId)
            strHTMLContent = strHTMLContent.replacingOccurrences(of: "%isMFPPMerchant%", with: isMFPPMerchant)
            strHTMLContent = strHTMLContent.replacingOccurrences(of: "%minModal%", with: String(minModal))
            let quadpayJS : String = "https://cdn.us.zip.co/v1/quadpay.js"
            
            strHTMLContent = strHTMLContent.replacingOccurrences(of: "%QuadPayJS%", with: quadpayJS)
            return strHTMLContent
        }
        catch let err{
            print(err)
            return ""
        }

    }

      public init() {
        super.init(frame: .zero)
        sharedInit()
      }


    required init?(coder: NSCoder) {
      super.init(coder: coder)
      sharedInit()
    }
    
   


    private func sharedInit() {
        linkTextView.linkHandler = { [weak self ] url in
          if let viewController = self?.delegate?.viewControllerForPresentation() {
              let infoWebViewController = InfoWebViewController(infoURL: url, contentHtml: self?.contentHtml ?? "")
            let navigationController = UINavigationController(rootViewController: infoWebViewController)
            viewController.present(navigationController, animated: true, completion: nil)
          } else if let rnController = self?.ReactNativeController(){
              let infoWebViewController = InfoWebViewController(infoURL: url, contentHtml: self?.contentHtml ?? "")
            let navigationController = UINavigationController(rootViewController: infoWebViewController)
              rnController.present(navigationController, animated: true, completion: nil)
            } else {
                  UIApplication.shared.open(url)
              }
          }
        

      addSubview(linkTextView)

      NSLayoutConstraint.activate([
        linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
        linkTextView.topAnchor.constraint(equalTo: topAnchor),
        linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
        linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
      ])
    }
    
    func ReactNativeController() -> UIViewController {
        var reactNativeController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!

        while (reactNativeController.presentedViewController != nil) {
            reactNativeController = reactNativeController.presentedViewController!
        }
        return reactNativeController
    }
    
    
    @available(iOS 15.0, *)
    private func fetchMerchantConfig() async -> Result<MerchantConfig, Error>{
        if(merchantId == ""){
            return .failure(MyError.failedToGetMerchantConfig)
        }
        
        do{
            let merchantConfigUrl: String = "https://qpmerchconfigsprd.blob.core.windows.net/merchant-configs/"
            let url = URL(string: (merchantConfigUrl + merchantId + ".json"))
            let (data,_) = try await URLSession.shared.data(from: url!)
  
            let merchantConfigData = try JSONDecoder().decode(MerchantConfig.self, from: data)
           
            return .success(merchantConfigData)
        }
        catch{
            return .failure(MyError.failedToGetMerchantConfig)
        }
    }
    
    

    private func updateAttributedText() {
      var widget_Text = "4 easy payments of"
    
        
        if #available(iOS 13.0, *) {
            Task {
                if #available(iOS 15.0, *) {
                    let result = await fetchMerchantConfig()
                    switch result{
                    case .success(_):
                        grayLabelMerchant = true
                        
                    case.failure(_):
                        grayLabelMerchant = false
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }

      let logoView =  ZipPayLogo(logoOption: logoOption)

      let font: UIFont = fontProvider(traitCollection)
      var fontHeight = (font.ascender - font.descender)
      
      fontHeight = fontHeight * CheckSize(size: size)
      let logoHeight =  CGFloat(logoType.heightMultiplier)

      let logoRatio = logoView.ratio ?? 1

      let widthFittingFont = logoHeight / logoRatio
      let width = widthFittingFont > logoView.minimumWidth ? widthFittingFont : logoView.minimumWidth
      let logoSize = CGSize(width: width * CheckSize(size: logoSize), height: width * logoRatio * CheckSize(size: logoSize))

      logoView.frame = CGRect(origin: .zero, size: logoSize)

      let textAttributes: [NSAttributedString.Key: Any] = [
        .font: font.withSize(fontHeight),
        .foregroundColor: textColor as UIColor,
      ]
        
    let poweredByAttributes: [NSAttributedString.Key: Any] = [
          .font: font.withSize(12),
          .foregroundColor: textColor as UIColor,
        ]

        let amountColor = UIColor(hexString: colorPrice)
        
      let amountAttribute: [NSAttributedString.Key: Any] = [
        .font: font.withSize(fontHeight),
        .foregroundColor: amountColor
      ]
        
      linkTextView.linkTextAttributes = [
        .underlineStyle: NSUnderlineStyle.double.rawValue,
        .foregroundColor: linkColor,
      ]

      let attributedString = NSMutableAttributedString()
    
      let badge: NSAttributedString = {
        let attachment = NSTextAttachment()
        attachment.image = logoView.image

        let centerY = fontHeight / 2
        let yPos = centerY - (logoView.frame.height / 2) + (font.descender * CGFloat(logoType.descenderMultiplier))

        attachment.bounds = CGRect(origin: .init(x: 0, y: yPos), size: logoView.bounds.size)
        attachment.isAccessibilityElement = true
        attachment.accessibilityLabel = logoView.accessibilityLabel
        return .init(attachment: attachment)
      }()

    let space = NSAttributedString(string: " ", attributes: textAttributes)

    let formatter = NumberFormatter()
      formatter.maximumFractionDigits = 2
      formatter.minimumFractionDigits = 0
      formatter.currencyCode="USD"
      formatter.numberStyle = .currency
    
    var amountString :String
    let amountt  = Double(amount) ?? 0.00
        let min  = Double(min) ?? 35.00
        let max = Double(max) ?? 1500.00
    if(amountt<min){
      widget_Text = "4 payments on order over"
            amountString = formatter.string(for:Float(min)) ?? "?"
        }else if(amountt>max){
      widget_Text = " 4 payments on order up to"
            amountString = formatter.string(for:Float(max)) ?? "?"
    }else{
      widget_Text = "4 easy payments of"
        
      amountString = formatter.string(for: amountt/4) ?? "?"
    }
    
    let widgetText = NSAttributedString(string: widget_Text, attributes: textAttributes)
    
    let with = NSAttributedString(string:"with", attributes: textAttributes)
        
    let poweredBy = NSAttributedString(string:"powered by", attributes: poweredByAttributes)
        
    let amount = NSAttributedString(string: amountString, attributes: amountAttribute)
        
    var badgeAndBreakdown = [space]
    if(displayMode=="logoFirst" && !grayLabelMerchant){
        badgeAndBreakdown = [badge,space, widgetText, space, amount]
    }else{
        if(grayLabelMerchant){
            let merchantLogo =  ZipPayLogo(logoOption: "welcome_pay")
            let merchantLogoHeight =  CGFloat(logoType.heightMultiplier)
       
            let merchantRatio = merchantLogo.ratio ?? 1

            let widthMerchantFittingFont = merchantLogoHeight / merchantRatio
            let width = widthMerchantFittingFont > merchantLogo.minimumWidth ? widthMerchantFittingFont : merchantLogo.minimumWidth
            //print(width)
            //print(logoRatio)
            let merchantSize = CGSize(width: width+30, height: width * logoRatio)

            merchantLogo.frame = CGRect(origin: .zero, size: merchantSize)
            
            let merchantBadge: NSAttributedString = {
              let attachment = NSTextAttachment()
              attachment.image = merchantLogo.image

              let centerY = fontHeight / 2
              let yPos = centerY - (merchantLogo.frame.height / 2) + (font.descender * CGFloat(logoType.descenderMultiplier))

              attachment.bounds = CGRect(origin: .init(x: 0, y: yPos), size: merchantLogo.bounds.size)
              attachment.isAccessibilityElement = true
              attachment.accessibilityLabel = merchantLogo.accessibilityLabel
              return .init(attachment: attachment)
            }()
            badgeAndBreakdown = [widgetText, space, amount,space, with, space, merchantBadge, space, poweredBy, space, badge]
        }else{
            badgeAndBreakdown = [widgetText, space, amount,space, with, space, badge]
        }
        
    }
    
      
    let linkConfig = moreInfoOptions.modalLinkStyle.styleConfig
    let linkStyleAttributes = textAttributes.merging(linkConfig.attributes) { $1 }
    let linkAttributes = linkStyleAttributes.merging([.link: infoLink]) { $1 }

    let link: NSMutableAttributedString? = {
      if linkConfig.customContent != nil {
        return linkConfig.customContent! as? NSMutableAttributedString
      } else if linkConfig.text != nil {
        return .init(string: linkConfig.text!)
      } else if let image = linkConfig.image, let renderMode = linkConfig.imageRenderingMode {
        let attachment = NSTextAttachment()
        let imageRatio = image.size.width / image.size.height
        let attachmentHeight = fontHeight * 0.8

        attachment.image = image.withRenderingMode(renderMode)
        attachment.bounds = CGRect(
          origin: .init(x: 0, y: font.descender * 0.6),
          size: CGSize(width: attachmentHeight * imageRatio * 150/100, height: attachmentHeight * 150/100)
        )
        return .init(attachment: attachment)
      }

      return nil
    }()

    if link != nil {
      link?.addAttributes(linkAttributes, range: NSRange(location: 0, length: link!.length))
    }

    let strings = (link != nil) ? badgeAndBreakdown + [space, link!] : badgeAndBreakdown

    strings.forEach(attributedString.append)

    linkTextView.attributedText = attributedString
    linkTextView.textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
        switch alignment {
        case "left":
            linkTextView.textAlignment = NSTextAlignment.left
        case "right":
            linkTextView.textAlignment = NSTextAlignment.right
        case "center":
            linkTextView.textAlignment = NSTextAlignment.center
        default:
            linkTextView.textAlignment = NSTextAlignment.center
        }
        
  }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    let userInterfaceStyle = traitCollection.userInterfaceStyle
    let previousUserInterfaceStyle = previousTraitCollection?.userInterfaceStyle
    let contentSizeCategory = traitCollection.preferredContentSizeCategory
    let previousContentSizeCategory = previousTraitCollection?.preferredContentSizeCategory

    let userInterfaceStyleChanged = previousUserInterfaceStyle != userInterfaceStyle
    let contentSizeCategoryChanged = previousContentSizeCategory != contentSizeCategory

    if userInterfaceStyleChanged || contentSizeCategoryChanged {
      updateAttributedText()
    }
  }
    
    private func CheckSize(size:String) -> CGFloat{
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
}

extension UIImageView {
    func downloaded(urlString: String) {
        guard let url = URL(string: urlString) else{
            return
        }
        DispatchQueue.global().async{ [weak self] in
            if let data = try? Data(contentsOf:url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async{
                        self?.image = image
                    }
                }
            }
        }
    }
}

@available(iOS 10.0, *)
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
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

struct MerchantConfig: Codable{
    var LogoUrl : String
}

enum MyError:Error{
    case failedToGetMerchantConfig
}
