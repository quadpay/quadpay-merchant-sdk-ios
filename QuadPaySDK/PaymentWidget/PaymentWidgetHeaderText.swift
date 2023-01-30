//
//  PaymentWidgetHeaderText.swift
//  QuadPaySDK
//
//  Created by Petros Andreou on 27/01/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//


import Foundation
import UIKit

/// A view that displays informative text, the Afterpay badge and an info link. The info link will
/// launch externally by default but can launch modally in app by implementing
/// PriceBreakdownViewDelegate. This view updates in response to Afterpay configuration changes
/// as well as changes to the `totalAmount`.
@available(iOS 10.0, *)
@available(iOS 12.0, *)
public final class PaymentWidgetHeaderText: UIView {
    
    var paymentWidgetLabel = LinkTextView()
    
    var initialPaymentWidgetLabelText : String = "Split your order in 4 easy payments with Zip."
    var actualPaymentWidgetLabelText : String?
    
    var initialLearnMoreUrl : String = ""
    var learnMoreUrl : String?
    
    var initialIsMFPPMerchant : String = ""
    var isMFPPMerchant : String?
    
    var initialMinModal : String = ""
    var minModal : String?
    
    var initialMerchantId : String = ""
    var merchantId : String?
    
    var contentHtml: String = ""
    
    private var infoLink: URL {
        let urlPath = Bundle.qpResource.path(forResource: "index", ofType: "html", inDirectory: "www")
        let url  = URL(fileURLWithPath: urlPath!)
        return url
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension PaymentWidgetHeaderText {
    
    func style(){
        let headerText = makeHeaderText(headerText: actualPaymentWidgetLabelText ?? initialPaymentWidgetLabelText, link: infoLink)
        contentHtml = updateHtmlContent(learnMoreUrl: learnMoreUrl ?? initialLearnMoreUrl, merchantId: merchantId ?? initialMerchantId, isMFPPMerchant: isMFPPMerchant ?? initialIsMFPPMerchant, minModal: minModal ?? initialMinModal)
        paymentWidgetLabel.linkHandler = { [weak self ] url in
            if let rnController = self?.ReactNativeController(){
                let infoWebViewController = InfoWebViewController(infoURL: url, contentHtml: self?.contentHtml ?? "")
            let navigationController = UINavigationController(rootViewController: infoWebViewController)
              rnController.present(navigationController, animated: true, completion: nil)
            } else {
                  UIApplication.shared.open(url)
              }
          }
  
        paymentWidgetLabel.translatesAutoresizingMaskIntoConstraints  = false
        paymentWidgetLabel.font = UIFont.preferredFont(forTextStyle: .body).bold()
        paymentWidgetLabel.attributedText = headerText
        paymentWidgetLabel.font = UIFont.preferredFont(forTextStyle: .body)
        paymentWidgetLabel.linkTextAttributes = [
            .foregroundColor: UIColor.zipBlack,
        ]
    }
    
    func layout(){
        addSubview(paymentWidgetLabel)

        NSLayoutConstraint.activate([
            paymentWidgetLabel.topAnchor.constraint(equalTo: topAnchor),
            paymentWidgetLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            paymentWidgetLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            paymentWidgetLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func ReactNativeController() -> UIViewController {
        var reactNativeController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
            
        while (reactNativeController.presentedViewController != nil) {
            reactNativeController = reactNativeController.presentedViewController!
        }
        return reactNativeController
    }
    
}

