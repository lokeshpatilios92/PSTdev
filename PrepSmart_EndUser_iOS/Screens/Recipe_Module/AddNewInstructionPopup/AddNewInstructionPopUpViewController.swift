//
//  AddNewInstructionPopUpViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 10/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD0143

import UIKit

protocol AddNewInstructionPopUpViewControllerDelegate {
    func onClickSaveButton()
    func onClickCancelButton()
}

class AddNewInstructionPopUpViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var txtFld_step: UITextField!
    @IBOutlet weak var txtFld_description: UITextField!
    @IBOutlet weak var saveAndAddIngredientsBtn: UIButton!
    
    var msgText : String! = "Add a new Instruction"
    var okButtonName : String! = "Save"
    var cancelButtonName : String! = "Cancel"
    
    var customDelegate : AddNewInstructionPopUpViewControllerDelegate!
    
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
        self.saveAndAddIngredientsBtn.layer.cornerRadius = self.saveAndAddIngredientsBtn.frame.height / 2
        self.cancelButton.layer.borderWidth = 0.5
        self.cancelButton.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
        
        self.saveButton.layer.borderWidth = 0.5
        self.saveButton.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
        
        self.txtFld_step.setLeftPaddingPoints(8.0)
        self.txtFld_description.setLeftPaddingPoints(8.0)
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimation()
    }
    
    //    MARK: OnClick
    @IBAction func onClickCloseButton(_ sender: Any) {
        self.removeAnimation()
    }
    
    @IBAction func onClickCancelButton(_ sender: Any) {
        if customDelegate != nil {
            self.customDelegate.onClickCancelButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    
    @IBAction func onClickOkButton(_ sender: Any) {
        if customDelegate != nil {
            self.customDelegate.onClickSaveButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }

    @IBAction func onClickSaveAndAddIngredientsBtn(_ sender: UIButton) {
        self.removeAnimation()
    }
}
