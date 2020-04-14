//
//  AnimatedDividerView.swift
//  BookApp
//
//  Created by Agustin Cepeda on 09/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

@IBDesignable
class AnimatedDividerView: UIView {
    
    lazy var cover: CAShapeLayer = {
        let layer = CAShapeLayer()
        
        
        let fromPath = CGMutablePath()
        
        fromPath.move(to: .zero)
        fromPath.addLine(to: .init(x: frame.width, y: 0.0))
        fromPath.addLine(to: .init(x: frame.width, y: 1.0))
        fromPath.addLine(to: .init(x: 0.0, y: 1.0))
        fromPath.addLine(to: .zero)
        fromPath.closeSubpath()
        layer.path = fromPath

//        layer.strokeColor = UIColor.gray.cgColor
//        layer.lineWidth = 0.5
        layer.fillRule = CAShapeLayerFillRule.nonZero
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = .init(width: 0.0, height: 2.0)
        layer.zPosition = -100
        
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
//        self.updatePosition(rect)
        
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.yellow {
        didSet {
            self.cover.fillColor = self.secondColor.cgColor
        }
    }
    
    func setupView() {
        self.layer.addSublayer(cover)
    }
    
    func startAnimation(beginTime: CFTimeInterval) {
        let path = CGMutablePath()
        
        path.move(to: .zero)
        path.addLine(to: .init(x: frame.width, y: 0.0))
        path.addLine(to: .init(x: frame.width, y: 1.0))
        path.addLine(to: .init(x: 0.0, y: frame.height))
        path.addLine(to: .zero)
        
        path.closeSubpath()
        
        let fromPath = CGMutablePath()
        
        fromPath.move(to: .zero)
        fromPath.addLine(to: .init(x: frame.width, y: 0.0))
        fromPath.addLine(to: .init(x: frame.width, y: 1.0))
        fromPath.addLine(to: .init(x: 0.0, y: 1.0))
        fromPath.addLine(to: .zero)
        fromPath.closeSubpath()
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = fromPath
        animation.toValue = path
        animation.duration = 1.0
        animation.timingFunction = .init(name: .easeOut)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.beginTime = beginTime
        
        cover.add(animation, forKey: "path")
        
    }
    func setupInitialAnimationState() {
        cover.removeAllAnimations()
        
        let fromPath = CGMutablePath()
        
        fromPath.move(to: .zero)
        fromPath.addLine(to: .init(x: frame.width, y: 0.0))
        fromPath.addLine(to: .init(x: frame.width, y: 10.0))
        fromPath.addLine(to: .init(x: 0.0, y: 0.0))
        fromPath.addLine(to: .zero)
        fromPath.closeSubpath()
        
        cover.path = fromPath
    }
}
