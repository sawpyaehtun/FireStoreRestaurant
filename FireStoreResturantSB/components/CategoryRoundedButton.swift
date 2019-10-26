//
//  CategoryRoundedButton.swift
//  FireStoreResturantSB
//
//  Created by saw pyaehtun on 24/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

@IBDesignable
class CategoryRoundedButton: UIButton {
    
    @IBInspectable var cornerRadius : CGFloat  = 2
    @IBInspectable var isCircle : Bool = true
    @IBInspectable var id : Int = 0
    @IBInspectable var isChecked : Bool = false {
        didSet{
            self.layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = isCircle ? self.frame.height / 2 : cornerRadius
        backgroundColor = isChecked ? UIColor.black : UIColor(named: "appBGColor")
        setTitleColor(isChecked ? UIColor.white : UIColor.black, for: .normal)
        super.layoutSubviews()
    }
}

