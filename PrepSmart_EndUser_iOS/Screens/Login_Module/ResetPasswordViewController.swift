//
//  ResetPasswordViewController.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 27/05/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
// Screen Id : PSTMOBSTD005

import UIKit

class ResetPasswordViewController : BaseViewController, CustomPopUpViewControllerDelegate {
    
    func onClcikOkButton() {
        let vc = UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBOutlet weak var scrollView : UIScrollView!
    
    @IBOutlet weak var tempPasswordTextFiledBGView: UIView!
    @IBOutlet weak var passwordTextFiledBGView: UIView!
    @IBOutlet weak var confPasswordTextFiledBGView: UIView!
    
    @IBOutlet weak var tempPasswordTextFiled: KKNEWTextFiled!
    @IBOutlet weak var passwordTextFiled: KKNEWTextFiled!
    @IBOutlet weak var confPasswordTextFiled: KKNEWTextFiled!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var tempPassword : String! = ""
    var resetPasswordObj = Get_Status()
    var global_Var = GlobalClass.sharedManager

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.dismissKeyboardOnTap()
        addKeyboardNotificationObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotificationObserver()
    }
    
    func initialize() {
        self.tempPasswordTextFiledBGView.layer.cornerRadius = self.tempPasswordTextFiledBGView.frame.height / 2
        
        self.passwordTextFiledBGView.layer.cornerRadius = self.passwordTextFiledBGView.frame.height / 2
        
        self.confPasswordTextFiledBGView.layer.cornerRadius = self.confPasswordTextFiledBGView.frame.height / 2
        
        self.submitButton.layer.cornerRadius = self.submitButton.frame.height / 2
        
        self.tempPasswordTextFiled.delegate = self
        self.passwordTextFiled.delegate = self
        self.confPasswordTextFiled.delegate = self
    }
    
    //    MARK: OnClick Func
    
    @IBAction func onClickSubmitButton(_ sender: Any) {
        
        if isUserInputValid() {
        
        resetPasswordApi()
        
        }
    
    }
    
    @IBAction func onClickNavBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ResetPasswordViewController : UITextFieldDelegate {
    
    // MARK: TextFiled Delegate
    func isUserInputValid() -> Bool {
        //        var errorMessage:NSString = ""
        
        if tempPasswordTextFiled.text == "" {
            self.tempPasswordTextFiled.errorText = "Please Enter Temp Password."
            self.tempPasswordTextFiled.showError()
            return false
        }
//        else if tempPasswordTextFiled.text != self.tempPassword {
//            self.tempPasswordTextFiled.errorText = "Incorrect Temp Password."
//            self.tempPasswordTextFiled.showError()
//            return false
//        }
        else if passwordTextFiled.text == "" {
            self.passwordTextFiled.errorText = "Please Enter New Password."
            self.passwordTextFiled.showError()
            return false
        }
        else if confPasswordTextFiled.text == "" {
            self.confPasswordTextFiled.errorText = "Please Re-Enter New Password."
            self.confPasswordTextFiled.showError()
            return false
        }
        else if passwordTextFiled.text != confPasswordTextFiled.text {
            self.passwordTextFiled.errorText = ""
            self.passwordTextFiled.showError()
            
            self.confPasswordTextFiled.errorText = "Password Not Mach"
            self.confPasswordTextFiled.showError()
            
            return false
        }
        else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.tempPasswordTextFiled.hideError()
        self.passwordTextFiled.hideError()
        self.confPasswordTextFiled.hideError()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tempPasswordTextFiled {
            self.tempPasswordTextFiled.resignFirstResponder()
            self.passwordTextFiled.becomeFirstResponder()
        }
        if textField == passwordTextFiled {
            self.passwordTextFiled.resignFirstResponder()
            self.confPasswordTextFiled.becomeFirstResponder()
        }
        if textField == confPasswordTextFiled {
            self.confPasswordTextFiled.resignFirstResponder()
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
    override func keyboardDidShow(notification: Notification) {
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - Constants.marginConstant , right: 0)
    }
    
    override func keyboardDidHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0 , right: 0)
    }
}

extension ResetPasswordViewController
{
    
   func resetPasswordApi()
    {


        let param:[String:String] = ["tmp_password":tempPasswordTextFiled.text ?? "" ,"new_password":passwordTextFiled.text ?? ""]

                Loader.sharedInstance.showIndicator()

        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.setPassword, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):

                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.resetPasswordObj = try JSONDecoder().decode(Get_Status.self, from: data)
                            
                            self.showCustomPopUp(mesgText: self.resetPasswordObj.message, topImageName: #imageLiteral(resourceName: "smile"), bottomImageName: nil, customDelegate: self)

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
