//
//  FoodVO.swift
//  FireStoreResturantSB
//
//  Created by saw pyaehtun on 23/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

enum foodCategory : Int{
    case entrees = 1
    case main = 2
    case drinks = 3
    case desserts = 4
}

struct FoodVO {
    let id : String?
    let amount : Double?
    let foodName : String?
    let rating : Double?
    let waitingTime : Int?
    let imgUrl : String?
    let category : Int?
}

extension FoodVO {
    init?(dictionary : [String : Any], id : String) {
        guard let amount = dictionary["amount"] as? Double,
            let foodName = dictionary["foodName"] as? String,
        let rating = dictionary["rating"] as? Double,
        let waitingTime = dictionary["waitingTime"] as? Int,
        let imgUrl = dictionary["imgUrl"] as? String,
        let category = dictionary["category"] as? Int else {return nil}
        self.id = id
        self.amount = amount
        self.foodName = foodName
        self.rating = rating
        self.waitingTime = waitingTime
        self.imgUrl = imgUrl
        self.category = category
    }
}

extension FoodVO {
    func toDictionary() -> [String : Any]{
        return [
            "amount" : self.amount as Any,
            "foodName" : self.foodName as Any,
            "rating" : self.rating as Any,
            "waitingTime" : self.waitingTime as Any,
            "imgUrl" : self.imgUrl as Any,
            "category" : self.category as Any
        ]
    }
}

