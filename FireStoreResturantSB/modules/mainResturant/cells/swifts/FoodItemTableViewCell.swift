//
//  FoodItemTableViewCell.swift
//  FireStoreResturantSB
//
//  Created by saw pyaehtun on 24/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage

class FoodItemTableViewCell: BaseTableViewCell {
    @IBOutlet weak var viewImageBackground: CardView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var lblWaitingTime: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var imgFood: UIImageView!
    
    let number = Int.random(in: 1 ..< 4)
    var foodItem : FoodVO? {
        didSet {
            if let fooditem = foodItem {
                lblFoodName.text = fooditem.foodName
                viewRating.rating = fooditem.rating!
                lblWaitingTime.text = "Prep in \(fooditem.waitingTime ?? 0) mins."
                lblAmount.text = "$ \(fooditem.amount ?? 0)"
                imgFood.sd_setImage(with: URL(string: fooditem.imgUrl!))
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setupUIs() {
        super.setupUIs()
        switch number {
        case 1 :
            viewImageBackground.backgroundColor = UIColor(named: "cOne")
        case 2 :
             viewImageBackground.backgroundColor = UIColor(named: "cTwo")
        case 3 :
             viewImageBackground.backgroundColor = UIColor(named: "cThree")
        default:
             viewImageBackground.backgroundColor = UIColor(named: "cOne")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
