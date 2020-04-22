//
//  CloseableView.swift
//  BookApp
//
//  Created by Agustin Cepeda on 19/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

@IBDesignable class CloseableView: UIView {
    
    struct Constant {
        static let centerOffset: CGFloat = 70.0
        static let shadowColor = UIColor.darkGray.cgColor
        static let shadowOffsetY: CGFloat = 2.0
        static let shadowOpacity: Float = 0.5
        static let shadowRadius: CGFloat = 3.0
    }
    
    enum State {
        case open, closed, finished
    }
    
    lazy var upperLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.shadowColor = Constant.shadowColor
        layer.shadowOffset = .init(width: 0.0, height: Constant.shadowOffsetY)
        layer.shadowOpacity = Constant.shadowOpacity
        layer.shadowRadius = Constant.shadowRadius
        return layer
    }()
    
    lazy var lowerLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.shadowColor = Constant.shadowColor
        layer.shadowOffset = .init(width: 0.0, height: -Constant.shadowOffsetY)
        layer.shadowOpacity = Constant.shadowOpacity
        layer.shadowRadius = Constant.shadowRadius
        return layer
    }()
    
    @IBInspectable var upperColor: UIColor = UIColor.white {
        didSet {
            upperLayer.fillColor = self.upperColor.cgColor
        }
    }
    
    @IBInspectable var lowerColor: UIColor = UIColor.white {
        didSet {
            lowerLayer.fillColor = self.lowerColor.cgColor
        }
    }
    
    private var state: State = .finished
    
    private var upperRect: CGRect = .zero
    private var lowerRect: CGRect = .zero
    
    func setupOpenState(upper: CGRect, lower: CGRect) {
        self.state = .open
        self.upperRect = upper
        self.lowerRect = lower
        self.setNeedsLayout()
    }
    
    func setupCloseState() {
        self.state = .closed
        self.setNeedsLayout()
    }
    
    func getUpperClosedPath() -> CGPath {
        let halfHeight = frame.height / 2.0
        let mutable = CGMutablePath()
        mutable.move(to: .zero)
        mutable.addLine(to: .init(x: frame.width, y: 0.0))
        mutable.addLine(to: .init(x: frame.width, y: halfHeight - Constant.centerOffset))
        mutable.addLine(to: .init(x: 0.0, y: halfHeight - Constant.centerOffset))
        mutable.addLine(to: .zero)
        mutable.closeSubpath()
        return mutable
    }
    
    func getLowerClosedPath() -> CGPath {
        let halfHeight = frame.height / 2.0
        let mutable = CGMutablePath()
        if (lowerRect.origin.y > halfHeight - Constant.centerOffset) {
            mutable.move(to: .init(x: 0.0, y: halfHeight - Constant.centerOffset))
            mutable.addLine(to: .init(x: frame.width, y: halfHeight - Constant.centerOffset))
        } else {
            mutable.move(to: .init(x: 0.0, y: lowerRect.origin.y))
            mutable.addLine(to: .init(x: frame.width, y: lowerRect.origin.y))
        }
        
        mutable.addLine(to: .init(x: frame.width, y: frame.height))
        mutable.addLine(to: .init(x: 0.0, y: frame.height))
        mutable.addLine(to: .zero)
        mutable.closeSubpath()
        return mutable
    }
    
    
    func getUpperFinalPath() -> CGPath {
        let halfHeight = frame.height / 2.0
        let mutable = CGMutablePath()
        mutable.move(to: .zero)
        mutable.addLine(to: .init(x: frame.width, y: 0.0))
        mutable.addLine(to: .init(x: frame.width, y: halfHeight - Constant.centerOffset))
        mutable.addLine(to: .init(x: 0.0, y: halfHeight + Constant.centerOffset))
        mutable.addLine(to: .zero)
        mutable.closeSubpath()
        return mutable
    }
    
    func getLowerFinalPath() -> CGPath {
        let halfHeight = frame.height / 2.0
        let mutable = CGMutablePath()
        mutable.move(to: .init(x: 0.0, y: halfHeight - Constant.centerOffset))
        mutable.addLine(to: .init(x: frame.width, y: halfHeight - Constant.centerOffset))
        mutable.addLine(to: .init(x: frame.width, y: frame.height))
        mutable.addLine(to: .init(x: 0.0, y: frame.height))
        mutable.addLine(to: .zero)
        mutable.closeSubpath()
        return mutable
    }
    
    
    func getUpperOpenPath() -> CGPath {
        return CGPath(rect: upperRect, transform: nil)
    }
    
    func getLowerOpenPath() -> CGPath {
        return CGPath(rect: lowerRect, transform: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        layer.addSublayer(lowerLayer)
        layer.addSublayer(upperLayer)
        
        lowerLayer.fillColor = UIColor.red.cgColor
        upperLayer.fillColor = UIColor.green.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch state {
        case .open:
            upperLayer.path = getUpperOpenPath()
            lowerLayer.path = getLowerOpenPath()
        case .closed:
            upperLayer.path = getUpperClosedPath()
            lowerLayer.path = getLowerClosedPath()
        case .finished:
            upperLayer.path = getUpperFinalPath()
            lowerLayer.path = getLowerFinalPath()
        }
    }
    
    func clearAnimations() {
        upperLayer.removeAllAnimations()
        lowerLayer.removeAllAnimations()
    }
    
    typealias Completion = () -> Void
    
    // MARK:- CLOSE ANIMATIONS
    func closeAnimation(_ completion: Completion? = nil) {
        clearAnimations()
        upperCloseAnimation(completion)
        lowerCloseAnimation()
        state = .closed
    }
    
    func upperCloseAnimation(_ completion: Completion? = nil) {
        let newPath = getUpperClosedPath()
        upperLayer.path = newPath
        let path = CABasicAnimation(keyPath: "path")
        path.fromValue = getUpperOpenPath()
        path.toValue = newPath
        path.duration = 0.5
        
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0.15
        opacity.toValue = 1.0
        opacity.duration = 0.25
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [opacity, path]
        animationGroup.duration = 0.5
        
        upperLayer.addAnimation(animationGroup, forKey: nil) { _, _ in
            completion?()
        }
    }
    
    func lowerCloseAnimation() {
        let newPath = getLowerClosedPath()
        lowerLayer.path = newPath
        let path = CABasicAnimation(keyPath: "path")
        path.fromValue = getLowerOpenPath()
        path.toValue = newPath
        path.duration = 0.5
        
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0.15
        opacity.toValue = 1.0
        opacity.duration = 0.25
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [opacity, path]
        animationGroup.duration = 0.5
        
        lowerLayer.add(animationGroup, forKey: nil)
    }

    // MARK:- FINISH ANIMATIONS
    func finishAnimation(beginTime: CFTimeInterval) {
        clearAnimations()
        upperFinishAnimation(beginTime: beginTime)
        lowerFinishAnimation(beginTime: beginTime)
    }
    
    func upperFinishAnimation(beginTime: CFTimeInterval) {
        let newPath = getUpperFinalPath()
        upperLayer.path = newPath
        let path = CABasicAnimation(keyPath: "path")
        path.fromValue = getUpperClosedPath()
        path.toValue = newPath
        path.duration = 1.0
        path.beginTime = beginTime
        path.timingFunction = .init(name: .easeOut)
        
        upperLayer.add(path, forKey: nil)
    }
    
    func lowerFinishAnimation(beginTime: CFTimeInterval) {
        let newPath = getLowerFinalPath()
        lowerLayer.path = newPath
        let path = CABasicAnimation(keyPath: "path")
        path.fromValue = getLowerClosedPath()
        path.toValue = newPath
        path.duration = 1.0
        path.beginTime = beginTime
        path.timingFunction = .init(name: .easeOut)
        
        lowerLayer.add(path, forKey: nil)
    }
}
