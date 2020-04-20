//
//  PushAnimator.swift
//  BookApp
//
//  Created by Agustin Cepeda on 02/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

open class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
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

    weak var listController: BookListViewController!
    weak var swapController: BookSwapViewController!
        
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
        listController = fromViewController
        swapController = toViewController
        
        transitionContext.containerView.addSubview(toViewController.view)
        setupToViewController(toViewController, in: transitionContext)
        toViewController.view.alpha = 0.0
        
        let overflow: CGFloat = 70.0
        let insets = UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets()
        let screenBounds = UIScreen.main.bounds
        let height = screenBounds.height - insets.top - insets.bottom
        
        toViewController.bookColorSchema = fromViewController.bookColorSchema
        
        let myBookBackgroundSourceFrame = fromViewController.myBookContainerView.frameOnScreen
        let myBookBackgroundTargetFrame = CGRect(
            origin: .init(x: 0.0, y: insets.top),
            size: .init(
                width: screenBounds.width,
                height: (height / 2.0) - overflow
            )
        )//toViewController.topBackgroundView.windowFrame()
        
        let bookBackgroundSourceFrame = fromViewController.bookContainerView.frameOnScreen
        let bookBackgroundTargetFrame = CGRect(
            origin: CGPoint(
                x: 0,
                y: insets.top + (height / 2.0)  - overflow
            ),
            size: CGSize(
                width: screenBounds.width,
                height: height / 2.0  + overflow
            )
        )
        
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
        
        bottomBackground.anchorPoint = .zero
        bottomBackground.frame = bookBackgroundSourceFrame
        
        transitionContext.containerView.layer.addSublayer(bottomBackground)
        transitionContext.containerView.layer.addSublayer(topBackground)
        
        
        
        let duration = self.transitionDuration(using: transitionContext)
        
        animateImageViews(withDuration: duration, using: transitionContext)
        

        let bookSizeAnimation = CAKeyframeAnimation(keyPath: "bounds.size")
        bookSizeAnimation.values = [
            bookBackgroundSourceFrame.size,
            toViewController.dividerView.frame.union(bookBackgroundTargetFrame).size
        ]
        bookSizeAnimation.duration = duration - 0.7
        bookSizeAnimation.isRemovedOnCompletion = false
        bookSizeAnimation.fillMode = .forwards
        
        let bookPositionAnimation = CAKeyframeAnimation(keyPath: "position")
        bookPositionAnimation.values = [
            bookBackgroundSourceFrame.origin,
            toViewController.dividerView.positionOnScreen
        ]
        bookPositionAnimation.duration = duration - 0.7
        bookPositionAnimation.isRemovedOnCompletion = false
        bookPositionAnimation.fillMode = .forwards
        

        let myBookSizeAnimation = CABasicAnimation(keyPath: "bounds.size")
        myBookSizeAnimation.fromValue = myBookBackgroundSourceFrame.size
        myBookSizeAnimation.toValue =  myBookBackgroundTargetFrame.size
        myBookSizeAnimation.duration = duration - 0.7
        myBookSizeAnimation.isRemovedOnCompletion = false
        myBookSizeAnimation.fillMode = .forwards
        
        let myBookPositionAnimation = CABasicAnimation(keyPath: "position")
        myBookPositionAnimation.fromValue = myBookBackgroundSourceFrame.origin
        myBookPositionAnimation.toValue = myBookBackgroundTargetFrame.origin
        myBookPositionAnimation.duration = duration - 0.7
        myBookPositionAnimation.isRemovedOnCompletion = false
        myBookPositionAnimation.fillMode = .forwards
        
        let myBookOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        myBookOpacityAnimation.fromValue = 0.6
        myBookOpacityAnimation.toValue = 1
        myBookOpacityAnimation.duration = duration - 0.9
        myBookOpacityAnimation.isRemovedOnCompletion = false
        myBookOpacityAnimation.fillMode = .forwards
        
        
        let myBookAnimationGroup = CAAnimationGroup()
        myBookAnimationGroup.animations = [myBookSizeAnimation,myBookPositionAnimation, myBookOpacityAnimation]
        myBookAnimationGroup.duration = duration - 0.7
        myBookAnimationGroup.isRemovedOnCompletion = false
        myBookAnimationGroup.fillMode = .forwards
        
        topBackground.addAnimation(myBookAnimationGroup, forKey: nil) { _, _ in

            toViewController.view.alpha = 1.0
            toViewController.topBackgroundView.isHidden = false
            toViewController.bottomBackgroundView.isHidden = false
            toViewController.dividerView.isHidden = false
            toViewController.myBookImageView.isHidden = false
            toViewController.bookImageView.isHidden = false
            toViewController.myBookPlaceholderView.isHidden = false
            toViewController.bookPlaceholderView.isHidden = false

        }
        bottomBackground.add(bookSizeAnimation, forKey: nil)
        bottomBackground.add(bookPositionAnimation, forKey: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.topBackground.removeFromSuperlayer()
            self.bottomBackground.removeFromSuperlayer()
            transitionContext.completeTransition(true)
        }
    }

    func animateImageViews(withDuration duration: TimeInterval, using context: UIViewControllerContextTransitioning) {
        let overflow: CGFloat = 70.0
        let insets = UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets()
        let screenBounds = UIScreen.main.bounds
        let height = screenBounds.height - insets.top - insets.bottom
        
        let bookImageView = UIImageView(image: listController.bookImageView.image)
        bookImageView.frame = listController.bookImageView.frameOnScreen
        bookImageView.backgroundColor = .yellow
        bookImageView.contentMode = .scaleToFill
        let myBookImageView = UIImageView(image: listController.myBookImageView.image)
        myBookImageView.frame = listController.myBookImageView.frameOnScreen
        myBookImageView.contentMode = .scaleToFill
        myBookImageView.backgroundColor = .yellow
        
        context.containerView.addSubview(bookImageView)
        context.containerView.addSubview(myBookImageView)
        UIView.animate(withDuration: duration, animations: {
            bookImageView.frame = CGRect(
                origin: CGPoint(
                    x: context.containerView.frame.width - self.swapController.bookImageView.frame.width - 27.0,
                    y: (height / 2.0) + insets.top + overflow + 35
                ),
                size: self.swapController.bookImageView.frame.size
            ).translate(x: 0.0, y: 20.0)
            myBookImageView.frame = self.swapController.myBookImageView.frameOnScreen
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.swapController.startAnimation()
                bookImageView.removeFromSuperview()
                myBookImageView.removeFromSuperview()
            }
        }
    }
}

extension UIView {
}

