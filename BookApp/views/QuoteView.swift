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
        case open
    }
    
    enum Direction: String {
        case rtl
        case ltr
    }
    
    private var indicatorAnimationGroup: CAAnimationGroup!
    private var backgroundAnimationGroup: CAAnimationGroup!
    private var indicatorTransformAnimation: CABasicAnimation!
    private var indicatorOpacityAnimation: CABasicAnimation!
    
    var state: State = .open
    
    var direction: Direction = .ltr
    
    @IBInspectable var text: String = "" {
        didSet {
            messageLabel.text = text
        }
    }
    
    @IBInspectable var indicatorColor: UIColor = .clear {
        didSet {
            self.indicator.fillColor = self.indicatorColor.cgColor
            self.indicator.fillRule = CAShapeLayerFillRule.nonZero
        }
    }
    
    @IBInspectable var rtlEnabled: Bool = false {
        didSet {
            if self.rtlEnabled {
                self.direction = .rtl
            } else {
                self.direction = .ltr
            }
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
    
    lazy var messageLabel: UILabel = {
       let label = UILabel()
        
        label.font = UIFont.init(name: "HelveticaNeue-Medium", size: 13.5)
        label.textColor = UIColor.darkGray
        return label
    }()
    
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
        
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -15.0),
            self.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15.0),
            self.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -15.0),
            self.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 10.0),
        ])
    }
    
    func setupInitialAnimationState() {
        self.state = .closed
        self.satupXForState(state: .closed, rect: .init(origin: .zero, size: self.frame.size))
    }
    
    func clearAnimations() {
        background.removeAllAnimations()
        indicator.removeAllAnimations()
        
        self.state = .closed
        self.satupXForState(state: .closed, rect: .init(origin: .zero, size: self.frame.size))
    }
    
    func startAnimation(beginTime: CFTimeInterval) {
        self.state = .open
        addOpenAnimation(beginTime: beginTime)
    }
    
    override func draw(_ rect: CGRect) {
        satupXForState(state: state, rect: rect)
    }
    
    private func satupXForState(state: State, rect: CGRect) {
        switch state {
        case .open:
            openState(rect: rect)
        case .closed:
            closeState(rect: rect)
        }
    }
    
    func closeState(rect: CGRect) {
        background.removeAllAnimations()
        indicator.removeAllAnimations()
        indicator.position = .init(
            x: rect.width - Constants.indicatorSize.width - Constants.indicatorMarginRight,
            y: Constants.indicatorMarginTop)
        indicator.transform = CATransform3DScale(CATransform3DIdentity, 0.25, 0.25, 1.0)
        indicator.opacity = 0.0
        
        background.frame = rect
        background.opacity = 0.0
        switch direction {
        case .ltr:
            background.position.x = -rect.width * 0.75
        case .rtl:
            background.position.x = rect.width * 0.75
        }
        
        messageLabel.layer.opacity = 0.0
        messageLabel.layer.removeAllAnimations()
    }
    
    func openState(rect: CGRect) {
        background.removeAllAnimations()
        indicator.removeAllAnimations()
        background.frame = rect
        background.opacity = 1.0
        indicator.position.x = rect.width - Constants.indicatorSize.width - Constants.indicatorMarginRight
        indicator.position.y = Constants.indicatorMarginTop
        indicator.transform = CATransform3DIdentity
        messageLabel.layer.opacity = 1.0
        indicator.opacity = 1.0
    }
    
    func addOpenAnimation(beginTime: CFTimeInterval) {
        indicatorOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        indicatorOpacityAnimation.fromValue = 0.0
        indicatorOpacityAnimation.toValue = 1.0
        indicatorOpacityAnimation.duration = 0.3
        indicatorOpacityAnimation.isRemovedOnCompletion = false
        indicatorOpacityAnimation.fillMode = .forwards
        
        indicatorTransformAnimation = CABasicAnimation(keyPath: "transform")
        indicatorTransformAnimation.fromValue = CATransform3DScale(CATransform3DIdentity, 0.25, 0.25, 0.0)
        indicatorTransformAnimation.toValue = CATransform3DIdentity
        indicatorTransformAnimation.duration = 0.3
        indicatorTransformAnimation.isRemovedOnCompletion = false
        indicatorTransformAnimation.fillMode = .forwards
        
        indicatorAnimationGroup = CAAnimationGroup()
        indicatorAnimationGroup.animations = [indicatorTransformAnimation, indicatorOpacityAnimation]
        indicatorAnimationGroup.duration = 0.3
        indicatorAnimationGroup.beginTime = beginTime + 0.5
        indicatorAnimationGroup.isRemovedOnCompletion = false
        indicatorAnimationGroup.fillMode = .forwards
        
        let textOpacity = CABasicAnimation(keyPath: "opacity")
        textOpacity.fromValue = 0.0
        textOpacity.toValue = 1.0
        textOpacity.duration = 0.3
        textOpacity.beginTime = beginTime + 0.8
        textOpacity.isRemovedOnCompletion = false
        textOpacity.fillMode = .forwards

        let backPositionX = CABasicAnimation(keyPath: "position.x")
        switch direction {
        case .ltr:
            backPositionX.fromValue = -frame.width * 0.75
        case .rtl:
            backPositionX.fromValue = frame.width * 0.75
        }
        backPositionX.toValue = 0
        backPositionX.duration = 0.7
        backPositionX.timingFunction = .init(name: .easeIn)
        backPositionX.isRemovedOnCompletion = false
        backPositionX.fillMode = .forwards
        
        let backOpacity = CABasicAnimation(keyPath: "opacity")
        backOpacity.fromValue = 0.0
        backOpacity.toValue = 1.0
        backOpacity.duration = 1.0
        backOpacity.isRemovedOnCompletion = false
        backOpacity.fillMode = .forwards
        
        backgroundAnimationGroup = CAAnimationGroup()
        backgroundAnimationGroup.animations = [backOpacity, backPositionX]
        backgroundAnimationGroup.beginTime = beginTime
        backgroundAnimationGroup.duration = 1.0
        backgroundAnimationGroup.isRemovedOnCompletion = false
        backgroundAnimationGroup.fillMode = .forwards
        
        
        messageLabel.layer.add(textOpacity, forKey: nil)
        indicator.add(indicatorAnimationGroup, forKey: nil)
        background.add(backgroundAnimationGroup, forKey: nil)
    }
}
