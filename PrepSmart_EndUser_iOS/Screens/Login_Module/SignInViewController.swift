//
//  SignInViewController.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 24/05/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
// Screen Id : PSTMOBSTD002

import UIKit
import FBSDKLoginKit

class SignInViewController: BaseViewController {
    @IBOutlet weak var scrollView : UIScrollView!
    
    @IBOutlet weak var userNameTextFiledBGView: UIView!
    @IBOutlet weak var passwordTextFiledBGView: UIView!
    
    @IBOutlet weak var userNameTextFiled: KKNEWTextFiled!
    @IBOutlet weak var passwordTextFiled: KKNEWTextFiled!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var showPasswordImage: UIImageView!
    
    var loginObj: UserLogin_Struct?
    var global_Var = GlobalClass.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalize()
        /*
//        userNameTextFiled.text = "sumit@samyotech.com"
//        passwordTextFiled.text = "12345678"
        userNameTextFiled.text = "dev11@yopmail.com"
        passwordTextFiled.text = "12345678"
//        userNameTextFiled.text = "arv@yopmail.com"
//        passwordTextFiled.text = "12345678"
        userNameTextFiled.text = "sumitgade31@gmail.com"
        passwordTextFiled.text = "12345678"
        userNameTextFiled.text = "testpst@yopmail.com"
        passwordTextFiled.text = "12345678"*/
        userNameTextFiled.text = "ankit2222@yopmail.com"
        passwordTextFiled.text = "Ankit@12"
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
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
        
        self.signInButton.layer.cornerRadius = self.signInButton.frame.height / 2
        
        self.signUpButton.layer.cornerRadius = self.signUpButton.frame.height / 2
        self.signUpButton.layer.borderWidth = 1
        self.signUpButton.layer.borderColor = UIColor.white.cgColor
        
        self.userNameTextFiledBGView.layer.cornerRadius = self.userNameTextFiledBGView.frame.height / 2
        self.passwordTextFiledBGView.layer.cornerRadius = self.passwordTextFiledBGView.frame.height / 2
        
        self.userNameTextFiled.delegate = self
        self.passwordTextFiled.delegate = self
    }
    
    //    MARK: On Click Func
    
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
    
    @IBAction func onClickSignInButton(_ sender: Any) {
        if self.isUserInputValid() {
            loginApi(with: userNameTextFiled.text ?? "", password: passwordTextFiled.text ?? "", loginMedia: "1")
        }
    }
    
    @IBAction func onClickSignUpButton(_ sender: Any) {
        let vc = UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        //        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickForgotPasswordButton(_ sender: Any) {
        let vc = UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickPrivacyPolicy(_ sender: UIButton) {
         print("privacy policy tapped")
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func paymentAction(_ sender: UIButton)
    {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        vc.naviTag = 4
        self.navigationController?.pushViewController(vc, animated: true)
    }
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
    
    
}

extension SignInViewController : UITextFieldDelegate {
    
    // MARK: TextFiled Delegate
    func isUserInputValid() -> Bool {
//        var errorMessage:NSString = ""
        
        if userNameTextFiled.text == "" {
            self.userNameTextFiled.errorText = "Please Enter Email Address."
            self.showWarning(title: "Email", warningMessage: "Please Enter Email.")
            self.userNameTextFiled.showError()
            return false
        }
        else if UtilityManager.isValidEmail(userNameTextFiled.text!) == false {
            self.userNameTextFiled.errorText = "Please Enter valid Email Address."
             self.showWarning(title: "Invalid Email", warningMessage: "Please Enter valid Email Address.")
//            errorMessage = "Please Enter valid Email Address."
            self.userNameTextFiled.showError()
            return false
        }
        else if( passwordTextFiled.text == "" ) {
            self.passwordTextFiled.errorText = "Please Enter Password."
              self.showWarning(title: "Password", warningMessage: "Please Enter Password.")
            
            self.passwordTextFiled.showError()
//            errorMessage = "Please Enter Password."
            
            return false
        }
//        if (errorMessage != "") {
//            let alert = KKAlertController(title: "", message:errorMessage as String, preferredStyle: UIAlertController.Style.alert)
//            let okAction = UIAlertAction(title: "OK",
//                                         style: .default) { (action: UIAlertAction) -> Void in
//
//            }
//            alert.addAction(okAction)
//            self.present(alert, animated: true, completion: nil)
//
//            return false
//        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.userNameTextFiled.hideError()
        self.passwordTextFiled.hideError()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if( textField == userNameTextFiled) {
            self.userNameTextFiled.resignFirstResponder()
            self.passwordTextFiled.becomeFirstResponder()
        } else if textField == passwordTextFiled {
            self.passwordTextFiled.resignFirstResponder()
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

extension SignInViewController
{
    
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
                            self.loginObj = try JSONDecoder().decode(UserLogin_Struct.self, from: data)
                            self.global_Var.logindicObj = self.loginObj
                            Api_Http_Class.shareinstance.save_Data_NsUser_Default(vc: self, dic_Data: try (self.global_Var.logindicObj).asDictionary() as NSDictionary)
                            
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
