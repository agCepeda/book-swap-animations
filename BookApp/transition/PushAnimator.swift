//
//  PushAnimator.swift
//  BookApp
//
//  Created by Agustin Cepeda on 02/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

open class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
//    lazy var bottomBackground: CAShapeLayer = {
//        let layer = CAShapeLayer()
//        layer.path = CGPath.init(ellipseIn: .init(origin: .zero, size: .init(width: 45.0, height: 45.0)), transform: nil)
//
//
//        layer.shadowColor = UIColor.darkGray.cgColor
//        layer.shadowOffset = .init(width: 0.0, height: 2.0)
//        layer.shadowOpacity = 0.5
//        layer.shadowRadius = 5.0
//        layer.fillColor = UIColor.orange.cgColor
//        layer.fillRule = CAShapeLayerFillRule.nonZero
//
//
//        return layer
//    }()
    lazy var bottomBackground: CAGradientLayer = {
        let layer = CAGradientLayer()
        
        layer.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor]

        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = .init(width: 0.0, height: -2.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5.0
        
        return layer
    }()
    lazy var topBackground: CAGradientLayer = {
        let layer = CAGradientLayer()
        
        layer.colors = [UIColor.yellow.cgColor, UIColor.orange.cgColor]
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = .init(width: 0.0, height: 2.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5.0
        
        return layer
    }()
        
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func setupToViewController(_ controller: BookSwapViewController, in context: UIViewControllerContextTransitioning) {
        
        controller.view.backgroundColor = UIColor.clear
        controller.myBookImageView.isHidden = true
        controller.bookImageView.isHidden = true
        controller.myBookPlaceholderView.isHidden = true
        controller.bookPlaceholderView.isHidden = true
        controller.topBackgroundView.isHidden = true
        controller.bottomBackgroundView.isHidden = true
        controller.dividerView.isHidden = true
        
    }
    
    func setupFromViewController(_ controller: BookListViewController, in context: UIViewControllerContextTransitioning) {
        
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: .to) as? BookSwapViewController,
            let fromViewController = transitionContext.viewController(forKey: .from) as? BookListViewController
        else {
            return
        }
        transitionContext.containerView.addSubview(toViewController.view)
        setupToViewController(toViewController, in: transitionContext)
        
        let myBookBackgroundSourceFrame = fromViewController.myBookContainerView.windowFrame()
        let myBookBackgroundTargetFrame = toViewController.topBackgroundView.windowFrame()
        
        let bookBackgroundSourceFrame = fromViewController.bookContainerView.windowFrame()
        let bookBackgroundTargetFrame = toViewController.bottomBackgroundView.windowFrame()
        
//        topBackground.anchorPoint = .init(x: 0.0, y: topBackgroundFrame.height)
        topBackground.anchorPoint = .zero
        topBackground.frame = myBookBackgroundSourceFrame
        
        topBackground.colors = [
            fromViewController.myBookContainerView.backgroundColor?.cgColor,
            fromViewController.myBookContainerView.backgroundColor?.cgColor
        ]
        
        bottomBackground.colors = [
            fromViewController.bookContainerView.backgroundColor?.cgColor,
            fromViewController.bookContainerView.backgroundColor?.cgColor
        ]
        
        toViewController.bottomBackgroundView.backgroundColor = fromViewController.bookContainerView.backgroundColor
        toViewController.dividerView.backgroundColor = fromViewController.bookContainerView.backgroundColor
        
//        bottomBackground.anchorPoint = .init(x: 0.0, y: bottomBackgroundFrame.height)
        bottomBackground.anchorPoint = .zero
        bottomBackground.frame = bookBackgroundTargetFrame
        
        
        transitionContext.containerView.layer.addSublayer(topBackground)
        transitionContext.containerView.layer.addSublayer(bottomBackground)
        
        let bookImageView = UIImageView(image: fromViewController.bookImageView.image)
        bookImageView.frame = fromViewController.bookImageView.windowFrame()
        bookImageView.backgroundColor = .yellow
        bookImageView.contentMode = .scaleToFill
        let myBookImageView = UIImageView(image: fromViewController.myBookImageView.image)
        myBookImageView.frame = fromViewController.myBookImageView.windowFrame()
        myBookImageView.contentMode = .scaleToFill
        myBookImageView.backgroundColor = .yellow
        
        transitionContext.containerView.addSubview(bookImageView)
        transitionContext.containerView.addSubview(myBookImageView)
        
        
        
        let duration = self.transitionDuration(using: transitionContext)
        
        
        UIView.animate(withDuration: duration - 0, animations: {
            bookImageView.frame = toViewController.bookImageView.windowFrame().translate(x: 0.0, y: -10.0)
            myBookImageView.frame = toViewController.myBookImageView.windowFrame()
        }) { _ in
            toViewController.startAnimation()
        }

        let bookSizeAnimation = CAKeyframeAnimation(keyPath: "bounds.size")
        bookSizeAnimation.values = [
            bookBackgroundSourceFrame.size,
            bookBackgroundTargetFrame.size,
            toViewController.dividerView.frame.union(bookBackgroundTargetFrame).size
        ]
//        transform.toValue = CATransform3DScale(CATransform3DIdentity, 1.0, 2.0, 1.0)
        bookSizeAnimation.duration = duration - 0.7
        bookSizeAnimation.isRemovedOnCompletion = false
        bookSizeAnimation.fillMode = .forwards
        
        let bookPositionAnimation = CAKeyframeAnimation(keyPath: "position")
        bookPositionAnimation.values = [
            bookBackgroundSourceFrame.origin,
            bookBackgroundTargetFrame.origin,
            toViewController.dividerView.windowOrigin()
        ]
//        transform.toValue = CATransform3DScale(CATransform3DIdentity, 1.0, 2.0, 1.0)
        bookPositionAnimation.duration = duration - 0.7
        bookPositionAnimation.isRemovedOnCompletion = false
        bookPositionAnimation.fillMode = .forwards
        

        let myBookSizeAnimation = CABasicAnimation(keyPath: "bounds.size")
        myBookSizeAnimation.fromValue = myBookBackgroundSourceFrame.size
        myBookSizeAnimation.toValue =  myBookBackgroundTargetFrame.size
//        transform.toValue = CATransform3DScale(CATransform3DIdentity, 1.0, 2.0, 1.0)
        myBookSizeAnimation.duration = duration - 0.7
        myBookSizeAnimation.isRemovedOnCompletion = false
        myBookSizeAnimation.fillMode = .forwards
        
        let myBookPositionAnimation = CABasicAnimation(keyPath: "position")
        myBookPositionAnimation.fromValue = myBookBackgroundSourceFrame.origin
        myBookPositionAnimation.toValue = myBookBackgroundTargetFrame.origin
//        transform.toValue = CATransform3DScale(CATransform3DIdentity, 1.0, 2.0, 1.0)
        myBookPositionAnimation.duration = duration - 0.7
        myBookPositionAnimation.isRemovedOnCompletion = false
        myBookPositionAnimation.fillMode = .forwards
        
        let myBookAnimationGroup = CAAnimationGroup()
        myBookAnimationGroup.animations = [myBookSizeAnimation, myBookPositionAnimation]
        myBookAnimationGroup.duration = duration - 0.7
        myBookAnimationGroup.isRemovedOnCompletion = false
        myBookAnimationGroup.fillMode = .forwards
        
        topBackground.addAnimation(myBookAnimationGroup, forKey: nil) { _, _ in
            
            toViewController.topBackgroundView.isHidden = false
            toViewController.bottomBackgroundView.isHidden = false
            toViewController.dividerView.isHidden = false
            toViewController.myBookImageView.isHidden = false
            toViewController.bookImageView.isHidden = false
            toViewController.myBookPlaceholderView.isHidden = false
            toViewController.bookPlaceholderView.isHidden = false
            
        }
//        topBackground.add(myBookSizeAnimation, forKey: nil)
//        topBackground.add(myBookPositionAnimation, forKey: nil)
        bottomBackground.add(bookSizeAnimation, forKey: nil)
        bottomBackground.add(bookPositionAnimation, forKey: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            transitionContext.completeTransition(true)

//            toViewController.topBackgroundView.isHidden = false
//            toViewController.bottomBackgroundView.isHidden = false
//            toViewController.dividerView.isHidden = false
//            toViewController.myBookImageView.isHidden = false
//            toViewController.bookImageView.isHidden = false
//            toViewController.myBookPlaceholderView.isHidden = false
//            toViewController.bookPlaceholderView.isHidden = false
            self.topBackground.removeFromSuperlayer()
            self.bottomBackground.removeFromSuperlayer()
        }
//
//        let yPositonAnimation = fromViewController.bookContainerView.windowOrigin().y
//
//        let targetSize = toViewController.topBackgroundView.frame.inset(by: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0))
//        let originSize = fromViewController.myBookContainerView.frame
//        let background = CAShapeLayer()
//        background.frame = originSize
//
//        let path = CGPath.init(rect: originSize.insetBy(dx: 0.0, dy: -60.0), transform: nil)
//        background.path = path
//
//        background.shadowColor = UIColor.darkGray.cgColor
//        background.shadowOffset = .init(width: 0.0, height: 2.0)
//        background.shadowOpacity = 0.5
//        background.shadowRadius = 5.0
//        background.fillColor = toViewController.topBackgroundView.backgroundColor?.cgColor
//        background.fillRule = CAShapeLayerFillRule.nonZero
//
//        let myBookImageLayer = CALayer()
//        myBookImageLayer.contents = fromViewController.myBookImageView.image?.cgImage
//        myBookImageLayer.frame = .init(origin: .zero, size: fromViewController.myBookImageView.frame.size)
////        myBookImageLayer.anchorPoint = .init(x: 100.0, y: 100.0)
//        myBookImageLayer.contentsCenter = .init(origin: .zero, size: .init(width: 50.0, height: 50.0))
//        myBookImageLayer.contentsGravity = .resizeAspect
//
//
//
//        bottomBackground.frame = .init(origin: fromViewController.bookContainerView.windowOrigin(), size: fromViewController.bookContainerView.frame.size)
////        toViewController.topBackgroundView.layer.insertSublayer(background, at: 0)
//        transitionContext.containerView.layer.addSublayer(background)
//        transitionContext.containerView.layer.addSublayer(bottomBackground)
//
//        toViewController.dividerView.alpha = 0.0
//        toViewController.topBackgroundView.backgroundColor = UIColor.clear
//        toViewController.bottomBackgroundView.backgroundColor = UIColor.clear
//
//
//        let duration = self.transitionDuration(using: transitionContext)
//
//        let backOpacity = CABasicAnimation(keyPath: "opacity")
//        backOpacity.fromValue = 0.9
//        backOpacity.toValue = 1.0
//        backOpacity.duration = duration - 0.9
//        backOpacity.isRemovedOnCompletion = false
//        backOpacity.fillMode = .forwards
//
//        let backAnimation = CABasicAnimation(keyPath: "path")
//        backAnimation.fromValue = CGPath.init(rect: originSize, transform: nil)
//        backAnimation.toValue = CGPath.init(rect: targetSize, transform: nil)
//        backAnimation.duration = duration - 0.1
//        backAnimation.beginTime = 0.1
//        backAnimation.isRemovedOnCompletion = false
//        backAnimation.fillMode = .forwards
//
//        let animationGroup = CAAnimationGroup()
//        animationGroup.animations = [backOpacity, backAnimation]
//        animationGroup.isRemovedOnCompletion = false
//        animationGroup.fillMode = .forwards
//        animationGroup.duration = duration
//        animationGroup.timingFunction = .init(name: .easeOut)
//
//        print("BOTTO ANIMTION",fromViewController.bookContainerView.windowOrigin().x, targetSize.height)
//        let bottomAnimation = CABasicAnimation(keyPath: "position.y")
//        bottomAnimation.fromValue = yPositonAnimation
//        bottomAnimation.toValue = 300.0
//        bottomAnimation.duration = duration
//        bottomAnimation.isRemovedOnCompletion = false
//        bottomAnimation.fillMode = .forwards
//        bottomAnimation.timingFunction = .init(name: .easeOut)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//            transitionContext.completeTransition(true)
//        }
//        UIView.animate(
//            withDuration: duration - 0.4,
//            delay: 0.0,
//            animations: {
//                toViewController.view.alpha = 1.0
//        }) { _ in
////            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }

        //        bottomBackground.add(bottomAnimation, forKey: nil)
        //        background.addAnimation(animationGroup, forKey: nil) { _, _ in
        //            transitionContext.completeTransition(true)
        //        }
        //        transitionContext.completeTransition(true)
    }
    
    
    
}

extension UIView {
    func windowOrigin() -> CGPoint {
        return self.superview?.convert(self.frame.origin, to: nil) ?? CGPoint.zero
    }
    func windowFrame() -> CGRect {
        return CGRect(origin: self.windowOrigin(), size: frame.size)
    }
}

extension CGPoint {
    func difference(point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x - self.x, y: point.y - self.y)
    }
}

extension CGRect {
    func translate(x: CGFloat, y: CGFloat) -> CGRect {
        return CGRect(
            origin: CGPoint(
                x: self.origin.x + x,
                y: self.origin.y + y
            ),
            size: self.size
        )
    }
}
