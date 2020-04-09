//
//  AnimatedDividerView.swift
//  BookApp
//
//  Created by Agustin Cepeda on 09/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

class AnimatedDividerView: UIView {
    
    lazy var cover: CAShapeLayer = {
        let layer = CAShapeLayer()
        
        
        let fromPath = CGMutablePath()
        
        fromPath.move(to: .zero)
        fromPath.addLine(to: .init(x: frame.width, y: 0.0))
        fromPath.addLine(to: .init(x: frame.width, y: 40.0))
        fromPath.addLine(to: .init(x: 0.0, y: 40.0
            ))
        fromPath.addLine(to: .zero)
        fromPath.closeSubpath()
        layer.path = fromPath

//        layer.strokeColor = UIColor.gray.cgColor
//        layer.lineWidth = 0.5
        layer.fillColor = UIColor.init(hexString: "#FEF47B").cgColor
        layer.fillRule = CAShapeLayerFillRule.nonZero
//
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 0.5
        layer.shadowOffset = .init(width: 0.0, height: 3.0)
        
        return layer
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func draw(_ rect: CGRect) {
        self.updatePosition(rect)
    }
    
    func setupView() {
        self.layer.addSublayer(cover)
        self.backgroundColor = UIColor.init(hexString: "#FB8AD4"
        )
    }
    
    func startAnimation() {
        let path = CGMutablePath()
        
        path.move(to: .zero)
        path.addLine(to: .init(x: frame.width, y: 0.0))
        path.addLine(to: .init(x: frame.width, y: 10.0))
        path.addLine(to: .init(x: 0.0, y: frame.height))
        path.addLine(to: .zero)
        
        path.closeSubpath()
        cover.path = path
        
        
        let fromPath = CGMutablePath()
        
        fromPath.move(to: .zero)
        fromPath.addLine(to: .init(x: frame.width, y: 0.0))
        fromPath.addLine(to: .init(x: frame.width, y: 40.0))
        fromPath.addLine(to: .init(x: 0.0, y: 40.0))
        fromPath.addLine(to: .zero)
        fromPath.closeSubpath()
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = fromPath
        animation.toValue = path
        animation.duration = 1.0
        animation.timingFunction = .init(name: .easeOut)
        
        cover.add(animation, forKey: "path")
        
    }
    
    private func updatePosition(_ rect: CGRect) {
//        let transform = CGAffineTransform.identity
//            .translatedBy(x: rect.width / 2, y: rect.height/2)
//            .rotated(by: atan(rect.height / rect.width))
        
//        cover.bounds = CGRect(
//            origin: .zero,
//            size: .init(
//                width: sqrt(pow(rect.width, 2.0) + pow(rect.height, 2.0)),
//                height: rect.height
//            )
//        )
//        cover.anchorPoint = CGPoint(x: 0.0, y: cover.anchorPoint.y)
//        cover.setAffineTransform(transform)
        
//        let transform = CGAffineTransform.identity
//            .scaledBy(x: rect.width / 10.0, y: rect.height / 10.0)
//        cover.setAffineTransform(transform)
    }
}
