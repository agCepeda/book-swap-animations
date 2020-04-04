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
        return 0.75
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: .to) as? BookSwapViewController,
            let fromViewController = transitionContext.viewController(forKey: .from) as? BookListViewController
        else {
            return
        }
        let book1SourceSuperView = fromViewController.bookImageView.superview
        let book1SourceWindowOrigin = fromViewController.bookImageView.windowOrigin();
        
        print("TRANSITION ")
        
        transitionContext.containerView.addSubview(toViewController.view)
        transitionContext.containerView.addSubview(fromViewController.bookImageView)
        fromViewController.bookImageView.frame = CGRect(
            origin: book1SourceWindowOrigin,
            size: fromViewController.bookImageView.frame.size
        )
        toViewController.view.alpha = 0
        toViewController.bottomBookImageView.alpha = 0
        toViewController.topBookImageView.alpha = 0
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.alpha = 1
            fromViewController.bookImageView.frame = toViewController.bottomPlaceholderView.frame
        }) { /*[weak self] */_ in
//            guard let self = self else { return }
            toViewController.bottomBookImageView.alpha = 1
            toViewController.topBookImageView.alpha = 1
            
            if let superView = book1SourceSuperView {
                superView.addSubview(fromViewController.bookImageView)
                
                NSLayoutConstraint.activate([
                    fromViewController.bookImageView.topAnchor.constraint(equalTo: superView.topAnchor),
                    fromViewController.bookImageView.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
                    fromViewController.bookImageView.widthAnchor.constraint(equalTo: superView.widthAnchor),
                    fromViewController.bookImageView.heightAnchor.constraint(equalTo: superView.heightAnchor)
                ])
            }
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
