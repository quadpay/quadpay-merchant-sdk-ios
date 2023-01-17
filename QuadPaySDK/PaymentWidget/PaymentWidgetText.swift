
import Foundation
import UIKit

/// A view that displays informative text, the Afterpay badge and an info link. The info link will
/// launch externally by default but can launch modally in app by implementing
/// PriceBreakdownViewDelegate. This view updates in response to Afterpay configuration changes
/// as well as changes to the `totalAmount`.
@available(iOS 10.0, *)
@available(iOS 12.0, *)
public final class PaymentWidgetText: UIView {
    
    var paymentWidgetLabel = UILabel()
  //  let infoView = makeSymbolImageView(systemName: "star.fill")
    let paymentWidgetSubLabel = UILabel()
    
    let initialPaymentWidgetLabelText : String = "Pay in installments with Zip."
    var actualPaymentWidgetLabelText : String?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func style(){
        paymentWidgetLabel.translatesAutoresizingMaskIntoConstraints  = false
        paymentWidgetLabel.font = UIFont.preferredFont(forTextStyle: .body).bold()
        paymentWidgetLabel.text = actualPaymentWidgetLabelText ?? initialPaymentWidgetLabelText
        paymentWidgetLabel.numberOfLines = 0
        paymentWidgetLabel.lineBreakMode = .byWordWrapping
        
        paymentWidgetSubLabel.translatesAutoresizingMaskIntoConstraints = false
        paymentWidgetSubLabel.text = "You will be redirected to Zip to complete your order."
        paymentWidgetLabel.font = UIFont.preferredFont(forTextStyle: .body)
        paymentWidgetSubLabel.textColor = .gray
        paymentWidgetSubLabel.numberOfLines = 0
        paymentWidgetSubLabel.lineBreakMode = .byWordWrapping
    }
    
    func layout(){
        
        addSubview(paymentWidgetLabel)
     //   addSubview(infoView)
        addSubview(paymentWidgetSubLabel)

      NSLayoutConstraint.activate([
        paymentWidgetLabel.topAnchor.constraint(equalTo: topAnchor),
        paymentWidgetLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        paymentWidgetLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        
//        infoView.leadingAnchor.constraint(equalTo: paymentWidgetLabel.trailingAnchor, constraints: -2),
//        infoView.centerYAnchor.constraint(equalTo: paymentWidgetLabel.centerYAnchor),
//        infoView.heightAnchor.constraint(equalTo: 15),
        paymentWidgetSubLabel.topAnchor.constraint(equalTo: paymentWidgetLabel.bottomAnchor),
        paymentWidgetSubLabel.leadingAnchor.constraint(equalTo: paymentWidgetLabel.leadingAnchor),
        paymentWidgetSubLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        paymentWidgetSubLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
    }
    
}
