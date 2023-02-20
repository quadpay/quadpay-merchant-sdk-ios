//
//  PaymentWidgetTile.swift
//  QuadPaySDK
//
//  Created by Petros Andreou on 13/01/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import UIKit
import Foundation

public final class RNPaymentWidget: UIView {
    
    let stackView = UIStackView()
    
    @objc public var merchantId: String = "" {
        didSet{
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
                }}        }
    }
    
    @objc public var amount: String = "0" {
        didSet{
            layoutSubviews()
        }
    }
    
    @objc public var timelineColor: String = "" {
        didSet{
            layoutSubviews()
        }
    }
    
    @objc public var hideHeader: String = "false" {
        didSet{
            layoutSubviews()
        }
    }
    
    @objc public var hideSubtitle: String = "false" {
        didSet{
            layoutSubviews()
        }
    }
    
    @objc public var hideTimeline: String = "false" {
        didSet{
            layoutSubviews()
        }
    }
    
    @objc public var  isMFPPMerchant: String = ""{
        didSet{
            layoutSubviews()
        }
    }
    
    @objc public var learnMoreUrl: String = ""{
        didSet{
            layoutSubviews()
        }
    }
    
    @objc public var minModal: String = "" {
        didSet{
            layoutSubviews()
        }
    }
    
    var paymentWidgetHeaderText = PaymentWidgetHeaderText()
    var paymentWidgetSubText = PaymentWidgetSubText()
    var timelapseGraphView = TimelapseGraphView()
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RNPaymentWidget {
    func style(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        paymentWidgetHeaderText.translatesAutoresizingMaskIntoConstraints = true
        paymentWidgetSubText.translatesAutoresizingMaskIntoConstraints = true
        timelapseGraphView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func layout(){
        addSubview(stackView)
        stackView.addArrangedSubview(paymentWidgetHeaderText)
        stackView.addArrangedSubview(paymentWidgetSubText)
        stackView.addArrangedSubview(timelapseGraphView)
    
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    
    //Redraw timelapse
    override public func layoutSubviews() {
        super.layoutSubviews()
        //Pass parameters {amount} in the timelapse graph
        if(hideTimeline.lowercased() == "true"){
            //Hiding the timeline by removing the width.
            timelapseGraphView.isHidden = true
     

        }else{
            timelapseGraphView.isHidden = false
            if(UIDevice.current.userInterfaceIdiom == .pad){
                timelapseGraphView.actualFrameWidth = 300
            }else{
                timelapseGraphView.actualFrameWidth = frame.width
                print(frame.width)
            }
            timelapseGraphView.amount = amount
            if(timelineColor.lowercased() == "black") {
                timelapseGraphView.actualTimelineColor = UIColor.zipBlack.cgColor
            }else {
                timelapseGraphView.actualTimelineColor = UIColor.zipPurple.cgColor
            }

        }

        DispatchQueue.main.async {
            self.timelapseGraphView.drawTimelapseGraph()
        }
   
        if(hideHeader == "true"){
            paymentWidgetHeaderText.isHidden = true
        }else{
            paymentWidgetHeaderText.isHidden = false
        }

        if(hideSubtitle.lowercased() == "true"){
            paymentWidgetSubText.isHidden = true
        }else{
            paymentWidgetSubText.isHidden = false
        }

        //Passed parameters to the header for pop up
        //{minModal, merchantId,isMFPPMerchant, learnmoreURL}
        paymentWidgetHeaderText.minModal = minModal
        paymentWidgetHeaderText.merchantId = merchantId
        paymentWidgetHeaderText.isMFPPMerchant = isMFPPMerchant
        paymentWidgetHeaderText.learnMoreUrl = learnMoreUrl
        paymentWidgetHeaderText.style()

    }
}
