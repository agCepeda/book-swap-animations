//
//  PushV2Animator.swift
//  BookApp
//
//  Created by Agustin Cepeda on 19/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

open class PushV2Animator: NSObject, UIViewControllerAnimatedTransitioning {
    struct Constants {
        static let animationTime = 0.5
    }
    
    private let background = CloseableView()
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.animationTime
    }
    
    private func animateImages(listController: BookListViewController, swapController: BookSwapViewController, using context: UIViewControllerContextTransitioning) {
        
        let bookImageView = UIImageView(image: listController.bookImageView.image)
        let myBookImageView = UIImageView(image: listController.myBookImageView.image)
        
        ////////////////////////////////////////////
        let myBookPoint = listController.myBookImageView.convert(CGPoint.zero, to: listController.view.superview)
        let bookPoint = listController.bookImageView.convert(CGPoint.zero, to: listController.view.superview)
        
        myBookImageView.frame = .init(
            origin: myBookPoint,
            size: listController.myBookImageView.frame.size)
        
        bookImageView.frame = .init(
            origin: bookPoint,
            size: listController.bookImageView.frame.size
        )
        ////////////////////////////////////////////
        context.containerView.addSubview(bookImageView)
        context.containerView.addSubview(myBookImageView)
        
        let safeAreaFrame = listController.view.safeAreaLayoutGuide.layoutFrame
        let safeArea = listController.view.window?.safeAreaInsets ?? UIEdgeInsets()
//        safeArea.top + 44
        let overflow: CGFloat = 70.0
        UIView.animate(withDuration: self.transitionDuration(using: context), animations: {
            bookImageView.frame = CGRect(
                origin: CGPoint(
                    x: safeAreaFrame.width - swapController.bookImageView.frame.width - 27.0,
                    y: safeArea.top + 44 + (safeAreaFrame.height / 2.0) + overflow + 35.0
                ),
                size: swapController.bookImageView.frame.size
            )
            myBookImageView.frame = swapController.myBookImageView.frameOnScreen
        })
    }
    
    
    private func animateSheets(listController: BookListViewController, swapController: BookSwapViewController, using context: UIViewControllerContextTransitioning) {
        
        let safeArea = listController.view.window?.safeAreaInsets ?? UIEdgeInsets()
        let safeAreaFrame = listController.view.safeAreaLayoutGuide.layoutFrame
        ////////////////////////////////////////////
        let myBookContainerPoint = listController.myBookContainerView.convert(CGPoint.zero, to: listController.view)
        let bookContainerPoint = listController.bookContainerView.convert(CGPoint.zero, to: listController.view)
        
        let myBookContainerFrame = CGRect(
            origin: myBookContainerPoint,
            size: listController.myBookContainerView.frame.size
        )
        let bookContainerFrame = CGRect(
            origin: bookContainerPoint,
            size: listController.bookContainerView.frame.size
        )
        
        background.frame = .init(
            origin: .init(x: 0.0, y: safeArea.top + 44),
            size: safeAreaFrame.size
        )
        background.setupOpenState(
            upper: myBookContainerFrame,
            lower: bookContainerFrame
        )
        background.upperColor = listController.myBookContainerView.backgroundColor ?? UIColor.white
        background.lowerColor = listController.bookContainerView.backgroundColor ?? UIColor.white
        
        context.containerView.addSubview(background)

        background.closeAnimation {
//            background.finishAnimation()
        }

    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: .to) as? BookSwapViewController,
            let fromViewController = transitionContext.viewController(forKey: .from) as? BookListViewController
            else { return }
        
        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0.0
        
        animateSheets(listController: fromViewController, swapController: toViewController, using: transitionContext)
        animateImages(listController: fromViewController, swapController: toViewController, using: transitionContext)
                
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationTime) {
            toViewController.view.alpha = 1.0
//            background.alpha = 0.45
//            background.removeFromSuperview()
            self.background.removeFromSuperview()
            toViewController.startAnimation()
            transitionContext.completeTransition(true)
        }
    }
    
    
}
