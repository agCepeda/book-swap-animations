//
//  BackgroundView.swift
//  BookApp
//
//  Created by Agustin Cepeda on 14/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {
    lazy var secondLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
//        layer.shadowColor = UIColor.darkGray.cgColor
//        layer.shadowOffset = .init(width: 1.0, height: 1.0)
//        layer.shadowRadius = 10.0
//        layer.shadowOpacity = 0.1
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    
    lazy var thirdLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
//        layer.shadowColor = UIColor.darkGray.cgColor
//        layer.shadowOffset = .init(width: 1.0, height: 1.0)
//        layer.shadowRadius = 10.0
//        layer.shadowOpacity = 0.1
        self.layer.insertSublayer(layer, at: 1)
        return layer
    }()
    
    @IBInspectable var secondColor: UIColor = .clear {
        didSet {
            self.secondLayer.fillColor = self.secondColor.cgColor
        }
    }
    
    @IBInspectable var thirdColor: UIColor = .clear {
        didSet {
            
            self.thirdLayer.fillColor = self.thirdColor.cgColor
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        let secondPath = CGMutablePath()
        
        secondPath.move(to: .zero)
        secondPath.addLine(to: .init(x: rect.width * 0.75, y: 0.0))
        if rect.height >= rect.width * 0.35 {
            secondPath.addLine(to: .init(x: 0.0, y: rect.width * 0.35))
        } else {
            let dx = rect.width * 0.75
            let dy = rect.width * 0.35
            let m = dx / dy
            
            let posX = (dy - rect.height) * m
            
            secondPath.addLine(to: .init(x: posX, y: rect.height))
            secondPath.addLine(to: .init(x: 0.0, y: rect.height))
            
        }
        
        secondPath.addLine(to: .zero)
        secondPath.closeSubpath()
        
        let thirdPath = CGMutablePath()
        
        thirdPath.move(to: .zero)
        thirdPath.addLine(to: .init(x: rect.width * 0.35, y: 0.0))
        thirdPath.addLine(to: .init(x: 0.0, y: rect.width * 0.15))
        thirdPath.addLine(to: .zero)
        thirdPath.closeSubpath()
        
        thirdLayer.fillColor = self.thirdColor.cgColor
        thirdLayer.path = thirdPath
        
        secondLayer.fillColor = self.secondColor.cgColor
        secondLayer.path = secondPath
        secondLayer.frame = rect
        thirdLayer.frame = rect
    }
}

