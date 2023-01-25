//
//  Timelapse.swift
//  QuadPaySDK
//
//  Created by Petros Andreou on 10/01/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation
import UIKit

enum Shape {
    case rectangle
    case skewRectangle
}

class DrawView : UIView {
    
    var currentShape : Shape?
    
    override func draw(_ rect: CGRect) {
        print("The draw method has been called.")
    }
    
    private func drawRectangle(user context: CGContext, isFilled: Bool){
       //add something
        let strokeDistance: CGFloat = 25
        
        let centerPoint  = CGPoint(x: bounds.size.width/2, y:bounds.size.height/2)
        
        let lowerLeftCorner = CGPoint (x: centerPoint.x - strokeDistance, y: centerPoint.y + strokeDistance)
        
        let lowerRightCorner = CGPoint (x: centerPoint.x + strokeDistance, y: centerPoint.y + strokeDistance)
        
        let upperRightCorner = CGPoint (x: centerPoint.x + strokeDistance, y: centerPoint.y - strokeDistance * 2)
        
        let upperLeftCorner = CGPoint (x: centerPoint.x - strokeDistance, y: centerPoint.y - strokeDistance * 2)
        
        context.move(to: lowerLeftCorner)
        context.addLine(to: lowerLeftCorner)
        context.addLine(to: lowerRightCorner)
        context.addLine(to: upperRightCorner)
        context.addLine(to: upperLeftCorner)
        context.addLine(to: lowerLeftCorner)
        
        context.setLineCap(.square)
        context.setLineWidth(8.0)
        if isFilled {
            context.setFillColor(UIColor.purple.cgColor)
            context.fillPath()
        }else {
            context.setStrokeColor(UIColor.red.cgColor)
            context.strokePath()
        }
        
    }
    
    
    func drawShape(selectedShape: Shape){
        currentShape = selectedShape
        setNeedsDisplay()
    }
    
}
