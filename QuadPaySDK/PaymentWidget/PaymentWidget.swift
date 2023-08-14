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
    
    let stackView = UIStackView()
    
    private var request: ApiRequest<WidgetDataResource>?
    
    @objc public var merchantId: String = "" {
        didSet{
            setWidgetData()
        }
    }
    
    @objc public var amount: String = "0" {
        didSet{
            setWidgetData()
            layoutSubviews()
        }
    }
    
    @objc public var timelineColor: String = "" {
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
    
    var maxFee: Double = 0.0
    
    var bankPartner: String = NO_BANK_PARTNER
    
    var paymentWidgetHeaderText = PaymentWidgetHeaderText()
    var paymentWidgetSubText = PaymentWidgetSubText()
    var timelapseGraphView = TimelapseGraphView()
    var feeTierView = FeeTierText()
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        UIFont.registerFonts()
        style()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PaymentWidget {
    func style(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        paymentWidgetHeaderText.translatesAutoresizingMaskIntoConstraints = true
        paymentWidgetSubText.translatesAutoresizingMaskIntoConstraints = true
        timelapseGraphView.translatesAutoresizingMaskIntoConstraints = true
        feeTierView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func layout(){
        addSubview(stackView)
        stackView.addArrangedSubview(paymentWidgetHeaderText)
        stackView.addArrangedSubview(paymentWidgetSubText)
        stackView.addArrangedSubview(timelapseGraphView)
        stackView.addArrangedSubview(feeTierView)
        feeTierView.isHidden = maxFee == 0
    
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setWidgetData(){
        if(amount != "0" && amount != ""){
            self.request = GatewayService.instance.fetchWidgetData(merchantId: merchantId) { [weak self]
                (result) in
                
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(let result):
                    
                    guard let widgetData = result else {
                        DispatchQueue.main.async {
                            self.layout()
                        }
                        return
                    }
                    
                    self.maxFee = 0
                    var maxTier: Double = 0
                    let amountAsFloat  = Double(self.amount) ?? 0.00
                    
                    self.bankPartner = widgetData.bankPartner

                    
                    for(_,element) in widgetData.feeTiers.enumerated() {
                        let tierAmount = element.feeStartsAt
                        if(tierAmount <= amountAsFloat ){
                            if(maxTier < tierAmount){
                                maxTier = tierAmount
                                self.maxFee = element.totalFeePerOrder
                            }
                        }
                    }
                    
                    self.timelapseGraphView.maxFee = self.maxFee
                    
                    
                    DispatchQueue.main.async {
                        self.layout()
                    }
               
                    
                case .failure(let error):
                    print(error)
                    self.maxFee = 0
                    DispatchQueue.main.async {
                        self.layout()
                    }
                  
                    
                }
            }
        }else{
            maxFee = 0
        }
        layoutSubviews()
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
        
    
        paymentWidgetHeaderText.hasFees = maxFee != 0
        paymentWidgetHeaderText.bankPartner = bankPartner
       

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
        paymentWidgetHeaderText.learnMoreUrl = checkValidUrl(url: learnMoreUrl)
        paymentWidgetHeaderText.style()
        
        feeTierView.maxFee = maxFee
        feeTierView.hideTimeline = hideTimeline == "true"
        
        feeTierView.style()
    }
}
