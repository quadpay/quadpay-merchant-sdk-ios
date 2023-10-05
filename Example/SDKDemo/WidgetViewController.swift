//
//  WidgetViewController.swift
//  SDKDemo
//
//  Created by Lai Tang on 01/07/2022.
//  Copyright © 2022 QuadPay. All rights reserved.
//

import Foundation
import UIKit
import ZipSDK

final class WidgetViewContoller : UIViewController {
     
    let widget = Widget()
    let widget2 = Widget()
    let widget3 = Widget()
    let widget4 = Widget()
    let widget5 = Widget()
    let widget6 = Widget()
    let widget7 = Widget()
    let widget8 = Widget()
    let widget9 = Widget()
    let widget10 = Widget()
    let widget11 = Widget()
    let widget12 = Widget()
    
    let widget13 = Widget()
    
    
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
        widget.alignment = "right"
        
        widget2.amount = "100"
        widget2.logoOption = "secondary"
        widget2.displayMode = "logoFirst"
        widget2.alignment = "center"
        
        widget3.amount = "200"
        widget3.logoOption = "secondary"
        widget3.logoSize = "120%"
        widget3.size = "130%"
        widget3.merchantId = "a77c291d-fec0-4b04-9daf-c165f5be8313"
        widget3.learnMoreUrl = "https://www.google.com"
        widget3.isMFPPMerchant = "true"
        widget3.alignment = "left"
        
        widget4.amount = "0"
        widget4.size = "30%"
        widget4.logoOption = "secondary-light"
        
        widget5.amount = "100"
        widget5.logoOption = "secondary-light"
        widget5.displayMode = "logoFirst"
        
        widget6.amount = "200"
        widget6.logoOption = "secondary-light"
        widget6.merchantId = "a77c291d-fec0-4b04-9daf-c165f5be8313"
        
        widget7.min = "20"
        widget7.logoOption = "black-white"
        
        widget8.amount = "200"
        widget8.logoOption = "black-white"
        widget8.displayMode = "logoFirst"
        
        widget9.amount = "2000"
        widget9.logoOption = "black-white"
        widget9.merchantId = "a77c291d-fec0-4b04-9daf-c165f5be8313"
        widget9.colorPrice = "#eb4034"
        widget9.max = "3400"
        
        widget10.amount = "0"
        
        widget11.amount = "200"
        widget11.displayMode = "logoFirst"
    
        widget12.merchantId = "a77c291d-fec0-4b04-9daf-c165f5be8313"

        
        paymentWidgetWithoutHeader.amount = "200"
        
        paymentWidgetWithoutSubtitle.merchantId = "897af3af-265b-4f69-b40e-5fb2d206a622"// Not valid merchant
        paymentWidgetWithoutSubtitle.amount = "300"
        paymentWidgetWithoutSubtitle.isMFPPMerchant = "true"
//        
        paymentWidgetWithoutBothHeaders.merchantId = "a77c291d-fec0-4b04-9daf-c165f5be8313"
        paymentWidgetWithoutBothHeaders.learnMoreUrl = "www.google.com"
        paymentWidgetWithoutBothHeaders.hideSubtitle = "true"
//        
        paymentWidgetWithoutTimeline.hideTimeline = "true"
        
        widget13.amount = "400"
        widget13.merchantId = "a77c291d-fec0-4b04-9daf-c165f5be831"
        widget13.displayMode = "logoFirst"
        

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
        stackView.addArrangedSubview(widget13)
      
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
