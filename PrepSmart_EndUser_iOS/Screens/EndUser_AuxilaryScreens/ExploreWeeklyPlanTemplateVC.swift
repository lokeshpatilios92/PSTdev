//
//  ExploreWeeklyPlanTemplateVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 11/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import DropDown

class ExploreWeeklyPlanTemplateVC: BaseViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var Lbl_resultCount: UILabel!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var txt_dropDown: UITextField!
    
    var exploreWeeklyPlanTemplatesCell = "ExploreWeeklyPlanTemplatesCell"
    let viewByDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    
    func initialization(){
      
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (view.frame.width) / 2 - 15, height: view.frame.width / 2)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: exploreWeeklyPlanTemplatesCell, bundle: nil), forCellWithReuseIdentifier: exploreWeeklyPlanTemplatesCell)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        dropDownView.layer.cornerRadius = dropDownView.frame.height / 2
        dropDownView.layer.borderColor = UIColor.lightGray.cgColor
        dropDownView.layer.borderWidth = 1
        txt_dropDown.delegate = self
        viewByDropDown.dataSource = ["View By","chef 1","Chef 2","Chef3"]
        viewByDropDown.backgroundColor = UIColor.white
        DropDown.startListeningToKeyboard()
        setupSearchBar()
    }
   
    
    func setupSearchBar(){
        
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = .white
        searchBar.isTranslucent = true
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 0.50
        searchBar.layer.cornerRadius = searchBar.frame.height / 2
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: UISearchBar.Icon.search, state: .normal)
        
    }
    
}
extension ExploreWeeklyPlanTemplateVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: exploreWeeklyPlanTemplatesCell, for: indexPath) as! ExploreWeeklyPlanTemplatesCell
        return cell
    }
}

extension ExploreWeeklyPlanTemplateVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.txt_dropDown{
            viewByDropDown.anchorView = self.txt_dropDown
            
            viewByDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.txt_dropDown.text = item
            }
             viewByDropDown.show()
//            self.txt_dropDown.resignFirstResponder()
           
        }
    }
    
}
