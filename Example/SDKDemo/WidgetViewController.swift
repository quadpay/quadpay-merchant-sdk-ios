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

    let paymentWidget = PaymentWidget()
    let paymentWidget2 = PaymentWidget()
    let paymentWidget3 = PaymentWidget()
    let paymentWidget4 = PaymentWidget()
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        widget.amount = "100"
        widget2.amount = "200"
        paymentWidget.amount = "200"
        paymentWidget2.merchantId = "9f7c8dcc-a546-45e4-a789-b65055abe0db"
        paymentWidget2.amount = "300"
        paymentWidget2.timelapseColor = "black"
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
        
        stackView.addArrangedSubview(paymentWidget)
        stackView.addArrangedSubview(paymentWidget2)
        stackView.addArrangedSubview(paymentWidget3)
        stackView.addArrangedSubview(paymentWidget4)
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
