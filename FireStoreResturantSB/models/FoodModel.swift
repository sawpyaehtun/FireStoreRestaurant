//
//  FoodModel.swift
//  FireStoreResturantSB
//
//  Created by saw pyaehtun on 24/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import FirebaseFirestore

final class FoodModel {
    let COLLECTION_PATH = "FOOD"
    static let shared = FoodModel()
}

extension FoodModel {
    
    func uploadImage(image : UIImage,
                     success : @escaping (String) -> Void,
                     failure : @escaping (String) -> Void){
        FireStorageManager().upload(image: image, success: { (imageName) in
            self.getImgurl(imageName: imageName, success: { (url) in
                success(url.absoluteString)
            }) { (err) in
                failure(err)
            }
        }) { (err) in
            failure(err)
        }
    }
    
    func getImgurl(imageName : String,
                   success : @escaping (URL) -> Void,
                   failure : @escaping (String) -> Void) {
        FireStorageManager().downloadUrl(imageName: imageName, success: { (url) in
            success(url)
        }) { (err) in
            failure(err)
        }
    }
    
    func addFoodItem(data : [String : Any]) {
        GoogleFirebaseDBManager().addData(collectionPath: COLLECTION_PATH, data: data)
    }
    
    //    func getFoodItems(success : @escaping ([FoodVO]) -> Void,
    //                 failure : @escaping (String) -> Void) {
    //        GoogleFirebaseDBManager().getDataFromFireStore(collectionPath: COLLECTION_PATH, success: { (queryDocumentSnapshot) in
    //            if let results = queryDocumentSnapshot?.map({ (document) -> FoodVO in
    //                if let foods = FoodVO(dictionary: document.data(), id: document.documentID){
    //                    return foods
    //                } else {
    //                    fatalError()
    //                }
    //            }){
    //                success(results)
    //            }
    //        }) { (err) in
    //            failure(err)
    //        }
    //    }
    
    func getFoodItems() -> Observable<[FoodVO]> {
        
        return GoogleFirebaseDBManager().getDataFromFireStore(collectionPath: COLLECTION_PATH).flatMap { (resposnseObj) -> Observable<[FoodVO]> in
            if let qureyDocumentSnapShot = resposnseObj as? [QueryDocumentSnapshot]{
                let results = qureyDocumentSnapShot.map({ (document) -> FoodVO in
                    if let foods = FoodVO(dictionary: document.data(), id: document.documentID){
                        return foods
                    } else {
                        fatalError()
                    }
                })
                return Observable.just(results)
            } else {
                return Observable.just([])
            }
        }
    }
}
