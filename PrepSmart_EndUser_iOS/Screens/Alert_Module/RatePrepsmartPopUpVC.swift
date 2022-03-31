//
//  RatePrepsmartPopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 29/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD163

import UIKit
import Cosmos

protocol RatingsPopUpViewControllerDelegate {
    func onClcikRemindMeLaterBtn()
}



class RatePrepsmartPopUpVC: UIViewController {
    @IBOutlet weak var raingView: CosmosView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var remindMeLaterbtn: UIButton!
    @IBOutlet weak var noThanksBtn: UIButton!
    @IBOutlet weak var contactUsBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var viewForStackview: UIView!
    
    
    
    var appRatingsObj: AppRating_Struct?
    var global_Var = GlobalClass.sharedManager
    var rating : Double?
    var customDelegate : RatingsPopUpViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializer()
    }
    
    func initializer(){
        
        raingView.didTouchCosmos = didTouchCosmos
        raingView.didFinishTouchingCosmos = didFinishTouchingCosmos
        
        self.backView.layer.cornerRadius = 10
        self.remindMeLaterbtn.layer.borderWidth = 0.5
        self.remindMeLaterbtn.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.noThanksBtn.layer.borderWidth = 0.5
        self.noThanksBtn.layer.borderColor = UIColor.lightGray.cgColor
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        contactUsBtn.setTextUnderline(UIColor.appOrangeColor(), string: contactUsBtn.currentTitle!)
        contactUsBtn.setTextColor(UIColor.appOrangeColor(), string: contactUsBtn.currentTitle!)
        DispatchQueue.main.async {
            self.roundCorners(cornerRadius: 10, view1: self.viewForStackview)
        }
       self.showAnimation()
    }
  
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        self.rating = rating
        print(self.rating)
        appRatingsApi(rating: rating)
        print(rating)
     }
    
    
    private func didTouchCosmos(_ rating: Double) {
        
     }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
         self.removeAnimation()
    }
    
    @IBAction func remindMeLaterTapped(_ sender: UIButton) {
        if customDelegate != nil {
            self.customDelegate.onClcikRemindMeLaterBtn()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    
    @IBAction func noThanksTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    

    func roundCorners(cornerRadius: Double,view1:UIView) {
        let path = UIBezierPath(roundedRect: view1.bounds, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view1.bounds
        maskLayer.path = path.cgPath
        view1.layer.mask = maskLayer
    }
}

extension RatePrepsmartPopUpVC
{
    func appRatingsApi(rating: Double?)
     {

         let param:[String:Any] = ["rate_star":  rating ?? 0.0]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.appRatings, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.appRatingsObj = try JSONDecoder().decode(AppRating_Struct.self, from: data)
                             Alert.showH(titleStr: "", messageStr: self.appRatingsObj?.message ?? "")
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
