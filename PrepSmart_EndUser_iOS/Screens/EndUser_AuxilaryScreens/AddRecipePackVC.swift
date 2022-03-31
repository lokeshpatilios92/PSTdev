//
//  AddRecipePackVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 10/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen Id :- PSTMOBSTD0136

import UIKit
import DropDown

class AddRecipePackVC: BaseViewController {
    
    
    @IBOutlet weak var recipePackNameTxtField: KKNEWTextFiled!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var desigationTxtField: KKNEWTextFiled!
    @IBOutlet weak var selectCategoryTxtField: KKNEWTextFiled!
    @IBOutlet weak var selectDietTypeTxtField: KKNEWTextFiled!
    @IBOutlet weak var includeRecipeLbl: UILabel!
    @IBOutlet weak var selectSeasonTxtField: KKNEWTextFiled!
    
    let categoryDropDown = DropDown()
    let dietDropDown = DropDown()
    let seasonDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
        
    }
    
    
    func initializer(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Add Recipe Pack")
        self.createBtn.layer.cornerRadius = createBtn.frame.height/2
        selectCategoryTxtField.delegate = self
        selectDietTypeTxtField.delegate = self
        selectSeasonTxtField.delegate = self
        categoryDropDown.dataSource = ["category1","category2","category3"]
        dietDropDown.dataSource = ["diet1","diet2","diet3"]
        seasonDropDown.dataSource = ["season1","season2","season3"]
        DropDown.startListeningToKeyboard()
    }
    
    @IBAction func createBtnTapped(_ sender: UIButton) {
        let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreRecipePackDetailsViewController") as! ExploreRecipePackDetailsViewController
        vc.isComingFrom = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBOutlet weak var addBtnTapped: UIImageView!
    
}

extension AddRecipePackVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.selectCategoryTxtField{
            categoryDropDown.anchorView = self.selectCategoryTxtField
            categoryDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.selectCategoryTxtField.text = item
                
            }
            
            categoryDropDown.show()
            self.selectCategoryTxtField.resignFirstResponder()
            
        }else if  textField == self.selectDietTypeTxtField{
            dietDropDown.anchorView = self.selectDietTypeTxtField
            dietDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.selectDietTypeTxtField.text = item
                
            }
            
            dietDropDown.show()
            self.selectDietTypeTxtField.resignFirstResponder()
            
            
        }else if textField == self.selectSeasonTxtField{
            seasonDropDown.anchorView = self.selectSeasonTxtField
            seasonDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.selectSeasonTxtField.text = item
                
            }
            seasonDropDown.show()
            self.selectSeasonTxtField.resignFirstResponder()
            
        }else{
            print("another textfield is clicked")
        }
    }
}
