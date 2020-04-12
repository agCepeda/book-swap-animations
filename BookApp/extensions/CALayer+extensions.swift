//
//  CALayer+extensions.swift
//  BookApp
//
//  Created by Agustin Cepeda on 10/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

typealias LayerAnimationBeginClosure = (CAAnimation) -> Void
typealias LayerAnimationCompletionClosure = (CAAnimation, Bool) -> Void

extension CALayer {
    func addAnimation(_ animation: CAAnimation, forKey key: String?, completionClosure: LayerAnimationCompletionClosure?) {
        addAnimation(animation, forKey: key, beginClosure: nil, completionClosure: completionClosure)
    }
    func addAnimation(_ animation: CAAnimation, forKey key: String?, beginClosure: LayerAnimationBeginClosure?, completionClosure: LayerAnimationCompletionClosure?) {
        let animationDelegate = LayerAnimationDelegate()
        animationDelegate.beginClosure = beginClosure
        animationDelegate.completionClosure = completionClosure

        animation.delegate = animationDelegate

        add(animation, forKey: key)
    }
}

fileprivate class LayerAnimationDelegate: NSObject {
    var beginClosure: LayerAnimationBeginClosure?
    var completionClosure: LayerAnimationCompletionClosure?
}

extension LayerAnimationDelegate: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        guard let beginClosure = beginClosure else { return }
        beginClosure(anim)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let completionClosure = completionClosure else { return }
        completionClosure(anim, flag)
    }
}
