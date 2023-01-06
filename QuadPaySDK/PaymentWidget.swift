////
////  PaymentWidget.swift
////  Pods-SDKDemo
////
////  Created by Petros Andreou on 03/01/2023.
////
//
//import Foundation
//import UIKit
//
//public final class PaymentWidget: UIView {
//
//    var merchantConfig = [MerchantConfig]()
//
//    @objc public var merchantId : String = ""
//
//    @objc public var learnMoreUrl : String  = ""
//
//    @objc public var minModal : String = ""
//
//    @objc public var isMfppMerchant : String = ""
//
//    @objc public var amount : String = ""
//
//    @objc  public var min : String = ""
//
//    @objc public var max : String = ""
//
//    public var textColor: UIColor = {
//        if #available(iOS 13.0, *) {
//          return .label
//        } else {
//          return .black
//        }
//    }()
//
//    public var fontProvider: (UITraitCollection) -> UIFont = { traitCollection in
//      .preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
//    }
//
//    public var moreInfoOptions: MoreInfoOptions = MoreInfoOptions() {
//      didSet { updateAttributedText() }
//    }
//
//    private var contentHTML: String {
//        let urlPath = Bundle.qpResource.path(forResource: "index", ofType: "html", inDirectory: "www")
//        do {
//            var strHTMLContent = try String(contentsOfFile: urlPath!)
//            strHTMLContent = strHTMLContent.replacingOccurrences(of: "%learnMoreUrl%", with: learnMoreUrl)
//            strHTMLContent = strHTMLContent.replacingOccurrences(of: "%merchantId%", with: merchantId)
//            strHTMLContent = strHTMLContent.replacingOccurrences(of: "%isMFPPMerchant", with: isMfppMerchant)
//            strHTMLContent = strHTMLContent.replacingOccurrences(of: "%minModal%", with: minModal)
//            #if DEBUG
//            let quadpayJS: String = "https://cdn.dev.us.zip.co/v1/quadpay.js"
//            #else
//            let quadpayJS: String = "https://cdn.us.zip.co/v1/quadpay.js"
//            #endif
//            strHTMLContent = strHTMLContent.replacingOccurrences(of: "%QuadPayJS", with: quadpayJS)
//            return strHTMLContent
//        }
//        catch let err{
//            print(err)
//            return ""
//        }
//    }
//
//    public init() {
//        super.init(frame: .zero)
//        sharedInit()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        sharedInit()
//    }
//
//    private let linkTextView = LinkTextView()
//
//    func ReactNativeController() -> UIViewController {
//        var reactNativeController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
//
//        while (reactNativeController.presentedViewController != nil){
//            reactNativeController = reactNativeController.presentedViewController!
//        }
//        return reactNativeController
//    }
//
//    private func sharedInit() {
//        linkTextView.linkHandler = { [weak self] url
//            if let viewController = self?.delegate?.viewControllerForPresentation() {
//                let infoWebViewController = InfoWebViewController(infoURL: url, contentHtml: self?.contentHTML ?? "")
//                let navigationController = UINavigationController(rootViewController: infoWebViewController)
//                viewController.present(navigationController, animated: true, completion: nil)
//            } else if let rnController = self?.ReactNativeController(){
//                let infoWebViewController = InfoWebViewController(infoURL: url, contentHtml: self?.contentHTML ?? "")
//                let navigationController = UINavigationController(rootViewController: infoWebViewController)
//                rnController.present(navigationController, animated:true, completion: nil)
//            } else {
//                UIApplication.shared.open(url)
//            }
//        }
//
//        addSubview(linkTextView)
//
//        NSLayoutConstraint.activate([
//          linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
//          linkTextView.topAnchor.constraint(equalTo: topAnchor),
//          linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
//          linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
//        ])
//
//    }
//
//    @available(iOS 15.0, *)
//    private func fetchMerchantConfig() async -> Result<MerchantConfig, Error> {
//        if(merchantId == ""){
//            return .failure(MyError.failedToGetMerchantConfig)
//        }
//
//        do {
//            #if DEBUG
//            let merchantConfigUrl: String = ""
//            #else
//            let merchantConfigUrl: String = ""
//            #endif
//            let url = URL(string:(merchantConfigUrl + merchantId + ".json"))
//            let (data,_) = try await URLSession.shared.data(from: url!)
//            let merchantConfigData = try JSONDecoder().decode(MerchantConfig.self, from: data)
//            return .success(merchantConfigData)
//        }
//        catch {
//            return .failure(MyError.failedToGetMerchantConfig)
//        }
//    }
//
//
//}
//
//struct MerchantConfig: Codable{
//    var LogoUrl : String
//}
//
//enum MyError: Error{
//    case failedToGetMerchantConfig
//}
