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
    @IBOutlet weak var bookQuoteView: QuouteView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookPlaceholderView: UIView!
    
    @IBOutlet weak var dividerView: AnimatedDividerView!
    
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var bottomBackgroundView: UIView!
    
    @IBOutlet weak var swapContainerView: SwapButtonView!
    
    lazy var bookPlaceholderLayer: CALayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.init(hexString: "#AF52DE", alpha: 0.75).cgColor,
            UIColor.init(hexString: "#833DC2", alpha: 0.75).cgColor,
        ]
        return layer
    }()
    
    lazy var myBookPlaceholderLayer: CALayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.init(hexString: "#AF52DE", alpha: 0.75).cgColor,
            UIColor.init(hexString: "#833DC2", alpha: 0.75).cgColor,
        ]
        return layer
    }()

    
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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(restartAnimation))
        swapContainerView.isUserInteractionEnabled = true
        swapContainerView.addGestureRecognizer(recognizer)
        
        myBookPlaceholderView.layer.addSublayer(myBookPlaceholderLayer)
        bookPlaceholderView.layer.addSublayer(bookPlaceholderLayer)
        setupInitialAnimationState()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bookPlaceholderLayer.frame = .init(origin: .zero, size: bookPlaceholderView.frame.size)
        myBookPlaceholderLayer.frame = .init(origin: .zero, size: myBookPlaceholderView.frame.size)
    }
    
    @objc func restartAnimation() {
        setupInitialAnimationState()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.startAnimation()
        }
    }
    
    func setBooks(book1: Book, book2: Book) {
        self.book1 = book1
        self.book2 = book2
    }

    func setupInitialAnimationState() {
        bookNameLabel.layer.removeAllAnimations()
        bookAuthorLabel.layer.removeAllAnimations()
        myBookNameLabel.layer.removeAllAnimations()
        myBookAuthorLabel.layer.removeAllAnimations()
        bookNameLabel.layer.opacity = 0.0
        bookAuthorLabel.layer.opacity = 0.0
        myBookNameLabel.layer.opacity = 0.0
        myBookAuthorLabel.layer.opacity = 0.0
        bookQuoteView.setupInitialAnimationState()
        myBookQuoteView.setupInitialAnimationState()
        swapContainerView.setupInitialAnimationState()
        dividerView.setupInitialAnimationState()
        setupPlaceholdersInitialAnimationState()
    }
    
    func setupPlaceholdersInitialAnimationState() {
        myBookPlaceholderLayer.removeAllAnimations()
        bookPlaceholderLayer.removeAllAnimations()
        bookPlaceholderLayer.transform = CATransform3DScale(CATransform3DIdentity, 0.7, 0.7, 0.0)
        myBookPlaceholderLayer.transform = CATransform3DScale(CATransform3DIdentity, 0.7, 0.7, 0.0)
        bookQuoteView.clearAnimations()
        myBookQuoteView.clearAnimations()
    }
    
    func startAnimation() {
        let currentTime = CACurrentMediaTime()

        let bookNameOpacity = CABasicAnimation(keyPath: "opacity")
        bookNameOpacity.fromValue = 0.0
        bookNameOpacity.toValue = 1.0
        bookNameOpacity.duration = 0.5
        bookNameOpacity.isRemovedOnCompletion = false
        bookNameOpacity.fillMode = .forwards
        
        let bookNamePositionY = CABasicAnimation(keyPath: "transform")
        bookNamePositionY.fromValue = CATransform3DTranslate(CATransform3DIdentity, 0.0, 90.0, 0.0)
        bookNamePositionY.toValue = CATransform3DIdentity
        bookNamePositionY.duration = 0.5
        bookNamePositionY.isRemovedOnCompletion = false
        bookNamePositionY.fillMode = .forwards
        
        let bookNameAnimationGroup = CAAnimationGroup()
        bookNameAnimationGroup.animations = [bookNameOpacity, bookNamePositionY]
        bookNameAnimationGroup.duration = 0.5
        bookNameAnimationGroup.isRemovedOnCompletion = false
        bookNameAnimationGroup.fillMode = .forwards
        
        let bookAuthorOpacity = CABasicAnimation(keyPath: "opacity")
        bookAuthorOpacity.fromValue = 0.0
        bookAuthorOpacity.toValue = 1.0
        bookAuthorOpacity.duration = 0.5
        bookAuthorOpacity.isRemovedOnCompletion = false
        bookAuthorOpacity.fillMode = .forwards
        
        let bookAuthorPositionY = CABasicAnimation(keyPath: "transform")
        bookAuthorPositionY.fromValue = CATransform3DTranslate(CATransform3DIdentity, 0.0, 100.0, 0.0)
        bookAuthorPositionY.toValue = CATransform3DIdentity
        bookAuthorPositionY.duration = 1.0
        bookAuthorPositionY.isRemovedOnCompletion = false
        bookAuthorPositionY.fillMode = .forwards
        
        let bookAuthorAnimationGroup = CAAnimationGroup()
        bookAuthorAnimationGroup.animations = [bookAuthorOpacity, bookAuthorPositionY]
        bookAuthorAnimationGroup.duration = 1.0
        bookAuthorAnimationGroup.isRemovedOnCompletion = false
        bookAuthorAnimationGroup.fillMode = .forwards
        
        let bookPlaceholderOpacity = CABasicAnimation(keyPath: "opacity")
        bookPlaceholderOpacity.fromValue = 0.0
        bookPlaceholderOpacity.toValue = 1.0
        bookPlaceholderOpacity.duration = 1.0
        bookPlaceholderOpacity.isRemovedOnCompletion = false
        bookPlaceholderOpacity.fillMode = .forwards
        
        let bookPlaceholderTransform = CABasicAnimation(keyPath: "transform")
        bookPlaceholderTransform.fromValue = CATransform3DScale(CATransform3DIdentity, 0.7, 0.7, 0.0)
        bookPlaceholderTransform.toValue = CATransform3DIdentity
        bookPlaceholderTransform.duration = 1.0
        bookPlaceholderTransform.isRemovedOnCompletion = false
        bookPlaceholderTransform.fillMode = .forwards
        
        let bookPlaceholderAnimationGroup = CAAnimationGroup()
        bookPlaceholderAnimationGroup.animations = [bookPlaceholderTransform]
        bookPlaceholderAnimationGroup.duration = 1.0
        bookPlaceholderAnimationGroup.isRemovedOnCompletion = false
        bookPlaceholderAnimationGroup.fillMode = .forwards
        
        myBookNameLabel.layer.add(bookNameAnimationGroup, forKey: nil)
        myBookAuthorLabel.layer.add(bookAuthorAnimationGroup, forKey: nil)
        bookNameLabel.layer.add(bookNameAnimationGroup, forKey: nil)
        bookAuthorLabel.layer.add(bookAuthorAnimationGroup, forKey: nil)
        
        bookPlaceholderLayer.add(bookPlaceholderAnimationGroup, forKey: nil)
        myBookPlaceholderLayer.add(bookPlaceholderAnimationGroup, forKey: nil)
        
        myBookQuoteView.startAnimation(beginTime: currentTime + 1.0)
        bookQuoteView.startAnimation(beginTime: currentTime + 1.0)
        dividerView.startAnimation(beginTime: currentTime)
        swapContainerView.startAnimation(beginTime: currentTime + 1.5)
    }
}
