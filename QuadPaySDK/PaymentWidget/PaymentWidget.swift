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
            updateWidget()
        }
    }
    
    @objc public var amount: String = "0" {
        didSet{
            updateWidget()
        }
    }
    
    @objc public var timelineColor: String = "" {
        didSet{
            updateWidget()
        }
    }
    
    @objc public var hideHeader: String = "false" {
        didSet{
            updateWidget()
        }
    }
    
    @objc public var hideSubtitle: String = "false" {
        didSet{
            updateWidget()
        }
    }
    
    @objc public var hideTimeline: String = "false" {
        didSet{
            updateWidget()
        }
    }
    
    @objc public var  isMFPPMerchant: String = ""{
        didSet{
            updateWidget()
        }
    }
    
    @objc public var learnMoreUrl: String = ""{
        didSet{
            updateWidget()
        }
    }
    
    @objc public var minModal: String = "" {
        didSet{
            updateWidget()
        }
    }
    
    var paymentWidgetHeaderText = PaymentWidgetHeaderText()
    var paymentWidgetSubText = PaymentWidgetSubText()
    var timelapseGraphView = TimelapseGraphView()
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        updateWidget()
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
            trailingAnchor.constraint(equalToSystemSpacingAfter: timelapseGraphView.trailingAnchor, multiplier: 2),
            timelapseGraphView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
    

    func updateWidget(){
        if(hideHeader == "true" && hideSubtitle == "false"){
            layoutWithoutHeader()
        }else if(hideHeader == "false" && hideSubtitle == "true"){
            layoutWithoutSubtitle()
        }else if(hideHeader == "true" && hideSubtitle == "true" ){
            layoutWithoutBothHeaders()
        }else if(hideTimeline == "false" && hideHeader == "false"){
            layout()
        }
    }
    
    
    //Redraw timelapse
    override public func layoutSubviews() {
        super.layoutSubviews()
        //Pass parameters {amount} in the timelapse graph
        if(hideTimeline == "true"){
            //Hiding the timeline by removing the width.
            timelapseGraphView.actualFrameWidth = 0
        }else{
            timelapseGraphView.actualFrameWidth = frame.width
            timelapseGraphView.amount = amount
            if(timelineColor.lowercased() == "black") {
                timelapseGraphView.actualTimelineColor = UIColor.zipBlack.cgColor
            }else {
                timelapseGraphView.actualTimelineColor = UIColor.zipPurple.cgColor
            }
        }
     
        timelapseGraphView.drawTimelapseGraph()
        
        
        //Passed parameters to the header for pop up
        //{minModal, merchantId,isMFPPMerchant, learnmoreURL}
        paymentWidgetHeaderText.minModal = minModal
        paymentWidgetHeaderText.merchantId = merchantId
        paymentWidgetHeaderText.isMFPPMerchant = isMFPPMerchant
        paymentWidgetHeaderText.learnMoreUrl = learnMoreUrl
        MerchantService.shared.fetchMerchants(merchantId: merchantId){ (result) in
            switch result {
            case .success(_):
                self.paymentWidgetHeaderText.actualPaymentWidgetLabelText = "Split your order in 4 easy payments with Welcome Pay (powered by Zip)."
                self.paymentWidgetHeaderText.style()
                self.timelapseGraphView.depth = 0
                self.timelapseGraphView.drawTimelapseGraph()
            case .failure(_):
                self.paymentWidgetHeaderText.actualPaymentWidgetLabelText = "Split your order in 4 easy payments with Zip."
                self.timelapseGraphView.depth = 3
                DispatchQueue.main.async {
                    self.paymentWidgetHeaderText.style()
                    self.timelapseGraphView.drawTimelapseGraph()
                }
                
                print("Error fetching merchant")
            }}
        
        

    }
}
