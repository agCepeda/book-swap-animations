//
//  ViewController.swift
//  BookApp
//
//  Created by Agustin Cepeda on 01/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var closeableView: CloseableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startCloseAnimation(_ sender: Any) {
        closeableView.closeAnimation()
    }
    
    @IBAction func startFinishAnimation(_ sender: Any) {
        closeableView.finishAnimation(beginTime: CACurrentMediaTime())
    }
    
    @IBAction func resetAnimationState(_ sender: Any) {
        closeableView.setupOpenState(
            upper: .init(
                origin: .init(x: 0.0, y: 45.0),
                size: .init(width: closeableView.frame.width, height: 50.0)
            ),
            lower: .init(
                origin: .init(x: 0.0, y: 400.0),
                size: .init(width: closeableView.frame.width, height: 180.0)
            )
        )
    }
}

