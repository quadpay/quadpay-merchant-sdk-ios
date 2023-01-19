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
            hideHeaders()
        }
    }
    
    @objc public var amount: String = "0" {
        didSet{
            hideHeaders()
        }
    }
    
    @objc public var timelapseColor: String = "" {
        didSet{
            hideHeaders()
        }
    }
    
    @objc public var hideHeader: Bool = false {
        didSet{
            hideHeaders()
        }
    }
    
    @objc public var hideSubtitle: Bool = false {
        didSet{
            hideHeaders()
        }
    }
    
    @objc public var hideTimeline: Bool = false {
        didSet{
            hideHeaders()
        }
    }
    
    var paymentWidgetHeaderText = PaymentWidgetHeaderText()
    var paymentWidgetSubText = PaymentWidgetSubText()
    var timelapseGraphView = TimelapseGraphView()
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 180)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        style()
   
           // layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PaymentWidget {
    func style(){
        paymentWidgetHeaderText.translatesAutoresizingMaskIntoConstraints = false
        paymentWidgetSubText.translatesAutoresizingMaskIntoConstraints = false
        timelapseGraphView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
        addSubview(paymentWidgetHeaderText)
        addSubview(paymentWidgetSubText)
        addSubview(timelapseGraphView)
        
        NSLayoutConstraint.activate([
            paymentWidgetHeaderText.topAnchor.constraint(equalTo: topAnchor),
            paymentWidgetHeaderText.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: paymentWidgetHeaderText.trailingAnchor, multiplier: 2),
            paymentWidgetSubText.topAnchor.constraint(equalToSystemSpacingBelow: paymentWidgetHeaderText.bottomAnchor, multiplier: 0),
            paymentWidgetSubText.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: paymentWidgetSubText.trailingAnchor, multiplier: 2),
            timelapseGraphView.topAnchor.constraint(equalToSystemSpacingBelow: paymentWidgetSubText.bottomAnchor, multiplier: 0),
            timelapseGraphView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timelapseGraphView.widthAnchor.constraint(equalToConstant: frame.width),
            timelapseGraphView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: timelapseGraphView.trailingAnchor, multiplier: 2)
        ])
    }
    
    func layoutWithoutTimeline(){
        addSubview(paymentWidgetHeaderText)
        addSubview(paymentWidgetSubText)
        
        NSLayoutConstraint.activate([
            paymentWidgetHeaderText.topAnchor.constraint(equalTo: topAnchor),
            paymentWidgetHeaderText.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: paymentWidgetHeaderText.trailingAnchor, multiplier: 2),
            paymentWidgetSubText.topAnchor.constraint(equalToSystemSpacingBelow: paymentWidgetHeaderText.bottomAnchor, multiplier: 0),
            paymentWidgetSubText.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: paymentWidgetSubText.trailingAnchor, multiplier: 2),
        ])
    }
    
    func layoutWithoutHeader(){
        addSubview(paymentWidgetSubText)
        addSubview(timelapseGraphView)
        
        NSLayoutConstraint.activate([
            paymentWidgetSubText.topAnchor.constraint(equalTo: topAnchor),
            paymentWidgetSubText.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: paymentWidgetSubText.trailingAnchor, multiplier: 2),
            timelapseGraphView.topAnchor.constraint(equalToSystemSpacingBelow: paymentWidgetSubText.bottomAnchor, multiplier: 0),
            timelapseGraphView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timelapseGraphView.widthAnchor.constraint(equalToConstant: frame.width),
            timelapseGraphView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: timelapseGraphView.trailingAnchor, multiplier: 2)
        ])
    }
    
    func layoutWithoutSubtitle(){
        addSubview(paymentWidgetHeaderText)
        addSubview(timelapseGraphView)
        
        NSLayoutConstraint.activate([
            paymentWidgetHeaderText.topAnchor.constraint(equalTo: topAnchor),
            paymentWidgetHeaderText.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: paymentWidgetHeaderText.trailingAnchor, multiplier: 2),
            timelapseGraphView.topAnchor.constraint(equalToSystemSpacingBelow: paymentWidgetHeaderText.bottomAnchor, multiplier: 0),
            timelapseGraphView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timelapseGraphView.widthAnchor.constraint(equalToConstant: frame.width),
            timelapseGraphView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: timelapseGraphView.trailingAnchor, multiplier: 2)
        ])
    }
    
    func layoutWithoutBothHeaders(){
        addSubview(timelapseGraphView)
        
        NSLayoutConstraint.activate([
            timelapseGraphView.topAnchor.constraint(equalTo: topAnchor),
            timelapseGraphView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timelapseGraphView.widthAnchor.constraint(equalToConstant: frame.width),
            timelapseGraphView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: timelapseGraphView.trailingAnchor, multiplier: 2)
        ])
    }
    
    func hideHeaders(){
        if(hideHeader && !hideSubtitle){
            layoutWithoutHeader()
        }else if(!hideHeader && hideSubtitle){
            layoutWithoutSubtitle()
        }else if(hideHeader && hideSubtitle){
            layoutWithoutBothHeaders()
        }else if(hideTimeline){
            layoutWithoutTimeline()
        }else {
            layout()
        }
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
                self.paymentWidgetHeaderText.actualPaymentWidgetLabelText = "Split your order in 4 easy payment with Welcome Pay (powered by Zip)."
                self.paymentWidgetHeaderText.style()
                self.timelapseGraphView.depth = 3
            case .failure(_):
                print("Error fetching merchant")
            }}
        timelapseGraphView.drawTimelapseGraph()
    }
}
