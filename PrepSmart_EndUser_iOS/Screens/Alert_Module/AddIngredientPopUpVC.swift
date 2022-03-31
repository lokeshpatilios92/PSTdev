//
//  AddIngredientPopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 14/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen ID : PSTMOBSTD127

import UIKit
protocol CustomAddIngredientPopUpDelegate {
    
}
class AddIngredientPopUpVC: BaseViewController,UITextFieldDelegate {
    
    @IBOutlet var txt_ingredient: KKNEWTextFiled!
    @IBOutlet var txt_category: KKNEWTextFiled!
    @IBOutlet var txt_quantity: KKNEWTextFiled!
    @IBOutlet var txt_unit: KKNEWTextFiled!
    @IBOutlet var txt_assignToStep: KKNEWTextFiled!
    @IBOutlet weak var addNextStepButton: UIButton!
    @IBOutlet var btn_cancel: UIButton!
    @IBOutlet var btn_save: UIButton!
    var customDelegate : CustomAddIngredientPopUpDelegate?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initialize()
        setTextFieldDelegate()
    }
    
    func initialize()
    {
        btn_save.layer.cornerRadius = btn_save.frame.size.height / 2
        btn_cancel.layer.cornerRadius = btn_cancel.frame.size.height / 2
        btn_cancel.layer.borderWidth = 1.0
        btn_cancel.layer.borderColor = UIColor.appOrangeColor().cgColor
    }
    
    //MARK:Button Actions
    @IBAction func onClickBtnClose(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func onClickBtnCancel(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func onClickBtnSave(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickBtnMyIngredient(_ sender: UIButton) {
        
    }
    
    //MARK:UITextField Delegate Methods
    func setTextFieldDelegate()
    {
        txt_unit.delegate = self
        txt_category.delegate = self
        txt_quantity.delegate = self
        txt_ingredient.delegate = self
        txt_assignToStep.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.delegate = self
        return true
    }
    
}
