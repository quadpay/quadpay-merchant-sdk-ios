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

    let paymentWidgetWithoutHeader = PaymentWidget()
    let paymentWidgetWithoutSubtitle = PaymentWidget()
    let paymentWidgetWithoutBothHeaders = PaymentWidget()
    let paymentWidgetWithoutTimeline = PaymentWidget()
    let normalWidget = PaymentWidget()

    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        widget.amount = "100"
        widget2.amount = "200"
        
        paymentWidgetWithoutHeader.amount = "200"
        paymentWidgetWithoutHeader.hideHeader = true
        
        paymentWidgetWithoutSubtitle.merchantId = "9f7c8dcc-a546-45e4-a789-b65055abe0db"
        paymentWidgetWithoutSubtitle.amount = "300"
        paymentWidgetWithoutSubtitle.timelapseColor = "black"
        paymentWidgetWithoutSubtitle.hideSubtitle = true
  
        paymentWidgetWithoutBothHeaders.merchantId = "9f7c8dcc-a546-45e4-a789-b65055abe0db"
        paymentWidgetWithoutBothHeaders.learnMoreUrl = "www.google.com"
        paymentWidgetWithoutBothHeaders.hideHeader = true
        paymentWidgetWithoutBothHeaders.hideSubtitle = true
        
        paymentWidgetWithoutTimeline.hideTimeline = true


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
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
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
