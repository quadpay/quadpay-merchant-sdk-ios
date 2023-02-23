//
//  WidgetViewController.swift
//  SDKDemo
//
//  Created by Lai Tang on 01/07/2022.
//  Copyright © 2022 QuadPay. All rights reserved.
//

import Foundation
import UIKit
import QuadPaySDK

final class WidgetViewContoller : UIViewController {
    
    let widget = QuadPayWidgetComponent()
    let widget2 = QuadPayWidgetComponent()
    let widget3 = QuadPayWidgetComponent()
    let widget4 = QuadPayWidgetComponent()
    let widget5 = QuadPayWidgetComponent()
    let widget6 = QuadPayWidgetComponent()
    let widget7 = QuadPayWidgetComponent()
    let widget8 = QuadPayWidgetComponent()
    let widget9 = QuadPayWidgetComponent()
    let widget10 = QuadPayWidgetComponent()
    let widget11 = QuadPayWidgetComponent()
    let widget12 = QuadPayWidgetComponent()
    
    
    let paymentWidgetWithoutHeader = PaymentWidget()
    let paymentWidgetWithoutSubtitle = PaymentWidget()
    let paymentWidgetWithoutBothHeaders = PaymentWidget()
    let paymentWidgetWithoutTimeline = PaymentWidget()
    let normalWidget = PaymentWidget()

    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        widget.amount = "0"
        widget.logoOption = "secondary"
        
        widget2.amount = "100"
        widget2.logoOption = "secondary"
        widget2.displayMode = "logoFirst"
        
        widget3.amount = "200"
        widget3.logoOption = "secondary"
        widget3.merchantId = "a77c291d-fec0-4b04-9daf-c165f5be8313"
        
        widget4.amount = "0"
        widget4.logoOption = "secondary-light"
        
        widget5.amount = "100"
        widget5.logoOption = "secondary-light"
        widget5.displayMode = "logoFirst"
        
        widget6.amount = "200"
        widget6.logoOption = "secondary-light"
        widget6.merchantId = "a77c291d-fec0-4b04-9daf-c165f5be8313"
        
        widget7.amount = "0"
        widget7.logoOption = "black-white"
        
        widget8.amount = "200"
        widget8.logoOption = "black-white"
        widget8.displayMode = "logoFirst"
        
        widget9.amount = "200"
        widget9.logoOption = "black-white"
        widget9.merchantId = "a77c291d-fec0-4b04-9daf-c165f5be8313"
        
        widget10.amount = "0"
        
        widget11.amount = "200"
        widget11.displayMode = "logoFirst"
    
        widget12.merchantId = "a77c291d-fec0-4b04-9daf-c165f5be8313"

        
        paymentWidgetWithoutHeader.amount = "200"
        paymentWidgetWithoutHeader.hideHeader = "true"
        
        paymentWidgetWithoutSubtitle.merchantId = "8f52d93d-f308-4067-a8ef-7d98cc2b0f1b"// Not valid merchant
        paymentWidgetWithoutSubtitle.amount = "300"
        paymentWidgetWithoutSubtitle.timelineColor = "black"
        paymentWidgetWithoutSubtitle.hideSubtitle = "true"
        paymentWidgetWithoutSubtitle.isMFPPMerchant = "true"
//        
        paymentWidgetWithoutBothHeaders.merchantId = "a77c291d-fec0-4b04-9daf-c165f5be8313"
        paymentWidgetWithoutBothHeaders.learnMoreUrl = "www.google.com"
        paymentWidgetWithoutBothHeaders.hideSubtitle = "true"
        paymentWidgetWithoutBothHeaders.hideHeader = "true"
//        
        paymentWidgetWithoutTimeline.hideTimeline = "true"

        setupScrollView()
        style()
        layout()
    }
    
    func setupScrollView(){
        scrollView.delegate = self
    }
}

extension WidgetViewContoller {
    func style(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 10
    }
    
    func layout(){
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(paymentWidgetWithoutHeader)
        stackView.addArrangedSubview(paymentWidgetWithoutSubtitle)
        stackView.addArrangedSubview(paymentWidgetWithoutBothHeaders)
        stackView.addArrangedSubview(paymentWidgetWithoutTimeline)
        stackView.addArrangedSubview(normalWidget)
        stackView.addArrangedSubview(widget)
        stackView.addArrangedSubview(widget2)
        stackView.addArrangedSubview(widget3)
        stackView.addArrangedSubview(widget4)
        stackView.addArrangedSubview(widget5)
        stackView.addArrangedSubview(widget6)
        stackView.addArrangedSubview(widget7)
        stackView.addArrangedSubview(widget8)
        stackView.addArrangedSubview(widget9)
        stackView.addArrangedSubview(widget10)
        stackView.addArrangedSubview(widget11)
        stackView.addArrangedSubview(widget12)
      
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
    }
}

extension WidgetViewContoller : UIScrollViewDelegate{
}
