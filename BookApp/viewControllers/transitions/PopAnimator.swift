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
        transitionContext.containerView.addSubview(toViewController.view)
        transitionContext.containerView.addSubview(fromViewController.view)
        
        fromViewController.view.layer.shadowColor = UIColor.darkGray.cgColor
        fromViewController.view.layer.shadowRadius = 5.0
        fromViewController.view.layer.shadowOffset = .init(width: -5.0, height: 0.0)
        fromViewController.view.layer.shadowOpacity = 0.5

        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.transform = fromViewController.view.transform.translatedBy(x: transitionContext.containerView.frame.width, y: 0.0)
            
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}
