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

final class WidgetViewContoller : UIViewController, PriceBreakdownViewDelegate {

    private var scrollView: UIScrollView!
    
    override func loadView() {
        let view = UIView()
        
        view.backgroundColor = .white
     
        let stack = UIStackView()
     
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.isLayoutMarginsRelativeArrangement = true
      
        
        
        let priceBreakdown2 = PriceBreakdownView()
        priceBreakdown2.amount = "500"
        priceBreakdown2.delegate = self
        priceBreakdown2.logoOption = "secondary"
        priceBreakdown2.colorPrice = "#ff3700ff"
        priceBreakdown2.size = "150%"
        priceBreakdown2.logoSize="150%"
        priceBreakdown2.alignment = "center"
       
        priceBreakdown2.merchantId = "9f7c8dcc-a546-45e4-a789-b65055abe0db"
        
        stack.addArrangedSubview(priceBreakdown2)
        
        let priceBreakdown3 = PriceBreakdownView()
        priceBreakdown3.amount = "700"
        priceBreakdown3.delegate = self
        priceBreakdown3.logoOption = "secondary-light"
        priceBreakdown3.colorPrice = "#ff3700ff"
        priceBreakdown3.alignment = "left"
        priceBreakdown3.size = "120%"
        priceBreakdown3.logoSize="120%"
        stack.addArrangedSubview(priceBreakdown3)
//
//        let priceBreakdown = PriceBreakdownView()
//
//        priceBreakdown.totalAmount = 35
//        priceBreakdown.totalAmount = 700
//        priceBreakdown.delegate = self
//        priceBreakdown.logoOption = "secondary-light"
//        priceBreakdown.priceColor = "#ff3700ff"
//        priceBreakdown.alignment = "right"
//        priceBreakdown.size = "80%"
//        priceBreakdown.logoSize="80%"
//        priceBreakdown.displayMode = "logoFirst"
//        stack.addArrangedSubview(priceBreakdown)

        
        view.addSubview(stack)
        
        stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:  10).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:  -10).isActive = true
        


//        let contentView = UIView()
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(contentView)
//
//        let contentStack = UIStackView()
//        contentStack.translatesAutoresizingMaskIntoConstraints = false
//        contentStack.axis = .vertical
//        contentView.addSubview(contentStack)
//
//        let child = ContentStackViewController()
//        addChild(child)
//
//        child.view.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(child.view)
//
//        NSLayoutConstraint.activate([
//            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            child.view.topAnchor.constraint(equalTo: view.topAnchor),
//            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//
//        child.didMove(toParent: self)
    
        
        self.view = view
    }
    func viewControllerForPresentation() -> UIViewController { self }
}

private final class ContentStackViewController: UIViewController, PriceBreakdownViewDelegate {

    init() {
      super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 8

//    let titleLabel = UILabel()
//    titleLabel.text = "somthing"
//    titleLabel.font = .preferredFont(forTextStyle: .title1)
//    titleLabel.adjustsFontForContentSizeCategory = true
//    stack.addArrangedSubview(titleLabel)
    
//    let priceBreakdown1 = PriceBreakdownView()
//    //priceBreakdown1.introText = ".payInTitle"
//    priceBreakdown1.totalAmount = 100
//    priceBreakdown1.delegate = self
//    priceBreakdown1.moreInfoOptions = MoreInfoOptions()
//    stack.addArrangedSubview(priceBreakdown1)
    
    let stackConstraints = [
      stack.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
      stack.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
      stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
      stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
    ]

    view.addSubview(stack)
    NSLayoutConstraint.activate(stackConstraints)

    self.view = view
    
}
  func viewControllerForPresentation() -> UIViewController { self }

}
