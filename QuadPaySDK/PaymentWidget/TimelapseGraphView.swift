//
//  TimelapseGraphView.swift
//  QuadPaySDK
//
//  Created by Petros Andreou on 13/01/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//
import UIKit

public final class TimelapseGraphView: UIView {
    
    let imageView = UIImageView()
    
    let initialFrameWidth: CGFloat = 200
    var actualFrameWidth: CGFloat?
    
    let initialAmount: String = "0"
    var amount: String?
    
    let height: CGFloat = 100

    
    let initialTimelapseColor: CGColor = UIColor.zipPurple.cgColor
    var actualTimelapseColor: CGColor?
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TimelapseGraphView {
    func populateAmountLabel() -> [String]{
        
        var amountLabels: [String] = []
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        let amountAsString: String = amount ?? initialAmount
        let amountAsFloat  = Double(amountAsString) ?? 0.00
        let transactionAmount = formatter.string(for: amountAsFloat/4) ?? "0"
        for _ in 0...4{
            amountLabels.append(transactionAmount)
        }
        return amountLabels
    }
    
    func layout(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        drawTimelapseGraph()
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func drawTimelapseGraph(){
        
        let frameWidth: CGFloat = actualFrameWidth ?? initialFrameWidth
        
        let padding: CGFloat = 10
        let squareSize: CGFloat = 10
        let lineWidth: CGFloat = 2
        let numberOfSquares: CGFloat = 4
        let numberOfSections = numberOfSquares - 1
        
        
        let spacingBetweenSquares = (frameWidth - 8 * padding) / (numberOfSections + 0.5)
        
        let shortSegmentLegth = spacingBetweenSquares * 0.25
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: frameWidth, height: height))
        
        var squares: [CGPoint] = []
        
        let weekLabels: [String] = ["Due today", "In 2 weeks", "In 4 weeks", "In 6 Weeks"]
        
        let indicatoOffset: CGFloat = 34
        let yOffset = (squareSize + lineWidth) / 2 + indicatoOffset
        
        let img = renderer.image { ctx in
            
            //Define our squares
            for index in 0...Int((numberOfSquares - 1)){
                let x = padding + shortSegmentLegth + ( spacingBetweenSquares * CGFloat(index))
                squares.append(CGPoint(x: x, y: yOffset))
            }
            
            //Define our lines between squares
            ctx.cgContext.setLineWidth(lineWidth)
            ctx.cgContext.setStrokeColor(actualTimelapseColor ?? initialTimelapseColor)
            ctx.cgContext.addLines(between: squares)
            ctx.cgContext.strokePath()
            
            ctx.cgContext.setFillColor(actualTimelapseColor ?? initialTimelapseColor)
            
            //Draw our squares
            for square in squares{
                let squareBounds = CGRect(x: square.x - (squareSize * 0.5), y: square.y - (squareSize * 0.5), width: squareSize, height: squareSize)
                
                ctx.cgContext.addRect(squareBounds)
                ctx.cgContext.drawPath(using: .fillStroke)
            }
            
            //Draw our labels
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.preferredFont(forTextStyle: .footnote),
                .paragraphStyle: paragraphStyle,
              
            ]
            
            let attrsWeeks: [NSAttributedString.Key: Any] = [
                .font: UIFont.preferredFont(forTextStyle: .footnote),
                .paragraphStyle: paragraphStyle,

            ]
            
            let amountLabels = populateAmountLabel()
            
            for (i, square) in squares.enumerated() {
                let amountString = amountLabels[i]
                let weeksString = weekLabels[i]
                
                
                let attributedAmountString = NSAttributedString(string: "$" + amountString, attributes: attrs)
                attributedAmountString.draw(with: CGRect(x: square.x - 5 , y: square.y + 10, width: 100, height: 20), options: .usesLineFragmentOrigin, context: nil)
                
                let attributedWeekString = NSAttributedString(string: weeksString, attributes: attrsWeeks)
                attributedWeekString.draw(with: CGRect(x: square.x - 5 , y: square.y + 30, width: 100, height: 20), options: .usesLineFragmentOrigin, context: nil)
            }
        }
        imageView.image = img
    }
}
