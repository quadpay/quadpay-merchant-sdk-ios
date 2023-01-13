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


//
//  WidgetViewController.swift
//  SDKDemo
//
//  Created by Lai Tang on 01/07/2022.
//  Copyright © 2022 QuadPay. All rights reserved.
//

//import Foundation
//import UIKit
//import QuadPaySDK
//
//final class WidgetViewContoller : UIViewController {
//
//    //let paymentWidget = PaymentWidget()
//    //let paymentWidget2 = PaymentWidget()
//
//    let scrollView = UIScrollView()
//    let stackView = UIStackView()
//
//    let tiles = [
//        TileView("Test"),
//        TileView("Test 2"),
//        TileView("Test 2"),
//        TileView("Test 2")
//    ]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupScrollView()
//        style()
//        layout()
////        paymentWidget.translatesAutoresizingMaskIntoConstraints = false
////        paymentWidget2.translatesAutoresizingMaskIntoConstraints = false
////        view.addSubview(paymentWidget)
////        view.addSubview(paymentWidget2)
////
////        NSLayoutConstraint.activate([
////            paymentWidget.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
////            paymentWidget.leadingAnchor.constraint(equalTo: view.leadingAnchor),
////            paymentWidget.trailingAnchor.constraint(equalTo: view.trailingAnchor),
////            paymentWidget.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
////        ])
//    }
//
//    func setupScrollView(){
//        scrollView.delegate = self
//    }
//
////    override func loadView() {
////        let view = UIView()
////
////        view.backgroundColor = .white
////
////        let stack = UIStackView()
////
////        stack.translatesAutoresizingMaskIntoConstraints = false
////        stack.axis = .vertical
////        stack.spacing = 20
////        stack.isLayoutMarginsRelativeArrangement = true
////
////
////
////        let priceBreakdown2 = QuadPayWidgetComponent()
////        priceBreakdown2.amount = "500"
////        priceBreakdown2.logoOption = "secondary"
////        priceBreakdown2.colorPrice = "#ff3700ff"
////        priceBreakdown2.size = "150%"
////        priceBreakdown2.logoSize="150%"
////        priceBreakdown2.alignment = "center"
////
////        priceBreakdown2.merchantId = "a77c291d-fec0-4b04-9daf-c165f5be8313"
////
////        stack.addArrangedSubview(priceBreakdown2)
////
////        let priceBreakdown3 = QuadPayWidgetComponent()
////        priceBreakdown3.amount = "700"
////        priceBreakdown3.logoOption = "secondary-light"
////        priceBreakdown3.colorPrice = "#ff3700ff"
////        priceBreakdown3.alignment = "left"
////        priceBreakdown3.size = "120%"
////        priceBreakdown3.logoSize="120%"
////        stack.addArrangedSubview(priceBreakdown3)
////
////        let paymentWidget = PaymentWidget()
////        paymentWidget.amount = "100"
////        stack.addArrangedSubview(paymentWidget)
////
////        let paymentWidget2 = PaymentWidget()
////        paymentWidget2.amount = "200"
////        paymentWidget2.merchantId = "a77c291d-fec0-4b04-9daf-c165f5be8313"
////        stack.addArrangedSubview(paymentWidget2)
////
////        view.addSubview(stack)
////
////        stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:  10).isActive = true
////        stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:  -10).isActive = true
////
////        self.view = view
////    }
//
//}
//
//extension WidgetViewContoller {
//    func style(){
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        stackView.axis = .vertical
//        stackView.spacing = 8
//    }
//
//    func layout(){
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackView)
//
//        for tile in tiles {
//            addChild(tile)
//            stackView.addArrangedSubview(tile.view)
//            tile.didMove(toParent: self)
//        }
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//
//            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//        ])
//
//    }
//}
//
//
//extension WidgetViewContoller : UIScrollViewDelegate{
//
//}
