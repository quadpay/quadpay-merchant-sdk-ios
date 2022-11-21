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

final class WidgetViewContoller : UIViewController, QuadPayWidgetComponentDelegate {

    private var scrollView: UIScrollView!
    
    override func loadView() {
        let view = UIView()
        
        view.backgroundColor = .white
     
        let stack = UIStackView()
     
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.isLayoutMarginsRelativeArrangement = true
      
        
        
        let priceBreakdown2 = QuadPayWidgetComponent()
        priceBreakdown2.amount = "500"
        priceBreakdown2.delegate = self
        priceBreakdown2.logoOption = "secondary"
        priceBreakdown2.colorPrice = "#ff3700ff"
        priceBreakdown2.size = "150%"
        priceBreakdown2.logoSize="150%"
        priceBreakdown2.alignment = "center"
       
        priceBreakdown2.merchantId = "9f7c8dcc-a546-45e4-a789-b65055abe0db"
        
        stack.addArrangedSubview(priceBreakdown2)
        
        let priceBreakdown3 = QuadPayWidgetComponent()
        priceBreakdown3.amount = "700"
        priceBreakdown3.delegate = self
        priceBreakdown3.logoOption = "secondary-light"
        priceBreakdown3.colorPrice = "#ff3700ff"
        priceBreakdown3.alignment = "left"
        priceBreakdown3.size = "120%"
        priceBreakdown3.logoSize="120%"
        stack.addArrangedSubview(priceBreakdown3)

        view.addSubview(stack)
        
        stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:  10).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:  -10).isActive = true
        
        self.view = view
    }
    func viewControllerForPresentation() -> UIViewController { self }
}

