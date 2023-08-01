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
    
    let initialFrameWidth: CGFloat = 180
    var actualFrameWidth: CGFloat?
    
    let initialAmount: String = "0"
    var amount: String?
    
    let initialHeight: CGFloat = 80
    
    let initialDepth: CGFloat = 3
    var depth: CGFloat?
    
    var deviceAdjustment: CGFloat = 1.0
    
    var maxFee: Double?
    
    let initialTimelineColor: CGColor = UIColor.zipPurple.cgColor
    var actualTimelineColor: CGColor?
    
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
        var amountAsFloat  = Double(amountAsString) ?? 0.00
        
        
        amountAsFloat = amountAsFloat + (maxFee ?? 0.0)
        
        let transactionAmount = formatter.string(for: amountAsFloat/4) ?? "0"
        for _ in 0...4{
            amountLabels.append(transactionAmount)
        }
        return amountLabels
    }
    
    func layout(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .left
        drawTimelapseGraph()
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func drawTimelapseGraph(){
        
        let frameWidth: CGFloat = actualFrameWidth ?? initialFrameWidth
        if(UIDevice.current.userInterfaceIdiom == .pad){
            deviceAdjustment = 2
        }
        
        let padding: CGFloat = 5
        let squareSize: CGFloat = 10
        let lineWidth: CGFloat = 2
        let numberOfSquares: CGFloat = 4
        let numberOfSections = numberOfSquares - 1
        
        let spacingBetweenSquares = (frameWidth - 8 * padding) / (numberOfSections + 0.5) * deviceAdjustment
        
        //Move the x of the image
        let shortSegmentLegth = spacingBetweenSquares * 0 // 0.20
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: frame.width, height: initialHeight))
        
        var squares: [CGPoint] = []
        
        let weekLabels: [String] = ["Due today", "2 weeks", "4 weeks", "6 weeks"]
        
        let indicatoOffset: CGFloat = 20
        
        let yOffset = (squareSize + lineWidth) / 2 + indicatoOffset
        
        let img = renderer.image { ctx in
            
            //Define our squares
            for index in 0...Int((numberOfSquares - 1)){
                let x = shortSegmentLegth + ( spacingBetweenSquares * CGFloat(index))
                squares.append(CGPoint(x: x, y: yOffset))
               
            }
            
            //Define our lines between squares
            ctx.cgContext.setLineWidth(lineWidth)
            ctx.cgContext.setStrokeColor(actualTimelineColor ?? initialTimelineColor)
            ctx.cgContext.move(to: CGPoint(x: squares[0].x + (squareSize), y: squares[0].y))
            ctx.cgContext.addLine(to: CGPoint(x: squares[3].x + (squareSize), y: squares[0].y))
            ctx.cgContext.strokePath()
            ctx.cgContext.setFillColor(actualTimelineColor ?? initialTimelineColor)
            
            
            //Define our depth
            let actualDepth = depth ?? initialDepth
            //Draw our squares
            for square in squares{
                //Instead of using addRect to draw our rectangles
                //since we need to add angles sometimes.
                ctx.cgContext.move(to: CGPoint(x: square.x , y: square.y - (squareSize * 0.5)))
                ctx.cgContext.addLine(to: CGPoint(x: square.x + (squareSize), y: square.y - (squareSize * 0.5)))
                ctx.cgContext.addLine(to: CGPoint(x: square.x + (squareSize) + actualDepth, y: square.y + (squareSize * 0.5)))
                ctx.cgContext.addLine(to: CGPoint(x: square.x + actualDepth, y: square.y + (squareSize * 0.5)))
                
                //ctx.cgContext.addRect(squareBounds)
                ctx.cgContext.drawPath(using: .fillStroke)
            }
            
            //Draw our labels
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "SharpGroteskMedium20", size: 12),
                .paragraphStyle: paragraphStyle,
              
            ]
            
            let attrsWeeks: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "SharpGroteskBook20", size: 12),
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.gray

            ]
            
            let amountLabels = populateAmountLabel()
            
            for (i, square) in squares.enumerated() {
                let amountString = amountLabels[i]
                let weeksString = weekLabels[i]
                
                
                let attributedAmountString = NSAttributedString(string: "$" + amountString, attributes: attrs)
                attributedAmountString.draw(with: CGRect(x: square.x , y: square.y + 10, width: 100, height: 20), options: .usesLineFragmentOrigin, context: nil)
                
                let attributedWeekString = NSAttributedString(string: weeksString, attributes: attrsWeeks)
                attributedWeekString.draw(with: CGRect(x: square.x, y: square.y + 30, width: 100, height: 20), options: .usesLineFragmentOrigin, context: nil)
            }
        }
        imageView.image = img
    }
}
