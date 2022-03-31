//
//  ChangePasswordPopUpVc.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 30/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD0153

import UIKit

protocol CustomPopUpChangePasswordDelegate {
    func onClcikSaveButton(message: String?)
}


class ChangePasswordPopUpVc: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var txt_currentPassword: KKNEWTextFiled!
    @IBOutlet weak var txt_NewPassword: KKNEWTextFiled!
    @IBOutlet weak var txt_ConfirmPass: KKNEWTextFiled!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    
    var customDelegate : CustomPopUpChangePasswordDelegate!
    var changePasswordObj = Get_Status()
    var global_Var = GlobalClass.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializer()
    }
    
    func initializer(){
    
        txt_NewPassword.delegate = self
        txt_ConfirmPass.delegate = self
        txt_currentPassword.delegate = self
        self.backView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        saveBtn.layer.cornerRadius = saveBtn.frame.height/2
        cancelBtn.layer.cornerRadius = cancelBtn.frame.height/2
        cancelBtn.layer.borderColor = UIColor.appOrangeColor().cgColor
        cancelBtn.layer.borderWidth = 1
        
        self.txt_currentPassword.setLeftPaddingPoints(10.0)
        self.txt_ConfirmPass.setLeftPaddingPoints(10.0)
        self.txt_NewPassword.setLeftPaddingPoints(10.0)
        
        self.showAnimation()
        
    }
    
    
    @IBAction func saveTapped(_ sender: UIButton) {
        if customDelegate != nil {
            
            if self.isUserInputValid(){
                self.changePasswordAPi()
            }
        } else {
            self.removeAnimation()
        }
    }
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    @IBAction func crossTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
}

extension ChangePasswordPopUpVc : UITextFieldDelegate {
    
    // MARK: TextFiled Delegate
    func isUserInputValid() -> Bool {
        //        var errorMessage:NSString = ""
        
        if txt_currentPassword.text == "" {
            self.txt_currentPassword.errorText = "Please Enter Current Password."
            self.showWarning(title: "Password", warningMessage: "Please Enter Current Password.")
            self.txt_currentPassword.showError()
            return false
        }
     
        else if txt_NewPassword.text == "" {
            self.txt_NewPassword.errorText = "Please Enter New Password."
            self.showWarning(title: "Password", warningMessage: "Please Enter New Password.")
            self.txt_NewPassword.showError()
            return false
        }
        else if txt_ConfirmPass.text == "" {
            self.txt_ConfirmPass.errorText = "Please Re-Enter New Password."
            self.showWarning(title: "Password", warningMessage: "Please Re-Enter New Password.")
            self.txt_ConfirmPass.showError()
            return false
        }
        else if txt_NewPassword.text != txt_ConfirmPass.text {
            self.txt_NewPassword.errorText = ""
            self.txt_NewPassword.showError()
            
            self.txt_ConfirmPass.errorText = "Password Not Mach"
            self.showWarning(title: "Password", warningMessage: "Password Not Mach.")
            self.txt_ConfirmPass.showError()
            
            return false
        }
        else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.txt_currentPassword.hideError()
        self.txt_NewPassword.hideError()
        self.txt_ConfirmPass.hideError()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_currentPassword {
            self.txt_currentPassword.resignFirstResponder()
            self.txt_NewPassword.becomeFirstResponder()
        }
        if textField == txt_NewPassword {
            self.txt_NewPassword.resignFirstResponder()
            self.txt_ConfirmPass.becomeFirstResponder()
        }
        if textField == txt_ConfirmPass {
            self.txt_ConfirmPass.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(range.location == 0) {
            if(string == " ") {
                return false
            }
        }
        return true
    }
    
    // MARK:- Keyboard Methods
//    override func keyboardDidShow(notification: Notification) {
//        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - Constants.marginConstant , right: 0)
//    }
//    
//    override func keyboardDidHide(notification: Notification) {
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0 , right: 0)
//    }
//    
}

extension ChangePasswordPopUpVc
{
    func changePasswordAPi()
    {
        
        
        let param:[String:String] = ["old_password":self.txt_currentPassword.text ?? "","new_password":self.txt_NewPassword.text ?? ""]
        
                Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.changePass_Api, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.changePasswordObj = try JSONDecoder().decode(Get_Status.self, from: data)
                            self.customDelegate.onClcikSaveButton(message: self.changePasswordObj.message)
                            self.removeAnimation()

                        }
                        catch
                        {
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                            
                        }
                    }
                    else
                    {
                        Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: self.global_Var.get_status.message)
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: self.global_Var.get_status.message)
                }
                                Loader.sharedInstance.hideIndicator()
                break
                
            case .failer(let error):
                
                Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                                Loader.sharedInstance.hideIndicator()
                break
            }
        }
    }
}

