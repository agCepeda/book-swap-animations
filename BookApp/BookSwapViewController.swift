//
//  BookSwapViewController.swift
//  BookApp
//
//  Created by Agustin Cepeda on 02/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

class BookSwapViewController: UIViewController {
    @IBOutlet weak var myBookNameLabel: UILabel!
    @IBOutlet weak var myBookAuthorLabel: UILabel!
    @IBOutlet weak var myBookQuoteView: QuouteView!
    @IBOutlet weak var myBookImageView: UIImageView!
    @IBOutlet weak var myBookPlaceholderView: UIView!
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookQuoteContainer: UIView!
    @IBOutlet weak var bookQuoteView: QuouteView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookPlaceholderView: UIView!
    
    @IBOutlet weak var dividerView: AnimatedDividerView!
    
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var bottomBackgroundView: UIView!
    
    @IBOutlet weak var swapContainerView: UIView!
    @IBOutlet weak var swapLabel: UILabel!
    @IBOutlet weak var swapImageView: UIImageView!
    //    @IBOutlet weak var myBookQuoteWidthConstraint: NSLayoutConstraint!
    
    var book1: Book! = Book(
        name: "The Outside Boy",
        image: "book2",
        author: "Jeanine Cummins",
        color: UIColor(red:0.75, green:0.49, blue:1.00, alpha:1.00)
    )
    var book2: Book! = Book(
        name: "Thinner",
        image: "book1",
        author: "Stephen King",
        color: UIColor(red:0.27, green:0.96, blue:0.80, alpha:1.00)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myBookImageView.image = UIImage(named: book1.image)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(restartAnimation))
        swapContainerView.isUserInteractionEnabled = true
        swapContainerView.addGestureRecognizer(recognizer)
 
        setupInitialAnimationState()
        startAnimation()
    }

    @objc func restartAnimation() {
        setupInitialAnimationState()
        startAnimation()
        
        dividerView.startAnimation()
        myBookQuoteView.open()
    }
    
    func setBooks(book1: Book, book2: Book) {
        self.book1 = book1
        self.book2 = book2
    }

    func setupInitialAnimationState() {
        myBookNameLabel.alpha = 0
        myBookAuthorLabel.alpha = 0
        myBookQuoteView.alpha = 0
        
        bookNameLabel.alpha = 0
        bookAuthorLabel.alpha = 0
        bookQuoteContainer.alpha = 0
        
//        swapContainerView.alpha = 0
//        swapImageView.alpha = 0
//        swapLabel.alpha = 0
        
        myBookNameLabel.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 20.0)
        myBookAuthorLabel.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 50.0)
        myBookPlaceholderView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
        
        bookNameLabel.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 20.0)
        bookAuthorLabel.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 30.0)
        bookPlaceholderView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
        
//        swapContainerView.transform = CGAffineTransform.identity.scaledBy(x: 0.0, y: 1.0)
//        swapImageView.transform = CGAffineTransform.identity
    }
    
    func startAnimation() {
        UIView.animateKeyframes(
            withDuration: 0.5,
            delay: 0.0,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.6) {
                    self.myBookNameLabel.transform = CGAffineTransform.identity
                    self.myBookAuthorLabel.transform = CGAffineTransform.identity
                    self.myBookNameLabel.alpha = 1
                    self.myBookAuthorLabel.alpha = 1
                    self.myBookQuoteView.alpha = 1
                    
                    self.bookNameLabel.transform = CGAffineTransform.identity
                    self.bookAuthorLabel.transform = CGAffineTransform.identity
                    self.bookNameLabel.alpha = 1
                    self.bookAuthorLabel.alpha = 1
                    self.bookQuoteContainer.alpha = 1
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.6) {
                    self.myBookPlaceholderView.transform = CGAffineTransform.identity
                    self.bookPlaceholderView.transform = CGAffineTransform.identity

//                    self.swapContainerView.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 1.0)
//                    self.swapContainerView.alpha = 1
                }

        }) { _ in
        }
        /*

                         
                         UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
         //                    self.myBookQuoteView.openState(rect: self.myBookQuoteView.frame)
                             

                             self.myBookQuoteView.background.bounds = self.myBookQuoteView.frame
                             self.myBookQuoteView.indicator.frame = CGRect(
                                 origin: .init(
                                     x: self.myBookQuoteView.frame.width - QuouteView.Constants.indicatorSize.width - QuouteView.Constants.indicatorMarginRight,
                                     y: QuouteView.Constants.indicatorMarginTop
                                 ),
                                 size: QuouteView.Constants.indicatorSize
                             )
                             self.myBookQuoteView.messageLabel.layer.opacity = 1.0
                             
                             self.swapContainerView.transform = CGAffineTransform.identity
                             self.swapImageView.alpha = 1
                             self.swapLabel.alpha = 1
                         }
                         
                         UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                             self.swapImageView.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi)
                         }
                         
                         UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                             self.swapImageView.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi)
                         }
         */
    }


}
