//
//  AddFoodItemViewController.swift
//  FireStoreResturantSB
//
//  Created by saw pyaehtun on 23/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import FirebaseStorage

class AddFoodItemViewController: BaseViewController {
    
    @IBOutlet weak var btnBackArrow: UIButton!
    @IBOutlet weak var imgFoodPhoto: RoundedUIImage!
    @IBOutlet weak var btnChoosePhotoAndUploadPhoto: RoundedButton!
    @IBOutlet weak var tfFoodName: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var tfRating: UITextField!
    @IBOutlet weak var tfWaitingTime: UITextField!
    @IBOutlet weak var btnCreate: RoundedButton!
    
    
    let viewModel = AddFoodItemViewModel()
    var categoryID : Int?{
        didSet {
            if let id = categoryID {
                self.viewModel.category.accept(String(id))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindModel() {
        super.bindModel()
        viewModel.bindViewModel(in: self)
    }
    
    override func bindData() {
        super.bindData()
        
        tfFoodName.rx.text.orEmpty.bind(to: viewModel.foodName).disposed(by: disposableBag)
        tfAmount.rx.text.orEmpty.bind(to: viewModel.amount).disposed(by: disposableBag)
        tfRating.rx.text.orEmpty.bind(to: viewModel.rating).disposed(by: disposableBag)
        tfWaitingTime.rx.text.orEmpty.bind(to: viewModel.waitingTime).disposed(by: disposableBag)
        
        btnChoosePhotoAndUploadPhoto.rx.tap.subscribe({ (_) in
            ImagePickerManager().pickImage(self) { (image) in
                self.imgFoodPhoto.image = image
                self.viewModel.didTapChooseAndUploadPhoto(image: self.imgFoodPhoto.image!)
            }
        }).disposed(by: disposableBag)
        
        btnCreate.rx.tap.bind(to: viewModel.tapCreate).disposed(by: disposableBag)
        
        btnBackArrow.rx.tap.subscribe({ (_) in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposableBag)
        
        viewModel.isCreated.subscribe(onNext: { (isCreated) in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposableBag)
        
        viewModel.enableBtn.bind(to: btnCreate.rx.isEnabled).disposed(by: disposableBag)
        
        viewModel.uploadedImageName.subscribe(onNext: { (imgUrl) in
            if let imgUrl = imgUrl{
                AlertManager.showCommonError(title: "Success", message: "The Photo is successfully uploaded!", vc: self)
                self.viewModel.imageUrl.accept(imgUrl)
            }
        }).disposed(by: disposableBag)
    }
    
}
