//
//  ReportThisRecipePopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 12/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  SCREEN ID - PSTMOBSTD108

import UIKit
import IQKeyboardManagerSwift
import DropDown

protocol ReportThisRecipePopUpDelegate {
    func onClicksubmitButton()
}

class ReportThisRecipePopUpVC: UIViewController {
    
    @IBOutlet var selectReasonTxtField: KKNEWTextFiled!
    @IBOutlet var enterReasonTxtView: IQTextView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var bgView: UIView!
    
    let reasonDropDown = DropDown()
    var customDelegate : ReportThisRecipePopUpDelegate!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialize()
    }
    
    func intialize() {
        self.bgView.layer.cornerRadius = 10
        self.submitBtn.layer.cornerRadius = self.submitBtn.frame.height / 2
        self.cancelBtn.layer.cornerRadius = self.cancelBtn.frame.height / 2
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        selectReasonTxtField.delegate = self
        reasonDropDown.dataSource = ["Reason 1", "Reason 2", "Reason 3","Reason 4","Reason 5"]
        setupDropDown()
        self.showAnimation()
    }
    
    func setupDropDown(){
        reasonDropDown.anchorView = selectReasonTxtField
        reasonDropDown.width = self.selectReasonTxtField.frame.width
        DropDown.appearance().textColor = UIColor.darkText
        DropDown.appearance().selectedTextColor = UIColor.darkText
        DropDown.appearance().textFont = UIFont(name: "ENGCARNATION", size: 14.0)!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().cellHeight = 60
        DropDown.startListeningToKeyboard()
    }
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        if customDelegate != nil {
            self.customDelegate.onClicksubmitButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    
}

extension ReportThisRecipePopUpVC : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        reasonDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectReasonTxtField.text = item
       }
        _ = self.selectReasonTxtField.resignFirstResponder()
        self.reasonDropDown.show()
  }
}
