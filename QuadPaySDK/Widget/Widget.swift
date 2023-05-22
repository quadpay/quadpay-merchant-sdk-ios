//
//  Widget.swift
//  QuadPaySDK
//
//  Created by Petros Andreou on 08/03/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation
import UIKit

public final class Widget : UIView{
    
    private var request: ApiRequest<WidgetDataResource>?
    
    @objc public var merchantId: String = ""{
        didSet{
            setWidgetData()
        }
    }
    
    @objc public var amount: String = "0"{
        didSet{
            setWidgetData()
        }
    }
    
    @objc public var min: String = "35"{
        didSet{
            layout()
        }
    }
    
    @objc public var max: String = "1500"{
        didSet{
            layout()
        }
    }
    
    @objc public var size: String = ""{
        didSet{
            layout()
        }
    }
    
    @objc public var logoOption: String = ""{
        didSet{
            layout()
        }
    }
    
    @objc public var displayMode: String = ""{
        didSet{
            layout()
        }
    }
    
    @objc public var learnMoreUrl : String = ""{
        didSet{
            layout()
        }
    }
    
    @objc public var isMFPPMerchant : String = ""{
        didSet{
            layout()
        }
    }
    
    @objc public var alignment: String = ""{
        didSet{
            layout()
        }
    }
    
    @objc public var colorPrice: String = ""{
        didSet{
            layout()
        }
    }
    
    @objc public var logoSize: String = ""{
        didSet{
            layout()
        }
    }
    
    @objc public var minModal: String = ""{
        didSet{
            layout()
        }
    }
    
    var widget = LinkTextView()
    
    var contentHtml: String = ""
    
    let formatter = NumberFormatter()
    
    var grayLabelMerchant: Bool = false
    
    var maxFee : Double = 0
    
    var widgetText = NSAttributedString()
    
    var hasFees : Bool?
    
    var bankPartner: String = ""
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Widget{
    func layout(){
        
        let orText = makeText(text: "or", size: size)
        let withText = makeText(text: "with", size: size)
        let space = makeText(text: " ", size: size)
      
        let amountColor = UIColor(hexString: colorPrice)
        let amount = calculateInstalment()
        let logo = createLogo(logoOption: logoOption, logoSize: logoSize)
        let amountText = makeAmountText(text: amount, color: amountColor, size: size)
        let link = createInfoLink(link: infoLink)
        let attributedString = NSMutableAttributedString()
        

        contentHtml = updateHtmlContent(learnMoreUrl: learnMoreUrl, merchantId: merchantId, isMFPPMerchant: isMFPPMerchant, minModal: minModal, hasFees: hasFees ?? false, bankPartner: bankPartner)
        
        if(grayLabelMerchant){
            let merchantLogo = createMerchantLogo()
            let poweredByText = makeText(text: "powered by", size: size)
            attributedString.append(widgetText)
            attributedString.append(space)
            attributedString.append(amountText)
            attributedString.append(space)
            attributedString.append(withText)
            attributedString.append(space)
            attributedString.append(merchantLogo)
            attributedString.append(space)
            attributedString.append(poweredByText)
            attributedString.append(space)
            attributedString.append(logo)
            attributedString.append(space)
            attributedString.append(link)
        }else{
            if(displayMode.lowercased() == "logofirst"){
                attributedString.append(logo)
                attributedString.append(space)
                attributedString.append(widgetText)
                attributedString.append(space)
                attributedString.append(amountText)
                attributedString.append(space)
                attributedString.append(link)
            }else{
                attributedString.append(orText)
                attributedString.append(space)
                attributedString.append(widgetText)
                attributedString.append(space)
                attributedString.append(amountText)
                attributedString.append(space)
                attributedString.append(withText)
                attributedString.append(space)
                attributedString.append(logo)
                attributedString.append(space)
                attributedString.append(link)
            }
        }
    
        
        
        widget.linkHandler = { [weak self ] url in
            if let rnController = self?.ReactNativeController(){
                let infoWebViewController = InfoWebViewController(infoURL: url, contentHtml: self?.contentHtml ?? "")
            let navigationController = UINavigationController(rootViewController: infoWebViewController)
              rnController.present(navigationController, animated: true, completion: nil)
            } else {
                  UIApplication.shared.open(url)
              }
          }
        
        widget.translatesAutoresizingMaskIntoConstraints = false
        widget.font = UIFont.preferredFont(forTextStyle: .body).bold()
        widget.attributedText = attributedString
     
        widget.linkTextAttributes = [
            .foregroundColor: UIColor.zipBlack,
        ]
        
        switch alignment.lowercased(){
        case "left":
            widget.textAlignment = NSTextAlignment.left
        case "right":
            widget.textAlignment = NSTextAlignment.right
        case "center":
            widget.textAlignment = NSTextAlignment.center
        default:
            widget.textAlignment = NSTextAlignment.left
        }
    }
    
    func style(){
        addSubview(widget)
        
        NSLayoutConstraint.activate([
            widget.leadingAnchor.constraint(equalTo: leadingAnchor),
            widget.trailingAnchor.constraint(equalTo: trailingAnchor),
            widget.topAnchor.constraint(equalTo: topAnchor),
            widget.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
    
    func setWidgetData(){
        if(amount != "0"){
            self.request = GatewayService.instance.fetchWidgetData(merchantId: merchantId){ [weak self]
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
                    
                    var maxTier: Double = 0
                    
                    self.bankPartner = widgetData.bankPartner
                    
                    for(_,element) in widgetData.feeTiers.enumerated() {
                        let tierAmount = element.feeStartsAt
                        if(tierAmount <= Double(self.amount) ?? 0){
                            if(maxTier < tierAmount){
                                maxTier = tierAmount
                                self.maxFee = element.totalFeePerOrder
                            }
                        }
                    }
                    
                    
                    self.hasFees = self.maxFee != 0
                    
                    DispatchQueue.main.async {
                        self.layout()
                    }
                    
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        self.layout()
                    }
                    
                }
            }
        }
        layout()
    }
    
    
    func calculateInstalment() -> String{
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.currencyCode = "USD"
        formatter.numberStyle = .currency
        
        var amount  = Double(amount) ?? 0.00

    
        amount = amount + maxFee
        let min = Double(min) ?? 35.00
        let max = Double(max) ?? 1500.00
        if(amount<min){
            widgetText = makeText(text: "4 payments on orders over", size: size)
            return formatter.string(for:Float(min)) ?? "35.00"
        }else if( amount > max){
            widgetText = makeText(text: "4 payments on orders up to", size: size)
            return formatter.string(for:Float(max)) ?? "1500.00"
        }else{
            widgetText = makeText(text: "4 easy payments of", size: size)
            return formatter.string(for: amount/4) ?? "?"
        }
    }
    
    func ReactNativeController() -> UIViewController {
        var reactNativeController: UIViewController = (UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController)!
           
        while (reactNativeController.presentedViewController != nil) {
            reactNativeController = reactNativeController.presentedViewController!
        }
        return reactNativeController
    }
    
}
