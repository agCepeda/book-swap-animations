//
//  QuoteView.swift
//  BookApp
//
//  Created by Agustin Cepeda on 05/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

@IBDesignable
class QuouteView: UIView {
    
    struct Constants {
        static let indicatorSize = CGSize(width: 15.0, height: 20.0)
        static let indicatorMarginTop: CGFloat = -4.0
        static let indicatorMarginRight: CGFloat = 10.0
    }
    
    enum State {
        case closed
        case opened
    }
    
    enum Direction: String {
        case rtl
        case ltr
    }
    
    private var indicatorAnimationGroup: CAAnimationGroup!
    private var backgroundAnimationGroup: CAAnimationGroup!
    private var indicatorTransformAnimation: CABasicAnimation!
    private var indicatorOpacityAnimation: CABasicAnimation!
    
    private var state: State = .opened {
        didSet {
            self.updateForState()
        }
    }
    
    var direction: Direction = .ltr {
        didSet {
            self.updateForState()
        }
    }
    
    lazy var background: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.init(hexString: "#ffffff", alpha: 0.75).cgColor,
            UIColor.init(hexString: "#ffffff", alpha: 0.75).cgColor
        ]
        
        layer.borderColor = UIColor.init(hexString: "#d0d0d0", alpha: 0.55).cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 2.0
        
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = .init(width: 0.0, height: 1.0)
        
        layer.opacity = 0.85
        
        return layer
    }()
    
    lazy var indicator: CAShapeLayer = {
        let layer = CAShapeLayer()
        
        let path = CGMutablePath()
        
        path.move(to: .zero)
        path.addLine(to: .init(x: 15.0, y: 0.0))
        path.addLine(to: .init(x: 15.0, y: 20))
        path.addLine(to: .init(x: 7.5, y: 12.5))
        path.addLine(to: .init(x: 0.0, y: 20))
        path.addLine(to: .zero)
        path.closeSubpath()
        layer.path = path

        layer.strokeColor = UIColor.gray.cgColor
        layer.lineWidth = 0.5
        layer.fillColor = UIColor.lightGray.cgColor
        layer.fillRule = CAShapeLayerFillRule.nonZero
        
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 0.0
        layer.shadowOffset = .init(width: 3.0, height: 3.0)
        
        return layer
    }()
    
    lazy var initialAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "bounds")
        animation.fromValue = NSNumber(value: 20.0)
        animation.toValue = NSNumber(value: 200.0)
        animation.duration = 100
        return animation
    }()
    
    lazy var messageLabel: UILabel = {
       let label = UILabel()
        
        label.font = UIFont.init(name: "HelveticaNeue-Medium", size: 13.5)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    var didAddInitialAnimation = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        background.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        
        self.layer.addSublayer(background)
        self.layer.addSublayer(indicator)
        
        self.addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -15.0),
            self.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15.0),
            self.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -15.0),
            self.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 10.0),
        ])
        messageLabel.text = "One day in his father's closet, Oskar finds a key in a small envelope inside a vase that he..."
        messageLabel.numberOfLines = 0
        
        updateForState()
    }
    
    func open() {
        self.state = .opened
        
        indicator.opacity = 0.0
        addAnimations()

//        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startIndicator), userInfo: nil, repeats: false)
//                timer.fire()
        //
    }
    
    override func draw(_ rect: CGRect) {
        switch self.state {
        case .opened:
            self.openState(rect: rect)
        case .closed:
            self.closeState(rect: rect)
        }
    }
    
    private func updateForState() {
        switch self.state {
        case .opened:
            openState(rect: frame)
        case .closed:
            closeState(rect: frame)
        }
    }
    
    func closeState(rect: CGRect) {
        indicator.frame = CGRect(
            origin: .init(
                x: rect.width - Constants.indicatorSize.width - Constants.indicatorMarginRight,
                y: Constants.indicatorMarginTop
            ),
            size: Constants.indicatorSize
        )
        background.frame = CGRect(
            origin: .zero,
            size: .init(
                width: Constants.indicatorSize.width + Constants.indicatorMarginRight,
                height: rect.size.height
            )
        )
        messageLabel.layer.opacity = 0.0
        indicator.opacity = 0.0
//        indicator.setAffineTransform(CGAffineTransform.identity.scaledBy(x: 0.3, y: 0.3))
    }
    
    func openState(rect: CGRect) {
        self.background.bounds = rect
        self.indicator.frame = CGRect(
            origin: .init(
                x: rect.width - Constants.indicatorSize.width - Constants.indicatorMarginRight,
                y: Constants.indicatorMarginTop
            ),
            size: Constants.indicatorSize
        )
        self.messageLabel.layer.opacity = 1.0
        indicator.opacity = 1.0
        indicator.contentsScale = 1.0
    }
    
    func indicatorAnimation() {
        
        let animation3 = CABasicAnimation(keyPath: "opacity")
        animation3.fromValue = 0.0
        animation3.toValue = 1.0
        animation3.duration = 0.2
        
        let animation4 = CABasicAnimation(keyPath: "contentScale")
        animation4.fromValue = 0.3
        animation4.toValue = 1.0
        animation4.duration = 0.2
        
        
        indicator.add(animation3, forKey: "opacity")
        indicator.add(animation4, forKey: "contentScale")
        messageLabel.layer.add(animation3, forKey: "opacity")
    }
    
    @objc func startIndicator() {

        print("SCHEDULED")
    }
    
    func addAnimations() {
        let currentTime = CACurrentMediaTime()
        
        indicator.opacity = 0.0
        messageLabel.layer.opacity = 0.0
        
        indicatorOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        indicatorOpacityAnimation.fromValue = 0.0
        indicatorOpacityAnimation.toValue = 1.0
        indicatorOpacityAnimation.duration = 0.3
        indicatorOpacityAnimation.delegate = self
        
        indicatorTransformAnimation = CABasicAnimation(keyPath: "transform")
        indicatorTransformAnimation.fromValue = CATransform3DScale(CATransform3DIdentity, 0.25, 0.25, 0.0)
        indicatorTransformAnimation.toValue = CATransform3DIdentity
        indicatorTransformAnimation.duration = 0.3
        
        indicatorAnimationGroup = CAAnimationGroup()
        indicatorAnimationGroup.animations = [indicatorTransformAnimation, indicatorOpacityAnimation]
        indicatorAnimationGroup.duration = 0.3
        indicatorAnimationGroup.beginTime = currentTime + 0.8
        
        let textOpacity = CABasicAnimation(keyPath: "opacity")
        textOpacity.fromValue = 0.0
        textOpacity.toValue = 1.0
        textOpacity.duration = 0.3
        textOpacity.beginTime = currentTime + 0.8

        let backPositionX = CABasicAnimation(keyPath: "position.x")
        backPositionX.toValue = 0
        backPositionX.fromValue = 50.0 - frame.width
        backPositionX.duration = 0.7
        backPositionX.timingFunction = .init(name: .easeIn)
        
        let backOpacity = CABasicAnimation(keyPath: "opacity")
        backOpacity.fromValue = 0.0
        backOpacity.toValue = 1.0
        backOpacity.duration = 1.0
        
        backgroundAnimationGroup = CAAnimationGroup()
        backgroundAnimationGroup.animations = [backOpacity, backPositionX]
        backgroundAnimationGroup.duration = 1.0
        backgroundAnimationGroup.delegate = self
        
        indicator.add(indicatorAnimationGroup, forKey: nil)
        messageLabel.layer.add(textOpacity, forKey: "opacity")
        background.add(backgroundAnimationGroup, forKey: nil)
    }
        
}
extension QuouteView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard flag else { return }
        indicator.opacity = 1.0
        messageLabel.layer.opacity = 1.0
        
    }
    
}
