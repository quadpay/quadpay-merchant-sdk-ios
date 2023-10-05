//
//  FeeTierText.swift
//  QuadPaySDK
//
//  Created by Petros Andreou on 26/04/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation
import UIKit

public final class FeeTierText: UIView{
    
    let feeTierLabel = UILabel()
    
    let PRE_FEE_TEXT : String = "There may be a "
    
    let POST_FEE_TEXT : String = "finance charge to use Zip."
    
    let CHARGE_INCLUDED_TEXT : String = " This charge is included above."
    
    var maxFee: Double?
    
    var hideTimeline : Bool?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func style(){
        feeTierLabel.translatesAutoresizingMaskIntoConstraints = false
        var feeMessage = ""
        let formatter = NumberFormatter()
     

        if(maxFee?.truncatingRemainder(dividingBy: 1) == 0){
            formatter.maximumFractionDigits = 0
            formatter.minimumFractionDigits = 0
        }else{
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
        }
        
        let feeAsString = formatter.string(for: maxFee) ?? "0"
        if(hideTimeline ?? false){
            feeMessage = PRE_FEE_TEXT + "$\(feeAsString) " + POST_FEE_TEXT
        }else{
            feeMessage = PRE_FEE_TEXT + "$\(feeAsString) " + POST_FEE_TEXT + CHARGE_INCLUDED_TEXT
        }
        
        feeTierLabel.font = UIFont(name: "SharpGroteskMedium20", size: 10)
        feeTierLabel.text = feeMessage
        feeTierLabel.textColor = .gray
        feeTierLabel.numberOfLines = 0
        feeTierLabel.lineBreakMode = .byWordWrapping
    }
    
    func layout(){
        addSubview(feeTierLabel)
        NSLayoutConstraint.activate([
            feeTierLabel.topAnchor.constraint(equalTo: topAnchor),
            feeTierLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            feeTierLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            feeTierLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
