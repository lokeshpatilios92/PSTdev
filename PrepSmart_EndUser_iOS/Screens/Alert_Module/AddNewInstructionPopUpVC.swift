//
//  AddNewInstructionPopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 16/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
protocol CustomAddAddNewInstructionPopUpDelegate {
    
}
class AddNewInstructionPopUpVC: UIViewController {
    
    @IBOutlet var txt_step: KKNEWTextFiled!
    @IBOutlet var txt_description: KKNEWTextFiled!
    @IBOutlet var btn_save: UIButton!
    @IBOutlet var btn_cancel: UIButton!
    @IBOutlet weak var saveAndAddIngredients: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initialize()
    }
    
    func initialize()
    {
        btn_save.layer.cornerRadius = btn_save.frame.size.height / 2
        btn_cancel.layer.cornerRadius = btn_cancel.frame.size.height / 2
        btn_cancel.layer.borderWidth = 1.0
        btn_cancel.layer.borderColor = UIColor.appOrangeColor().cgColor
        saveAndAddIngredients.layer.cornerRadius = saveAndAddIngredients.frame.height / 2
    }
    
    @IBAction func onClickBtnClose(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func onClickBtnCancel(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func onClickBtnSave(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func onClicksaveAndAddIngredients(_ sender: UIButton) {
        self.removeAnimation()
    }
}
