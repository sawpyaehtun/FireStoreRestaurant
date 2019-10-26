//
//  RoundedLabel.swift
//  FireStoreResturantSB
//
//  Created by saw pyaehtun on 24/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

class RoundedLabel: UILabel {
    
    @IBInspectable var cornerRadius : CGFloat = 2
    @IBInspectable var shadowOffsetWidth : Int = 0
    @IBInspectable var shadowOffsetHeight : Int = 0
    @IBInspectable var shadowColour : UIColor? = UIColor.black
    @IBInspectable var shadowOpacity : Float = 0.5
    @IBInspectable var borderWidth :  CGFloat = 0.0
    @IBInspectable var borderColor :  UIColor? = UIColor.black
    @IBInspectable var id : Int = 0
    @IBInspectable var isCircle : Bool = true
    
    override func layoutSubviews() {
        layer.cornerRadius = isCircle ? self.frame.height / 2 : cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: isCircle ? self.frame.height / 2 : cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColour?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        super.layoutSubviews()
    }
    
}
