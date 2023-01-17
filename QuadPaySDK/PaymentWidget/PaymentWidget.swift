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
    
    @objc public var merchantId: String = "" {
        didSet{
            style()
            layout()
        }
    }
    
    @objc public var amount: String = "" {
        didSet{
            style()
            layout()
        }
    }
    
    @objc public var timelapseColor: String = "" {
        didSet{
            style()
            layout()
        }
    }
    
    var paymentWidgetText = PaymentWidgetText()
    var timelapseGraphView = TimelapseGraphView()
    
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
        paymentWidgetText.translatesAutoresizingMaskIntoConstraints = false
        timelapseGraphView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
        addSubview(paymentWidgetText)
        addSubview(timelapseGraphView)
        
        NSLayoutConstraint.activate([
            paymentWidgetText.topAnchor.constraint(equalTo: topAnchor),
            paymentWidgetText.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: paymentWidgetText.trailingAnchor, multiplier: 2),
            timelapseGraphView.topAnchor.constraint(equalToSystemSpacingBelow: paymentWidgetText.bottomAnchor, multiplier: 0),
            timelapseGraphView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timelapseGraphView.widthAnchor.constraint(equalToConstant: frame.width),
            timelapseGraphView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: timelapseGraphView.trailingAnchor, multiplier: 2)
        ])
    }
    
    
    //Redraw timelapse
    override public func layoutSubviews() {
        super.layoutSubviews()
        timelapseGraphView.actualFrameWidth = frame.width
        timelapseGraphView.amount = amount
        if(timelapseColor == "black") {
            timelapseGraphView.actualTimelapseColor = UIColor.zipBlack.cgColor
        }
        MerchantService.shared.fetchMerchants(merchantId: merchantId){ (result) in
            switch result {
            case .success(_):
                self.paymentWidgetText.paymentWidgetLabel.text = "Split your order in 4 easy payment with Welcome Pay (powered by Zip)."
                self.timelapseGraphView.depth = 3
            case .failure(_):
                print("Error fetching merchant")
            }}
        timelapseGraphView.drawTimelapseGraph()
    }
}
