//
//  PopAnimator.swift
//  BookApp
//
//  Created by Agustin Cepeda on 02/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

open class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: .to) as? BookListViewController,
            let fromViewController = transitionContext.viewController(forKey: .from)
        else {
            return
        }
        print("ANIMATION", toViewController, fromViewController)
        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0

        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.alpha = 1
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
