//
//  RoundImageButton.swift
//  FireStoreResturantSB
//
//  Created by saw pyaehtun on 23/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.4
            titleLabel?.layer.shadowOpacity = isEnabled ? 0.5 : 0
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat  = 2
    @IBInspectable var isCircle : Bool = true
    @IBInspectable var shadowOffsetWidth : Int = 0
    @IBInspectable var shadowOffsetHeight : Int = 0
    @IBInspectable var shadowColor : UIColor? = UIColor.black
    @IBInspectable var shadowOpacity : Float = 0.5
    @IBInspectable var borderWidth :  CGFloat = 0.0
    @IBInspectable var borderColor :  UIColor? = UIColor.black
    
    
    override func layoutSubviews() {
        layer.cornerRadius = isCircle ? self.frame.height / 2 : cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: isCircle ? self.frame.height / 2 : cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        super.layoutSubviews()
    }
}
