//
//  PushAnimator.swift
//  BookApp
//
//  Created by Agustin Cepeda on 02/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

open class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: .to) as? BookSwapViewController,
            let fromViewController = transitionContext.viewController(forKey: .from) as? BookListViewController
        else {
            return
        }
        transitionContext.containerView.addSubview(toViewController.view)
        
        let book1SourceWindowOrigin = fromViewController.book1ImageView.windowOrigin()
        let book1SourceFrame = fromViewController.book1ImageView.frame
        let book1TargetWindowOrigin = toViewController.myBookImageView.windowOrigin()
        let book1TargetFrame = toViewController.myBookImageView.frame
        
        let sourceBackground1WindowOrigin = fromViewController.myBookContainerView.windowOrigin()
        let sourceBackground1Frame = fromViewController.myBookContainerView.frame
        let targetBackground1WindowOrigin = toViewController.topBackgroundView.windowOrigin()
        let targetBackground1Frame = toViewController.topBackgroundView.frame
        
        let book2SourceWindowOrigin = fromViewController.bookImageView.windowOrigin()
        let book2SourceFrame = fromViewController.bookImageView.frame
        let book2TargetWindowOrigin = toViewController.bookImageView.windowOrigin()
        let book2TargetFrame = toViewController.bookImageView.frame
        
        print("TRANSITION SOURCE", book1SourceWindowOrigin, book1SourceFrame)
        print("TRANSITION TARGET", book1TargetWindowOrigin, book1TargetFrame)

        toViewController.bookImageView.frame = CGRect(origin: book2SourceWindowOrigin, size: book2SourceFrame.size)
        toViewController.myBookImageView.frame = CGRect(origin: book1SourceWindowOrigin, size: book1SourceFrame.size)
        toViewController.topBackgroundView.frame = CGRect(origin: sourceBackground1WindowOrigin, size: sourceBackground1Frame.size)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(
            withDuration: duration,
            animations: {
                toViewController.bookImageView.frame = CGRect(
                    origin: book2TargetWindowOrigin,
                    size: book2TargetFrame.size
                )
                toViewController.myBookImageView.frame = CGRect(
                    origin: book1TargetWindowOrigin,
                    size: book1TargetFrame.size
                )
                toViewController.topBackgroundView.frame = CGRect(origin: targetBackground1WindowOrigin, size: targetBackground1Frame.size)
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func configureBook1SourceSuperView(_ view: UIView) {
    }
}

extension UIView {
    func windowOrigin() -> CGPoint {
        return self.superview?.convert(self.frame.origin, to: nil) ?? CGPoint.zero
    }
}

extension CGPoint {
    func difference(point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x - self.x, y: point.y - self.y)
    }
}
