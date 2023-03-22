//
//  LogoView.swift
//  QuadPaySDK
//
//  Created by Lai Tang on 22/06/2022.
//

import Foundation
import UIKit

public class ZipPayLogo: UIView {
    
    public var logo = "logo_main"
  
    internal var image: UIImage?
    private var imageView = UIImageView(frame: .zero)

    internal var minimumWidth: CGFloat = 64

    public var ratio: CGFloat?

    public init(logoOption: String) {
        super.init(frame: .zero)
        switch logoOption.lowercased(){
        case "secondary":
            logo = logoOption.lowercased()
        case "secondary-light":
            logo = logoOption.lowercased()
        case "black-white":
            logo = logoOption.lowercased()
        case "welcome_pay":
            logo = logoOption.lowercased()
        default:
            logo = "logo_main"
        }
        sharedInit()
      }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
      }
    
    internal func sharedInit() {
        isAccessibilityElement = true
        updateImage(withTraits: traitCollection)
      }

      override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
          updateImage(withTraits: traitCollection )
      }

    internal func updateImage(withTraits traitCollection: UITraitCollection) {
        
        accessibilityLabel = "Pay with Zip Pay"

        deactivateConstraints()
          
        image =  AssetProvider.image(named: logo)
        
          

        ratio = image!.size.height / image!.size.width
            
      

        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)

        setImageViewConstraints()
        setupConstraints()
      }

      internal func setImageViewConstraints() {
        NSLayoutConstraint.activate([
          imageView.widthAnchor.constraint(equalTo: widthAnchor),
          imageView.heightAnchor.constraint(equalTo: heightAnchor),
        ])
      }

      private var aspectRatioConstraint: NSLayoutConstraint!
      private var minimumWidthConstraint: NSLayoutConstraint!

      private func setupConstraints() {
        aspectRatioConstraint = heightAnchor.constraint(equalTo: widthAnchor, multiplier: ratio!)
        minimumWidthConstraint = widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor)

        NSLayoutConstraint.activate([ aspectRatioConstraint, minimumWidthConstraint ])
      }

      private func deactivateConstraints() {
        if aspectRatioConstraint != nil {
          aspectRatioConstraint.isActive = false
        }

        if minimumWidthConstraint != nil {
          minimumWidthConstraint.isActive = false
        }
      }

      @objc private func configurationDidChange(_ notification: NSNotification) {
        DispatchQueue.main.async {
            self.updateImage(withTraits: self.traitCollection)
        }
      }
}
