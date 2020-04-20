//
//  BookSwapViewController.swift
//  BookApp
//
//  Created by Agustin Cepeda on 02/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

class BookSwapViewController: UIViewController {
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var bottomBackgroundView: UIView!
    
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
    @IBOutlet weak var swapContainerView: SwapButtonView!
    
    lazy var bookPlaceholderLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        return layer
    }()
    
    lazy var myBookPlaceholderLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            
            UIColor(red: 0.737, green: 0.201, blue: 0.161, alpha: 1.0).lighter(by: 30)?.cgColor,
            UIColor(red: 0.737, green: 0.201, blue: 0.161, alpha: 1.0).lighter(by: 30)?.cgColor,
        ]
        return layer
    }()
    
    var bookColorSchema: ColorSchema = ColorSchema() {
        didSet {
            bookNameLabel.textColor = self.bookColorSchema.text
            bookAuthorLabel.textColor = self.bookColorSchema.text
            self.bookPlaceholderLayer.colors = [
                self.bookColorSchema.card.cgColor,
                self.bookColorSchema.card.darker(by: 10)?.cgColor,
            ]
            self.view.backgroundColor = self.bookColorSchema.background
        }
    }
    
    var myBookModel: Book = Book()
    
    var bookModel: Book = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myBookImageView.image = UIImage(named: myBookModel.image)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(restartAnimation))
        swapContainerView.isUserInteractionEnabled = true
        swapContainerView.addGestureRecognizer(recognizer)
        
        myBookPlaceholderView.layer.addSublayer(myBookPlaceholderLayer)
        bookPlaceholderView.layer.addSublayer(bookPlaceholderLayer)
        

        self.myBookNameLabel.text = self.myBookModel.name
        self.myBookAuthorLabel.text = self.myBookModel.author
        self.myBookQuoteView.text = self.myBookModel.abstract
        self.myBookImageView.image = UIImage(named: self.myBookModel.image)
        self.bookNameLabel.text = self.bookModel.name
        self.bookAuthorLabel.text = self.bookModel.author
        self.bookQuoteView.text = self.bookModel.abstract
        self.bookImageView.image = UIImage(named: self.bookModel.image)
        
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
    
    func setBooks(myBook: Book, book: Book) {
        self.myBookModel = myBook
        self.bookModel = book
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
