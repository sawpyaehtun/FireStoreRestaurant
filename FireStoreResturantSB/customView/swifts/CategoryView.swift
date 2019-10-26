//
//  CategoryView.swift
//  FireStoreResturantSB
//
//  Created by saw pyaehtun on 24/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CategoryViewDelegate {
    func didChooseCategory(id : Int)
}

class CategoryView: UIView {
    
    @IBOutlet weak var btnEntress: CategoryRoundedButton!
    @IBOutlet weak var btnMain: CategoryRoundedButton!
    @IBOutlet weak var btnDrink: CategoryRoundedButton!
    @IBOutlet weak var btnDessart: CategoryRoundedButton!
    let disposableBag = DisposeBag()
    var selectedId = 1
    var categoryViewDelegate : CategoryViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitialization()
    }
    
    func commonInitialization() {
        let view = Bundle.main.loadNibNamed(String(describing: CategoryView.self), owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        
        let btns : [CategoryRoundedButton] = [btnEntress,btnMain,btnDrink,btnDessart]
        for btn in btns {
            btn.rx.tap.subscribe(onNext: { (_) in
                if !btn.isChecked {
                    self.setupBtn(id: btn.id)
                }
            }).disposed(by: disposableBag)
        }
        
        self.addSubview(view)
    }
    
    private func setupBtn(id : Int){
        let btns : [CategoryRoundedButton] = [btnEntress,btnMain,btnDrink,btnDessart]
        selectedId = id
        for btn in btns {
            btn.isChecked = (btn.id == id) ? true : false
        }
        categoryViewDelegate?.didChooseCategory(id: id)
    }
}
