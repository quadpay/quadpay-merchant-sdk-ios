//
//  PaymentWidgetSubText.swift
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
public final class PaymentWidgetSubText: UIView {
    

    let paymentWidgetSubLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func style(){
        paymentWidgetSubLabel.translatesAutoresizingMaskIntoConstraints = false
        paymentWidgetSubLabel.text = "You will be redirected to Zip to complete your order."
        paymentWidgetSubLabel.textColor = .gray
        paymentWidgetSubLabel.numberOfLines = 0
        paymentWidgetSubLabel.lineBreakMode = .byWordWrapping
    }
    
    func layout(){
        
        addSubview(paymentWidgetSubLabel)

      NSLayoutConstraint.activate([
        paymentWidgetSubLabel.topAnchor.constraint(equalTo: topAnchor),
        paymentWidgetSubLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        paymentWidgetSubLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        paymentWidgetSubLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
    }
    
}

