//
//  MyProfileVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 20/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID:- PSTMOBSTD0152

import UIKit
import Popover
import SDWebImage

class MyProfileVC: BaseViewController,CustomPopUpChangePasswordDelegate,OneImageOneLabelAndOneButtonVCDelegate {
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topDataStackView: UIStackView!
    @IBOutlet weak var recipeBackView: UIView!
    @IBOutlet weak var recipeBorderLabel: UILabel!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var followingBackView: UIView!
    @IBOutlet weak var followingBordorLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var achivementBackView: UIView!
    @IBOutlet weak var achivementImage: UIImageView!
    @IBOutlet weak var topButtonStackView: UIStackView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: KKNEWTextFiled!
    @IBOutlet weak var zipCodeView: UIView!
    @IBOutlet weak var zipCodeTextField: KKNEWTextFiled!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var zipCodePopOverButton: UIButton!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var accountTextField: KKNEWTextFiled!
    @IBOutlet weak var upgradeButton: UIButton!
    @IBOutlet weak var dietTypeBackView: UIView!
    @IBOutlet weak var dietTypeLabel: UILabel!
    @IBOutlet weak var dietTypeRightImage: UIImageView!
    @IBOutlet weak var dietTypeButton: UIButton!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var changePasswordLabel: UILabel!
    @IBOutlet weak var changePasswordRightImage: UIImageView!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    var getProfileObj : Profile_Struct?
    
    var global_Var = GlobalClass.sharedManager
 
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        initialization()
        myProfileApi()
    }
    
    func initialization() {
        
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("MY PROFILE")
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        leftButton.layer.cornerRadius = 3//leftButton.frame.height/2
        rightButton.layer.cornerRadius = 3//rightButton.frame.height/2
        rightButton.layer.borderWidth = 1
        rightButton.layer.borderColor = UIColor.black.cgColor
        upgradeButton.layer.cornerRadius = upgradeButton.frame.height/2
        
        dietTypeBackView.layer.cornerRadius = 5
        changePasswordView.layer.cornerRadius = 5
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    func getProfileData()
    {
        let dic = self.getProfileObj?.userData
        profileImage.sd_setImage(with: URL(string:dic?.profile_pic ?? "" ), placeholderImage: UIImage(named: "dinner"))
        nameLabel.text = dic?.name
        emailLabel.text = dic?.email_id
        zipCodeLabel.text = String(dic?.zipcode ?? 0)
        accountLabel.text = dic?.membership_name
        recipeLabel.text = String(dic?.total_recipe ?? 0)
        followingLabel.text = String(dic?.following ?? 0)
        
    }
    
    
    @IBAction func upgradeButtonAction(_ sender: UIButton) {
    }
    
    
    @IBAction func zipCodePopOverButtonAction(_ sender: UIButton) {
        
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: aView.frame.width - 40, height: 300))
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.font = UIFont.REGULAR_FONT_SMALLEST()
        infoLabel.textColor = .textColor()
        infoLabel.text = "In order to complete this transaction, please ask the user to update this status to 'Complete' at conclusion of your call"
        infoLabel.sizeToFit()
        infoLabel.frame = CGRect(x: infoLabel.frame.origin.x, y: infoLabel.frame.origin.y, width: infoLabel.frame.width, height: infoLabel.frame.height)
        
        let y = infoLabel.frame.height
        
        aView.addSubview(infoLabel)
        aView.frame = CGRect(x: aView.frame.origin.x, y: aView.frame.origin.y, width: aView.frame.width, height: y + 20)
        
        let popoverOptions: [PopoverOption] = [
            .type(.auto),
            .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
        ]
        
        let popover = Popover(options: popoverOptions)
        popover.show(aView, fromView: zipCodePopOverButton)
        
    }
  
    @IBAction func topButtonAction(_ sender: UIButton) {
    
        if sender == rightButton
        {
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileVC
            self.navigationController?.pushViewController(vc, animated: false) //= vc
        }
        else
        {
            
        }
    }
    
    @IBAction func bottomButtonAction(_ sender: UIButton) {
        
        if sender == dietTypeButton{
            
            
        }else{
            self.showCustomChangePasswordPopUp(customDelegate: self)
        }
        
    }
    
    @IBAction func dietTypeButtonAction(_ sender: UIButton)
    {
        let story = UIStoryboard(name: "Auxiliary_Module_Storyboard", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "DietTypeViewController")as! DietTypeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //Mark :- Delegate Func
    func onClcikSaveButton(message: String?) {
        
        self.OneImageOneLabelAndOneButtonPopUp(lbl_text: message, bottomButton: "OK", topImage: #imageLiteral(resourceName: "smile"), customDelegate: self)
    }
    
    //MARK:- OneLabelAndOneButtonAndOneImage Delegate
    func onClickOkButton() {
        self.removeAnimation()
      }
    
}

extension MyProfileVC
{
   func myProfileApi()
    {
        
        
        let param:[String:String] = ["":""]
        
                Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.profile, params: param , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.getProfileObj = try JSONDecoder().decode(Profile_Struct.self, from: data)
                            
                            Api_Http_Class.shareinstance.save_Data_NsUser_Default(vc: self, dic_Data: try (self.global_Var.logindicObj).asDictionary() as NSDictionary)
                            self.getProfileData()
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
