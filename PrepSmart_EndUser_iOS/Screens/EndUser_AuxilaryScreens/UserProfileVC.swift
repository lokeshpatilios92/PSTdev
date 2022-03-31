//
//  UserProfileVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 25/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD010

import UIKit
import Popover
import Toaster

class UserProfileVC: BaseViewController {

    
    @IBOutlet weak var popOverBtn: UIButton!
    @IBOutlet weak var accountTxtField: KKNEWTextFiled!
    @IBOutlet weak var zipCodeTxtField: KKNEWTextFiled!
    @IBOutlet weak var emailTxtField: KKNEWTextFiled!
    @IBOutlet weak var nameTxtField: KKNEWTextFiled!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var upgradeBtn: UIButton!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var contanerViewForImageView: UIView!
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    
    var global_Var = GlobalClass.sharedManager
    var isComeFirstTime : Bool?
   var updateProfileObj = Get_Status()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initializer()
    }
    
    func getProfileData()
    {
        let dic = global_Var.logindicObj?.userData
        profilePicImageView.sd_setImage(with: URL(string:dic?.profile_pic ?? "" ), placeholderImage: UIImage(named: "dinner"))
        nameTxtField.text = dic?.name
        emailTxtField.text = dic?.email_id
        zipCodeTxtField.text = String(dic?.zipcode ?? 0)
        accountTxtField.text = dic?.membership_name
        
        
    }
    
    func initializer(){
         self.navigationItem.titleView = UtilityManager.getTitleLabel("MY PROFILE")
       
        contanerViewForImageView.layer.cornerRadius = contanerViewForImageView.frame.height/2
        profilePicImageView.layer.cornerRadius = profilePicImageView.frame.height/2
        editProfileBtn.layer.cornerRadius = 5
        editProfileBtn.layer.borderWidth = 1
        editProfileBtn.layer.borderColor = UIColor.white.cgColor
        upgradeBtn.layer.cornerRadius = upgradeBtn.frame.height/2
        nextBtn.layer.cornerRadius = nextBtn.frame.height/23
        getProfileData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
       
    }
    
    @IBAction func imagePicker(_ sender: UIButton)
    {
        ImageAction.instance.cropFigureType = 1
        ImageAction.instance.cornerRadiousType = 0
        
        ImageAction.instance.showFullActionSheet(on: self){ (image) in
            self.profilePicImageView.image = image ?? UIImage()
            
            sender.setImage(UIImage(), for: .normal)
            
        }
    }
    
    @IBAction func popOverTapped(_ sender: UIButton) {
        print(sender.tag)
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: aView.frame.width - 40, height: 300))
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.font = UIFont.REGULAR_FONT_SMALLEST()
        infoLabel.textColor = .textColor()
        infoLabel.text = "Which ZIP code do you usually shop in ?"
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
        popover.show(aView, fromView: popOverBtn)
        
    }
    
    
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        
        if nameTxtField.text == ""
        {
            
        }
        else if zipCodeTxtField.text == ""
        {
            
        }
        else
        {
            update_Data()
        }
        
        
    }
    
    @IBAction func upgradeBtnTapped(_ sender: UIButton) {

        let vc = UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "MembershipLevelViewController") as! MembershipLevelViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension UserProfileVC
{
    
    func update_Data()
    {
        let param:[String:String] = [
            "name":self.nameTxtField.text ?? "",
            "zipcode":zipCodeTxtField.text ?? ""
        ]
        
        guard let var_img = self.profilePicImageView.image else
        {
            Alert.showMiddleToast(message: Alert.imageMsg, view_VC: self)
            return
        }
       
                Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireMultiFromAPICall(methodName: Constants.updateProfile, params: param, method: .post, img_pram: ["profile_pic"], imageUpload_Arr: [var_img], media_pram: nil, video_url_Up_Arr: nil) { ( data, error) in
            
            if error == nil
            {
                if data != nil
                {
                    do {
                        self.updateProfileObj = try JSONDecoder().decode(Get_Status.self, from: data!)
                        Alert.showMiddleToast(message: self.updateProfileObj.message ?? "", view_VC: self)
                        self.navigationController?.popViewController(animated: true)
//                        let vc =  UIStoryboard.DashboardStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//                        self.revealViewController()?.setFront(vc, animated: true)
                    }
                    catch
                    {
                        Toast.init(text: error.localizedDescription).show()
                                        Loader.sharedInstance.hideIndicator()
                    }
                }
                else
                {
                    Toast.init(text: self.global_Var.get_status.message).show()
                                    Loader.sharedInstance.hideIndicator()
                }
            }
            else
            {
                Toast.init(text: self.global_Var.get_status.message).show()
                                Loader.sharedInstance.hideIndicator()
            }
                            Loader.sharedInstance.hideIndicator()
        }
    }
}
