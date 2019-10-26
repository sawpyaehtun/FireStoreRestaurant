//
//  FireStorageManager.swift
//  FireStoreResturantSB
//
//  Created by saw pyaehtun on 24/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import FirebaseStorage

final class FireStorageManager {
    
    func upload(image : UIImage,
                success : @escaping (String) -> Void,
                failure : @escaping (String) -> Void){
        let imageName = UUID().uuidString
        let imageRefrance = Storage.storage().reference().child("images").child(imageName)
        
        guard let data = image.jpegData(compressionQuality: 0.8) else {return}
        
        imageRefrance.putData(data, metadata: nil) { (metaData, error) in
            if let error = error {
                print(error.localizedDescription)
                failure(error.localizedDescription)
            }
            success(imageName)
        }
    }
    
    func downloadUrl(imageName : String,
                     success : @escaping (URL) -> Void,
                     failure : @escaping (String) -> Void){
        let imageRefrance = Storage.storage().reference().child("images").child(imageName)
        imageRefrance.downloadURL { (url, error) in
            if let error = error {
                print(error.localizedDescription)
                failure(error.localizedDescription)
            }
            success(url!)
        }
    }
}
