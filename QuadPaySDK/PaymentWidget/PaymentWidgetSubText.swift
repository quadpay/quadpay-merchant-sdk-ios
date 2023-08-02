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
        //Had to enable the font here since is getting initialized on calling the Subtitle and since
        //there is no change to it redraw for it is not getting called. Since no parameters are coming
        //here
        UIFont.jbs_registerFont(
            withFilenameString: "SharpGroteskBook20.ttf",
            bundle: Bundle.qpResource
        )
        
        paymentWidgetSubLabel.translatesAutoresizingMaskIntoConstraints = false
        
        paymentWidgetSubLabel.text = "You will be redirected to Zip to complete your order."
        paymentWidgetSubLabel.font = UIFont(name: "SharpGroteskBook20", size: 12)
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

