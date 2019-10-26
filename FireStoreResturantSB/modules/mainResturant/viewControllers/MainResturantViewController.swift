//
//  ViewController.swift
//  FireStoreResturantSB
//
//  Created by saw pyaehtun on 23/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MainResturantViewController: BaseViewController {
    
    @IBOutlet weak var btnAdd: RoundedButton!
    @IBOutlet weak var tableviewFooditemList: UITableView!
    @IBOutlet weak var viewCategory: CategoryView!
    
    let viewModel = MainResturentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpUIs() {
        super.setUpUIs()
        setupTableView()
        viewCategory.categoryViewDelegate = self
    }
    
    override func bindModel() {
        super.bindModel()
        viewModel.bindViewModel(in: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFoodList()
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.foodItemListObserable.bind(to: tableviewFooditemList.rx.items(cellIdentifier: String(describing: FoodItemTableViewCell.self), cellType: FoodItemTableViewCell.self)){ row, model, cell in
            cell.foodItem = model
        }.disposed(by: disposableBag)
        
        btnAdd.rx.tap.subscribe(onNext: { (_) in
            let vc = AddFoodItemViewController.init()
            vc.modalPresentationStyle = .fullScreen
            vc.categoryID = self.viewCategory.selectedId
            self.present(vc, animated: true, completion: nil)
        }).disposed(by: disposableBag)
    }
}

extension MainResturantViewController {
    private func setupTableView(){
        tableviewFooditemList.register(UINib(nibName: String(describing: FoodItemTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FoodItemTableViewCell.self))
    }
}

extension MainResturantViewController : CategoryViewDelegate {
    func didChooseCategory(id: Int) {
        viewModel.categoryIDObserable.accept(id)
    }
}
