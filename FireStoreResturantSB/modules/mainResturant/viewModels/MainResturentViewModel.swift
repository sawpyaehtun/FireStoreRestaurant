//
//  MainResturentViewModel.swift
//  FireStoreResturantSB
//
//  Created by saw pyaehtun on 23/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class MainResturentViewModel : BaseViewModel{
    
    // input
    let categoryIDObserable = BehaviorRelay<Int>(value: 1)
    
    // output
    let foodItemListObserable = BehaviorRelay<[FoodVO]>(value: [])
    var foodList : [FoodVO] = []{
        didSet {
            prepareForDisplayViaCategory()
        }
    }
    
    override init() {
        super.init()
        categoryIDObserable.subscribe(onNext: { (id) in
            self.prepareForDisplayViaCategory()
        }).disposed(by: disposableBag)
        
    }
}

extension MainResturentViewModel {
    func getFoodList() {
        loadingObservable.accept(true)
        FoodModel.shared.getFoodItems().subscribe(onNext: { (foodlist) in
            self.loadingObservable.accept(false)
            self.foodList = foodlist
        }, onError: { (error) in
            self.errorObservable.accept(error.localizedDescription)
            }).disposed(by: disposableBag)
    }
    
    private func prepareForDisplayViaCategory(){
        let categorizedFoodItem = self.foodList.filter { (food) -> Bool in
            return food.category == self.categoryIDObserable.value
        }
        self.foodItemListObserable.accept(categorizedFoodItem)
    }
}
