//
//  PaymentWidgetTile.swift
//  QuadPaySDK
//
//  Created by Petros Andreou on 13/01/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import UIKit
import Foundation

public final class PaymentWidget: UIView {
    
    let paymentWidget = PaymentWidgetText()
    let timelapseGraphView = TimelapseGraphView()
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 200)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PaymentWidget {
    func style(){
        paymentWidget.translatesAutoresizingMaskIntoConstraints = false
        timelapseGraphView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
        addSubview(paymentWidget)
        addSubview(timelapseGraphView)
        
        NSLayoutConstraint.activate([
            paymentWidget.topAnchor.constraint(equalTo: topAnchor),
            paymentWidget.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: paymentWidget.trailingAnchor, multiplier: 2),
            timelapseGraphView.topAnchor.constraint(equalToSystemSpacingBelow: paymentWidget.bottomAnchor, multiplier: 0),
            timelapseGraphView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timelapseGraphView.widthAnchor.constraint(equalToConstant: frame.width),
            timelapseGraphView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: timelapseGraphView.trailingAnchor, multiplier: 2)
        ])
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        timelapseGraphView.actualFrameWidth = frame.width
        timelapseGraphView.drawTimelapseGraph()
    }
}
