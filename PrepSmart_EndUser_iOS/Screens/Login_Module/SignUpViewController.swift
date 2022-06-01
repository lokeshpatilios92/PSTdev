//
//  SignUpViewController.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 28/05/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SignUpViewController : BaseViewController {
    @IBOutlet weak var scrollView : UIScrollView!
    
    @IBOutlet weak var userNameTextFiledBGView: UIView!
    @IBOutlet weak var emailTextFiledBGView: UIView!
    @IBOutlet weak var passwordTextFiledBGView: UIView!
    @IBOutlet weak var confPasswordTextFiledBGView: UIView!
    
    @IBOutlet weak var userNameTextFiled: KKNEWTextFiled!
    @IBOutlet weak var emailTextFiled: KKNEWTextFiled!
    @IBOutlet weak var passwordTextFiled: KKNEWTextFiled!
    @IBOutlet weak var confPasswordTextFiled: KKNEWTextFiled!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var showPasswordImage: UIImageView!
    @IBOutlet weak var confirmPasswordButton: UIButton!
    @IBOutlet weak var confirmPasswordImage: UIImageView!
    
    var signUpObj = Get_Status()
    var global_Var = GlobalClass.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalize()
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
    
    func initalize(){

        self.navigationController?.navigationBar.isHidden = true
        self.userNameTextFiled.keyboardType = .namePhonePad
        self.emailTextFiled.keyboardType = .emailAddress
        
        self.submitButton.layer.cornerRadius = self.submitButton.frame.height / 2
        
        self.userNameTextFiledBGView.layer.cornerRadius = self.userNameTextFiledBGView.frame.height / 2
        self.emailTextFiledBGView.layer.cornerRadius = self.emailTextFiledBGView.frame.height / 2
        self.passwordTextFiledBGView.layer.cornerRadius = self.passwordTextFiledBGView.frame.height / 2
        self.confPasswordTextFiledBGView.layer.cornerRadius = self.confPasswordTextFiledBGView.frame.height / 2
        
        self.submitButton.layer.cornerRadius = self.submitButton.frame.height / 2
        
        self.userNameTextFiled.delegate = self
        self.emailTextFiled.delegate = self
        self.passwordTextFiled.delegate = self
        self.confPasswordTextFiled.delegate = self
    }
    
    //    MARK: On Click Func
    @IBAction func termsAction(_ sender: UIButton)
    {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        vc.naviTag = 5
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func privacyAction(_ sender: UIButton)
    {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        vc.naviTag = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInAction(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showPasswordAction(_ sender: UIButton)
    {
        if passwordTextFiled.isSecureTextEntry == false
        {
            passwordTextFiled.isSecureTextEntry = true
            showPasswordImage.image = UIImage(named: "hidePassword")
        }
        else
        {
            passwordTextFiled.isSecureTextEntry = false
            showPasswordImage.image = UIImage(named: "showPassword")
        }
    }
    
    @IBAction func confirmPasswordAction(_ sender: UIButton)
    {
        if confPasswordTextFiled.isSecureTextEntry == false
        {
            confPasswordTextFiled.isSecureTextEntry = true
            confirmPasswordImage.image = UIImage(named: "hidePassword")
        }
        else
        {
            confPasswordTextFiled.isSecureTextEntry = false
            confirmPasswordImage.image = UIImage(named: "showPassword")
        }
    }
    
    
    @IBAction func onClickSubmitButton(_ sender: Any) {
        if self.isUserInputValid() {
        signUpApi()
        }
    }

    @IBAction func onClickFBButton(_ sender: Any) {
        LoginManager.init().logIn(permissions: ["public_profile", "email"], viewController: self) { (loginResult) in
            switch loginResult {
            case .success(let granted, let declined, let token):
                let requestedFields = "email, first_name"

                GraphRequest.init(graphPath: "me", parameters: ["fields":requestedFields]).start { (connection, result, error) -> Void in
                    
                    if error == nil {
                        if let resultDict = result as? [String: Any],
                          let email = resultDict["email"] as? String,
                           let firstName = resultDict["first_name"] as? String {
                            self.loginApi(with: email, password: firstName, loginMedia: "2")
                        }
                    }
                }
                print("granted: \(granted), declined: \(declined), token: \(token)")
            case .cancelled:
                print("Login: cancelled.")
            case .failed(let error):
                print("Login with error: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func onClickGoogleButton(_ sender: Any) {
        self.showAlertWithErrorMessage("Cooming Soon")
    }
    
    @IBAction func onClickTermsOfService(_ sender: UIButton) {
          print("terms of Service tapped")
      }
      
      @IBAction func onClickPrivacyPolicy(_ sender: UIButton) {
           print("privacy policy tapped")
      }
    
    
    
    
    @IBAction func onClickNavBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController : UITextFieldDelegate , CustomPopUpViewControllerDelegate {
    
    //    MARK: CustomPopUpViewControllerDelegate
    func onClcikOkButton() {
        let frontVC = UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "SignInNavigationController" )
        revealViewController().setFront( frontVC , animated: true)
    }
    
    // MARK: TextFiled Delegate
    func isUserInputValid() -> Bool {
        
        if userNameTextFiled.text == "" {
            self.userNameTextFiled.errorText = "Please Enter Name."
            self.showWarning(title: "Name", warningMessage: "Please Enter Name")
            self.userNameTextFiled.showError()
            return false
        }
        else if emailTextFiled.text == "" {
            self.emailTextFiled.errorText = "Please Enter Email Address."
            self.showWarning(title: "Email", warningMessage: "Please Enter Email Address.")
            self.emailTextFiled.showError()
            return false
        }
        else if UtilityManager.isValidEmail(emailTextFiled.text!) == false {
            self.userNameTextFiled.errorText = "Please Enter valid Email Address."
            self.showWarning(title: "Invalid Email", warningMessage: "Please Enter valid Email Address.")
            
            self.userNameTextFiled.showError()
            return false
        }
        else if passwordTextFiled.text == "" {
            self.passwordTextFiled.errorText = "Please Enter New Password."
             self.showWarning(title: "New Password", warningMessage: "Please Enter New Password.")
            self.passwordTextFiled.showError()
            return false
        }
        else if confPasswordTextFiled.text == "" {
            self.confPasswordTextFiled.errorText = "Please Re-Enter New Password."
              self.showWarning(title: "New Password", warningMessage: "Please Re-Enter New Password.")
            self.confPasswordTextFiled.showError()
            return false
        }
        else if passwordTextFiled.text != confPasswordTextFiled.text {
            self.passwordTextFiled.errorText = ""
            self.passwordTextFiled.showError()
            
            self.confPasswordTextFiled.errorText = "Password Not Mach"
            self.showWarning(title: "Invalid Password", warningMessage: "Password Not Mach.")
            self.confPasswordTextFiled.showError()
            
            return false
        }
        else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.userNameTextFiled.hideError()
        self.emailTextFiled.hideError()
        self.passwordTextFiled.hideError()
        self.confPasswordTextFiled.hideError()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if( textField == userNameTextFiled) {
            self.userNameTextFiled.resignFirstResponder()
            self.emailTextFiled.becomeFirstResponder()
        } else if textField == emailTextFiled {
            self.emailTextFiled.resignFirstResponder()
            self.passwordTextFiled.becomeFirstResponder()
        } else if textField == passwordTextFiled {
            self.passwordTextFiled.resignFirstResponder()
            self.confPasswordTextFiled.becomeFirstResponder()
        } else if textField == confPasswordTextFiled {
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

extension SignUpViewController
{
    
   func signUpApi()
    {


        let param:[String:String] = ["email":emailTextFiled.text ?? "" , "password": passwordTextFiled.text ?? "" , "name":userNameTextFiled.text ?? ""]

                Loader.sharedInstance.showIndicator()

        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.signUp_Api, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):

                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.signUpObj = try JSONDecoder().decode(Get_Status.self, from: data)
                            
                            self.showCustomPopUp(mesgText: self.signUpObj.message , topImageName: #imageLiteral(resourceName: "like02"), bottomImageName: #imageLiteral(resourceName: "img-2"), customDelegate: self)

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
    
    func loginApi(with email: String, password: String, loginMedia: String){
    
    let param:[String:String] = ["email": email/* userNameTextFiled.text ?? "" */,                            "password": password /* passwordTextFiled.text ?? "" */,
                                 "device_type":"1",
                                 "device_token":"dEDiKUy7R3i2Ph4IkS5bCr:APA91bGFP-wEIA6rf7FzNHJbNe1xgR6hWvP2nBHlGjDbVDT3ZAD6rX0ua-w8gfS7McWwkxqCfWudOQ15TOyzCho0efRfgGFgjUOR7AiTtTlFRVQBUdjj7PrUuiH3Ud1Thol03vBSDmdO",
                                 "app_version": "1",
                                 "login_media": loginMedia /*"1"*/,
                                 "media_token":"abc"]
        
                Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.login_Api, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                                        Loader.sharedInstance.hideIndicator()
                        do {
                            
                            UtilityManager.isLogedIn(value: true)
                            let vc = UIStoryboard.DashboardStoryboard.instantiateViewController(withIdentifier: "TabBarViewController")as! TabBarViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                            
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
