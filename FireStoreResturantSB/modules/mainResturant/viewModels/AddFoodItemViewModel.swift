//
//  AddFoodItemViewModel.swift
//  FireStoreResturantSB
//
//  Created by saw pyaehtun on 23/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class AddFoodItemViewModel : BaseViewModel {
    let uploadedImageName = BehaviorRelay<String?>(value: nil)
    
    // input
    let foodName = BehaviorRelay<String>(value: "")
    let amount = BehaviorRelay<String>(value: "")
    let rating = BehaviorRelay<String>(value: "")
    let waitingTime = BehaviorRelay<String>(value: "")
    let category = BehaviorRelay<String>(value: "")
    let imageUrl = BehaviorRelay<String>(value: "")
    
    // outPut
    let isCreated = BehaviorRelay<Bool>(value: false)
    
    var enableBtn : Observable<Bool> {
        return Observable.combineLatest(foodName.asObservable(),amount.asObservable(),rating.asObservable(),waitingTime.asObservable(),category.asObservable(),imageUrl.asObservable()){ name, foodAmount, foodRating, foodWaitingTime, foodCategory, foodImageUrl in
            !name.isEmpty && !foodImageUrl.isEmpty && !foodAmount.isEmpty && !foodWaitingTime.isEmpty && !foodCategory.isEmpty && !foodRating.isEmpty
        }
    }
    
    // interaction
    let tapCreate : AnyObserver<Void>
    let didTapCreate : Observable<Void>
    
    override init() {
        let _tapCreate = PublishSubject<Void>()
        self.tapCreate = _tapCreate.asObserver()
        self.didTapCreate = _tapCreate.asObservable()
        
        super.init()
        didTapCreate.subscribe(onNext: { (_) in
            self.addFoodItem(foodItem: FoodVO(id: "", amount: Double(self.amount.value), foodName: self.foodName.value, rating: Double(self.rating.value), waitingTime: Int(self.waitingTime.value), imgUrl: self.imageUrl.value, category: Int(self.category.value)))
        }).disposed(by: disposableBag)
        
    }
}

extension AddFoodItemViewModel {
    func didTapChooseAndUploadPhoto(image : UIImage) {
        loadingObservable.accept(true)
        FoodModel.shared.uploadImage(image: image, success: { (imageName) in
            self.loadingObservable.accept(false)
            self.uploadedImageName.accept(imageName)
        }) { (error) in
            self.errorObservable.accept(error)
        }
    }
    
    func addFoodItem(foodItem : FoodVO) {
        FoodModel.shared.addFoodItem(data: foodItem.toDictionary())
        isCreated.accept(true)
    }
    
}
