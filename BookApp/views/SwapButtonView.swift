//
//  SwapButtonView.swift
//  BookApp
//
//  Created by Agustin Cepeda on 11/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

@IBDesignable class SwapButtonView: UIView {
    
    struct Constants {
        static let iconSize: CGSize = .init(width: 25.0, height: 20.0)
        static let titleHeight: CGFloat = 20.0
    }
    
    enum State {
        case shown
        case hidden
    }
    
    var state: State = .shown
    
    lazy var background: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.white.cgColor, UIColor.systemGroupedBackground.cgColor]
        return layer
    } ()
    
    lazy var titleLabel: CATextLayer = {
        let layer = CATextLayer()
        layer.string = "SWAP"
        layer.alignmentMode = .center
        layer.backgroundColor = UIColor.clear.cgColor
        layer.foregroundColor = UIColor.systemBlue.cgColor
        layer.fontSize = 15.0
        layer.contentsScale = UIScreen.main.scale
        layer.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        return layer
    } ()
    
    lazy var maskIcon: CALayer = {
        let mask = CALayer()
        mask.contents = UIImage(systemName: "arrow.2.circlepath")?.cgImage
        return mask
    }()
    
    lazy var icon: CALayer = {
        let layer = CALayer()
        
        
        layer.mask = self.maskIcon
        
        return layer
    } ()
    
    override var tintColor: UIColor! {
        didSet {
            self.icon.backgroundColor = self.tintColor.cgColor
            self.titleLabel.foregroundColor = self.tintColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = UIColor.clear
        shadowColor = UIColor.darkGray
        shadowOffset = .init(width: 0.0, height: 2.0)
        shadowRadius = 3.0
        shadowOpacity = 0.5
        layer.addSublayer(background)
        layer.addSublayer(icon)
        layer.addSublayer(titleLabel)
        adjustInRect(frame)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        adjustInRect(rect)
    }
    
    func adjustInRect(_ rect: CGRect) {
        background.cornerRadius = rect.height / 2
        icon.frame = CGRect(
            origin: CGPoint(
                x: 10.0,
                y: (rect.height - Constants.iconSize.height) * 0.5
            ),
            size: Constants.iconSize)
        maskIcon.frame = CGRect(origin: .zero, size: Constants.iconSize)
        titleLabel.frame = CGRect(
            origin: CGPoint(
                x: 0.0,
                y: (rect.height - Constants.titleHeight) / 2.0),
            size: CGSize(
                width: rect.width,
                height: Constants.titleHeight
            )
        )
        switch state {
        case .shown:
            background.frame = rect
            background.opacity = 1.0
            background.transform = CATransform3DIdentity
            titleLabel.opacity = 1.0
            icon.opacity = 1.0
        case .hidden:
            background.frame = CGRect(
                origin: CGPoint(x: (rect.width - rect.height) / 2, y: 0.0),
                size: CGSize(width: rect.height, height: rect.height)
            )
            background.opacity = 0.0
            titleLabel.opacity = 0.0
            
            icon.opacity = 0.0
        }
    }
    func setupInitialAnimationState() {
        state = .hidden
        background.removeAllAnimations()
        icon.removeAllAnimations()
        titleLabel.removeAllAnimations()
        adjustInRect(.init(origin: .zero, size: frame.size))
    }
    
    func startAnimation(beginTime: CFTimeInterval) {
        state = .shown
        startBackgrounAnimation(beginTime: beginTime)
        startTitleAnimation(beginTime: beginTime)
        startIconAnimation(beginTime: beginTime + 0.7)
        
    }
    
    func startIconAnimation(beginTime: CFTimeInterval) {
        let opacity =  CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0.0
        opacity.toValue = 1.0
        opacity.duration = 0.5
//        opacity.beginTime = beginTime + 0.4
        opacity.fillMode = .forwards
        opacity.isRemovedOnCompletion = false
        
        let transform = CABasicAnimation(keyPath: "transform.rotation.z")
        transform.fromValue = CGFloat.pi / 2.0
        transform.toValue = CGFloat.pi * 2
        transform.duration = 1.0
//        transform.beginTime = beginTime + 0.4
        transform.timingFunction = .init(name: .easeOut)
        transform.fillMode = .forwards
        transform.isRemovedOnCompletion = false
        

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [ opacity, transform]
        animationGroup.duration = 1.0
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = .forwards
        animationGroup.beginTime = beginTime
        
        icon.add(animationGroup, forKey: nil)
    }

    func startTitleAnimation(beginTime: CFTimeInterval) {
        let titleOpacity = CABasicAnimation(keyPath: "opacity")
        titleOpacity.fromValue = 0.0
        titleOpacity.toValue = 1.0
        titleOpacity.duration = 0.3
        titleOpacity.beginTime = beginTime + 0.4
        titleOpacity.fillMode = .forwards
        titleOpacity.isRemovedOnCompletion = false
        
        titleLabel.add(titleOpacity, forKey: nil)
    }
    
    
    func startBackgrounAnimation(beginTime: CFTimeInterval) {
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0.0
        opacity.toValue = 1.0
        opacity.duration = 0.3
        opacity.fillMode = .forwards
        opacity.isRemovedOnCompletion = false
        
        let transform = CABasicAnimation(keyPath: "transform")
        transform.fromValue = CATransform3DScale(CATransform3DIdentity, 0.25, 0.25, 1.0)
        transform.toValue = CATransform3DIdentity
        transform.duration = 0.3
        transform.fillMode = .forwards
        transform.isRemovedOnCompletion = false
        
        let cornerRadius = CAKeyframeAnimation(keyPath: "cornerRadius")
        cornerRadius.values =  [
            CGFloat(5.0),
            CGFloat(22.5),
            CGFloat(22.5)
        ]
        cornerRadius.duration = 0.7
        cornerRadius.beginTime = 0.0
        cornerRadius.fillMode = .forwards
        cornerRadius.isRemovedOnCompletion = false
        
        let bounds = CAKeyframeAnimation(keyPath: "bounds.size")
        bounds.values =  [
            CGSize(width: 10.0, height: 10.0),
            CGSize(width: 45.0, height: 45.0),
            CGSize(width: 190.0, height: 45.0)
        ]
        bounds.duration = 0.7
        bounds.beginTime = 0.0
        bounds.fillMode = .forwards
        bounds.isRemovedOnCompletion = false
        
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [opacity,cornerRadius, bounds]
        animationGroup.duration = 1.0
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = .forwards
        animationGroup.beginTime = beginTime
        
        background.add(animationGroup, forKey: nil)
    }
}
