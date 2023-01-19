
import Foundation
import UIKit

/// A view that displays informative text, the Afterpay badge and an info link. The info link will
/// launch externally by default but can launch modally in app by implementing
/// PriceBreakdownViewDelegate. This view updates in response to Afterpay configuration changes
/// as well as changes to the `totalAmount`.
@available(iOS 10.0, *)
@available(iOS 12.0, *)
public final class PaymentWidgetHeaderText: UIView {
    
    var paymentWidgetLabel = LinkTextView()
    
    var initialPaymentWidgetLabelText : String = "Pay in installments with Zip."
    var actualPaymentWidgetLabelText : String?
    
    //let moreInfoOptions = MoreInfoOptions()
    
    private var contentHtml: String {
        let urlPath = Bundle.qpResource.path(forResource: "index", ofType: "html", inDirectory: "www")
        do{
            let strHTMLContent = try String(contentsOfFile: urlPath!)
            return strHTMLContent
        }
        catch let err{
            print(err)
            return ""
        }

    }
    
    private var infoLink: URL {
        let urlPath = Bundle.qpResource.path(forResource: "index", ofType: "html", inDirectory: "www")
        let url  = URL(fileURLWithPath: urlPath!)
        return url
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension PaymentWidgetHeaderText {
    
    func style(){
        let headerText = makeHeaderText(headerText: actualPaymentWidgetLabelText ?? initialPaymentWidgetLabelText, link: infoLink)
        
        paymentWidgetLabel.linkHandler = { [weak self ] url in
            if let rnController = self?.ReactNativeController(){
                let infoWebViewController = InfoWebViewController(infoURL: url, contentHtml: self?.contentHtml ?? "")
            let navigationController = UINavigationController(rootViewController: infoWebViewController)
              rnController.present(navigationController, animated: true, completion: nil)
            } else {
                  UIApplication.shared.open(url)
              }
          }
  
        paymentWidgetLabel.translatesAutoresizingMaskIntoConstraints  = false
        paymentWidgetLabel.font = UIFont.preferredFont(forTextStyle: .body).bold()
        paymentWidgetLabel.attributedText = headerText
        paymentWidgetLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    func layout(){
        addSubview(paymentWidgetLabel)

        NSLayoutConstraint.activate([
            paymentWidgetLabel.topAnchor.constraint(equalTo: topAnchor),
            paymentWidgetLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            paymentWidgetLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            paymentWidgetLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func ReactNativeController() -> UIViewController {
        var reactNativeController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
            
        while (reactNativeController.presentedViewController != nil) {
            reactNativeController = reactNativeController.presentedViewController!
        }
        return reactNativeController
    }
    
}

