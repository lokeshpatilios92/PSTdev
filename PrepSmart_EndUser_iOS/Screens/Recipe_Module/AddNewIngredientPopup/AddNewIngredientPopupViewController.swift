//
//  AddNewIngredientPopupViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 10/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID:- PSTMOBSTD0139

import UIKit
import DropDown

protocol AddNewIngredientPopupViewControllerDelegate {
    func onClickIngredientSaveButton()
    func onClickIngredientCancelButton()
}

class AddNewIngredientPopupViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var txtFld_quantity: UITextField!
    @IBOutlet weak var txtFld_enterIngredient: UITextField!
    @IBOutlet weak var lbl_unit: UILabel!
    @IBOutlet weak var lbl_ingredient: UILabel!
    @IBOutlet weak var lbl_category: UILabel!
    @IBOutlet weak var lbl_assignToStep: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addNextStepButton: UIButton!
    @IBOutlet weak var unitButton: UIButton!
    @IBOutlet weak var ingredientButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var assignToStepButton: UIButton!
    @IBOutlet weak var enterYourIngredientView: UIView!
    
    var msgText : String! = "Add a new Ingredient"
    var okButtonName : String! = "Save"
    var cancelButtonName : String! = "Cancel"
    
    let unitDropDown = DropDown()
    let ingredientDropDown = DropDown()
    let categoryDropDown = DropDown()
    let assignToStepDropDown = DropDown()
    
    
    
    
    var customDelegate : AddNewIngredientPopupViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialize()
    }
    
    func intialize() {
        self.bgView.layer.cornerRadius = 10
        
        self.messageLabel.text = msgText
        self.saveButton.setTitle(okButtonName, for: .normal)
        self.cancelButton.setTitle(cancelButtonName, for: .normal)
        
        self.saveButton.layer.cornerRadius = self.saveButton.frame.height / 2
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.height / 2
        
        self.addNextStepButton.layer.cornerRadius = self.addNextStepButton.frame.height / 2
        
        self.cancelButton.layer.borderWidth = 0.5
        self.cancelButton.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
        
        self.saveButton.layer.borderWidth = 0.5
        self.saveButton.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
        
        self.txtFld_quantity.setLeftPaddingPoints(8.0)
        self.txtFld_enterIngredient.setLeftPaddingPoints(8.0)
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.scrollView.layer.cornerRadius = 5
//        self.showAnimation()
        
        
        unitDropDown.dataSource = ["lbs","abs"]
        ingredientDropDown.dataSource = ["Meal Plan A","Meal Plan B","Meal Plan C","Meal Plan D","Meal Plan E","My Ingredient is not Listed"]
        categoryDropDown.dataSource = ["Popular","Medium","Large"]
        assignToStepDropDown.dataSource = ["Step 1","Step 2"]
        
        setupDropDown()
    }
    
    
    func setupDropDown(){
        unitDropDown.anchorView = lbl_unit
        ingredientDropDown.anchorView = lbl_ingredient
        categoryDropDown.anchorView = lbl_category
        assignToStepDropDown.anchorView = lbl_assignToStep

       // mealPlanDropDown.width = self.mealPlanTxtFIeld.frame.width
        DropDown.appearance().textColor = UIColor.darkText
        DropDown.appearance().selectedTextColor = UIColor.darkText
        DropDown.appearance().textFont = UIFont(name: "ENGCARNATION", size: 14.0)!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().cellHeight = 60
        DropDown.startListeningToKeyboard()
    }
    
    //    MARK: OnClick
    @IBAction func onClickCloseButton(_ sender: Any) {
        self.removeAnimation()
    }
    
    @IBAction func onClickCancelButton(_ sender: Any) {
        if customDelegate != nil {
            self.customDelegate.onClickIngredientCancelButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    
    @IBAction func onClickOkButton(_ sender: Any) {
        if customDelegate != nil {
            self.customDelegate.onClickIngredientSaveButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    
    @IBAction func onClickAddNextStepButton(_ sender: UIButton) {

    }
    
    @IBAction func onClickDropDownButton(_ sender: UIButton) {
        
        if sender == unitButton
        {
            unitDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.lbl_unit.text = item
            }
            self.unitDropDown.show()
        }
        else if sender == ingredientButton
        {
            ingredientDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.lbl_ingredient.text = item
                
                if index == 5
                {
                    self.enterYourIngredientView.isHidden = false
                }
                else
                {
                    self.enterYourIngredientView.isHidden = true
                }
            }
            self.ingredientDropDown.show()
        }
        else if sender == categoryButton
        {
            categoryDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.lbl_category.text = item
            }
            self.categoryDropDown.show()
        }
        else if sender == assignToStepButton
        {
            assignToStepDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.lbl_assignToStep.text = item
            }
            self.assignToStepDropDown.show()
        }
        
    }

    
}
