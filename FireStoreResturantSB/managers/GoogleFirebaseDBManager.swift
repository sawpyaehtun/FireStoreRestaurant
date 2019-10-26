//
//  GoogleFirebaseDBManager.swift
//  FireStoreProject
//
//  Created by saw pyaehtun on 23/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import FirebaseFirestore
import RxSwift
import RxCocoa

final class GoogleFirebaseDBManager {
    
    var listener : ListenerRegistration?
    
    var query : Query? {
        didSet {
            if let listener = listener {
                listener.remove()
            }
        }
    }
    
    let db = Firestore.firestore()
    
    private func baseQuery(collectionPath : String)-> Query{
        return Firestore.firestore().collection(collectionPath)
    }
    
//    func getDataFromFireStore(collectionPath : String,
//                              success : @escaping ([QueryDocumentSnapshot]?) -> Void,
//                              failure : @escaping (Error) -> Void) {
//        self.query = baseQuery(collectionPath: collectionPath)
//
//        self.listener = query?.addSnapshotListener({ (querySnapshot, error) in
//            if let err = error{
//                print(err.localizedDescription)
//                failure(err)
//            } else{
//                success(querySnapshot?.documents)
//            }
//        })
//    }
    
    func getDataFromFireStore(collectionPath : String) -> Observable<Any?> {
        self.query = baseQuery(collectionPath: collectionPath)
        
        return Observable.create { observer in
            self.listener = self.query?.addSnapshotListener({ (querySnapshot, error) in
                if let err = error{
                    print(err.localizedDescription)
                    observer.onError(error!)
                } else{
                    observer.onNext(querySnapshot?.documents)
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }
    
    func addData(collectionPath : String, data : [String : Any]) {
        db.collection(collectionPath).addDocument(data: data)
    }
    
    func deleteData(collectionPath : String, id : String) {
        db.collection(collectionPath).document(id).delete()
    }
}
