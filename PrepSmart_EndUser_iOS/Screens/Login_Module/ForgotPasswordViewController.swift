//
//  ForgotPasswordViewController.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 27/05/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD004

import UIKit


class ForgotPasswordViewController: BaseViewController, CustomPopUpViewControllerDelegate {
    func onClcikOkButton() {
        let vc = UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
        
//            self.dismiss(animated: false, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var scrollView : UIScrollView!
    
    @IBOutlet weak var forgotPasswordTextFiledBGView: UIView!
    
    @IBOutlet weak var forgotPasswordTextFiled: KKNEWTextFiled!
    
    @IBOutlet weak var resetPasswordButton: UIButton!
    

    var forgotPassObj = ForgotPassword_Struct()
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
    
    func    initialize(){
        self.navigationController?.navigationBar.isHidden = true
        self.forgotPasswordTextFiledBGView.layer.cornerRadius = self.forgotPasswordTextFiledBGView.frame.height / 2
        
        self.resetPasswordButton.layer.cornerRadius = self.resetPasswordButton.frame.height / 2
    }
    
    //    MARK: OnClick Func
    @IBAction func onClickResetPasswordButton(_ sender: Any) {
        
        if isUserInputValid() {
           forgotPasswordApi()
        }
        
    }
    
    @IBAction func onClickNavBackButton(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ForgotPasswordViewController : UITextFieldDelegate {
    
    // MARK: TextFiled Delegate
    func isUserInputValid() -> Bool {
        //        var errorMessage:NSString = ""
        
        if forgotPasswordTextFiled.text == "" {
            self.forgotPasswordTextFiled.errorText = "Please Enter Email Address."
            self.showWarning(title: "Email", warningMessage: "Please Enter Email Address.")
            self.forgotPasswordTextFiled.showError()
            return false
        }
        else if UtilityManager.isValidEmail(forgotPasswordTextFiled.text!) == false {
            self.forgotPasswordTextFiled.errorText = "Please Enter valid Email Address."
             self.showWarning(title: "Invalid Email", warningMessage: "Please Enter Valid Email Address.")
            self.forgotPasswordTextFiled.showError()
            return false
        }
        else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.forgotPasswordTextFiled.hideError()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == forgotPasswordTextFiled {
            self.forgotPasswordTextFiled.resignFirstResponder()
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
    override func keyboardDidShow(notification: Notification)
    {
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - Constants.marginConstant , right: 0)
    }
    
    override func keyboardDidHide(notification: Notification)
    {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0 , right: 0)
    }
}

extension ForgotPasswordViewController
{
    
   func forgotPasswordApi()
    {
        let param:[String:String] = ["email":forgotPasswordTextFiled.text ?? "" ]
                Loader.sharedInstance.showIndicator()

        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.forgetPass_Api, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):

                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.forgotPassObj = try JSONDecoder().decode(ForgotPassword_Struct.self, from: data)
                            self.global_Var.token = self.forgotPassObj.access_token
                            self.showCustomPopUp(mesgText: self.forgotPassObj.message , topImageName: #imageLiteral(resourceName: "like02"), bottomImageName: #imageLiteral(resourceName: "img-2"), customDelegate: self)

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
