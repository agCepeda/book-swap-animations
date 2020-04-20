//
//  SwapNavigationController.swift
//  BookApp
//
//  Created by Agustin Cepeda on 02/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

class SwapNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension SwapNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return PopAnimator()
        case .push:
            return PushAnimator()
        default:
            return nil
        }
    }
}
