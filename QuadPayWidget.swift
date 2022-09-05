//
//  QuadPayWidget.swift
//  QuadPaySDK
//
//  Created by Lai Tang on 22/06/2022.
//

import Foundation
import UIKit

/// Implementing this delegate protocol allows launching of the info link modally in app.
public protocol PriceBreakdownViewDelegate: AnyObject {

  /// The view controller for which the modal info web view controller should be presented on.
  /// - Returns: The view controller for modal presentation.
  func viewControllerForPresentation() -> UIViewController

}

/// A view that displays informative text, the Afterpay badge and an info link. The info link will
/// launch externally by default but can launch modally in app by implementing
/// PriceBreakdownViewDelegate. This view updates in response to Afterpay configuration changes
/// as well as changes to the `totalAmount`.
public final class PriceBreakdownView: UIView {

  /// The price breakdown view delegate. Not setting this delegate will cause the info link to open
  /// externally.
  public weak var delegate: PriceBreakdownViewDelegate?
  
  public var displayMode:String = ""{
      didSet{
          updateAttributedText()
      }
  }
    
    public var isMFPPMerchant:String = ""{
        didSet{
            updateAttributedText()
        }
    }
    
    public var minModal: Bool = false{
        didSet{
            updateAttributedText()
        }
    }
    
    public var learnMorUrl: String = ""{
        didSet{
            updateAttributedText()
        }
    }
    
    public var merchantId:String = ""{
        didSet{
            updateAttributedText()
        }
    }
    
    
  public var logoOption: String = "logo_main"{
      didSet{
          updateAttributedText()
      }
  }
    
  public var logoSize = "100%"{
      didSet{
          updateAttributedText()
      }
  }
  
    public var size = "100%"{
      didSet{
          updateAttributedText()
      }
  }
  
  public var min = 35 {
      didSet{
          updateAttributedText()
      }
  }
  
  public var max = 1500{
      didSet{
          updateAttributedText()
      }
  }
  
  public var totalAmount: Float = .zero {
      didSet {
        updateAttributedText()
      }
  }
  
  public var priceColor: String = ""{
      didSet{
          updateAttributedText()
      }
  }
    
    public var alignment: String = "left"{
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

    private var infoLink: String {
        let urlPath = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "Resources")
        let url  = URL(fileURLWithPath: urlPath!)
        //return urlPath!
        
        return "https://static.afterpay.com/modal/en_US.html"
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
      linkTextView.linkHandler = { [weak self] url in
        if let viewController = self?.delegate?.viewControllerForPresentation() {
          let infoWebViewController = InfoWebViewController(infoURL: url)
          let navigationController = UINavigationController(rootViewController: infoWebViewController)
          viewController.present(navigationController, animated: true, completion: nil)
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

    @objc private func configurationDidChange() {
      DispatchQueue.main.async {
        self.updateAttributedText()
      }
    }

    private func updateAttributedText() {
      var widget_Text = "4 easy payments of"
        
      let logoView =  ZipPayLogo(logoOption1: logoOption)

      let font: UIFont = fontProvider(traitCollection)
      var fontHeight = (font.ascender - font.descender)
      let sizePercentage =  Int(size.replacingOccurrences(of: "%", with: "")) ?? 100
        let logoSizePercentage = Int(logoSize.replacingOccurrences(of: "%", with:"")) ?? 100
      fontHeight = fontHeight * CGFloat(sizePercentage)/CGFloat(100)
      let logoHeight =  CGFloat(logoType.heightMultiplier)

      let logoRatio = logoView.ratio ?? 1

      let widthFittingFont = logoHeight / logoRatio
      let width = widthFittingFont > logoView.minimumWidth ? widthFittingFont : logoView.minimumWidth
      let logoSize = CGSize(width: width * CGFloat(logoSizePercentage)/CGFloat(100), height: width * logoRatio * CGFloat(logoSizePercentage)/CGFloat(100))

      logoView.frame = CGRect(origin: .zero, size: logoSize)

      let textAttributes: [NSAttributedString.Key: Any] = [
        .font: font.withSize(fontHeight),
        .foregroundColor: textColor as UIColor,
      ]

      let amountColor = UIColor(hex: priceColor)
        
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
    
    if(Int(totalAmount)<min){
      widget_Text = "4 payments on order over"
        amountString = formatter.string(for:min) ?? "?"
    }else if(Int(totalAmount)>max){
      widget_Text = " 4 payments on order up to"
        amountString = formatter.string(for:max) ?? "?"
    }else{
      widget_Text = "4 easy payments of"
      amountString = formatter.string(for: totalAmount/4) ?? "?"
    }
    
    let widgetText = NSAttributedString(string: widget_Text, attributes: textAttributes)
    
    let with = NSAttributedString(string:"with", attributes: textAttributes)
    
    let amount = NSAttributedString(string: amountString, attributes: amountAttribute)
    var badgeAndBreakdown = [space]
    if(displayMode=="logoFirst"){
        badgeAndBreakdown = [badge,space, widgetText, space, amount]
    }else{
        badgeAndBreakdown = [widgetText, space, amount,space, with, space, badge]
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

}

extension UIColor {
    public convenience init(hex:String) {
        let r,g,b,a : CGFloat
        
        if hex.hasPrefix("#"){
            let start  = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber : UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber){
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat((hexNumber & 0x000000ff)) / 255
                    
                    self.init(red:r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        self.init(ciColor: .black)
        return
    }
}
