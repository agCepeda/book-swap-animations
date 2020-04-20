//
//  UIView+extensions.swift
//  BookApp
//
//  Created by Agustin Cepeda on 07/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

extension UIView {

    @IBInspectable public var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.clipsToBounds = false
            self.layer.masksToBounds = false
            self.layer.shadowOffset = newValue
        }
    }

    @IBInspectable public var shadowColor: UIColor {
        get {
            guard let color = self.layer.shadowColor else { return UIColor.clear }
            return UIColor(cgColor: color)
        }
        set {
            self.clipsToBounds = false
            self.layer.masksToBounds = false
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.clipsToBounds = false
            self.layer.masksToBounds = false
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable public var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.clipsToBounds = false
            self.layer.masksToBounds = false
            self.layer.shadowOpacity = newValue
        }
    }

    @IBInspectable public var fillColor: UIColor? {
        get {
            guard let cgColor = layer.backgroundColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.backgroundColor = newValue?.cgColor
        }
    }

    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable public var borderColor: UIColor {
        get {
            guard let color = self.layer.borderColor else { return UIColor.clear }
            return UIColor(cgColor: color)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }

    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    func loadNib() -> UIView {
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    var positionOnScreen: CGPoint {
        return self.superview?.convert(self.frame.origin, to: nil) ?? CGPoint.zero
    }
    
    var frameOnScreen: CGRect {
        return CGRect(origin: self.positionOnScreen, size: frame.size)
    }
}
