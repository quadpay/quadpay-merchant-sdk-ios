
import Foundation
import UIKit

/// A view that displays informative text, the Afterpay badge and an info link. The info link will
/// launch externally by default but can launch modally in app by implementing
/// PriceBreakdownViewDelegate. This view updates in response to Afterpay configuration changes
/// as well as changes to the `totalAmount`.
@available(iOS 10.0, *)
@available(iOS 12.0, *)
public final class PaymentWidgetHeaderText: UIView {
    
    var paymentWidgetLabel = UILabel()
  //  let infoView = makeSymbolImageView(systemName: "star.fill")
    
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
        paymentWidgetLabel.font = UIFont.preferredFont(forTextStyle: .body)

    }
    
    func layout(){
        
        addSubview(paymentWidgetLabel)
     //   addSubview(infoView)


      NSLayoutConstraint.activate([
        paymentWidgetLabel.topAnchor.constraint(equalTo: topAnchor),
        paymentWidgetLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        paymentWidgetLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        paymentWidgetLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

//        infoView.leadingAnchor.constraint(equalTo: paymentWidgetLabel.trailingAnchor, constraints: -2),
//        infoView.centerYAnchor.constraint(equalTo: paymentWidgetLabel.centerYAnchor),
//        infoView.heightAnchor.constraint(equalTo: 15),

      ])
    }
    
}
