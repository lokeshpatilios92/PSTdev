//
//  SubscriptionDetailsVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 06/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD165

import UIKit
import FBSDKCoreKit

class SubscriptionDetailsVC: BaseViewController {
    
    @IBOutlet weak var chargesView: UIView!
    @IBOutlet weak var iAcceptBtn: UIButton!
    @IBOutlet weak var secondUnsbscribeBtn: UIButton!
    @IBOutlet weak var costView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var unsubscribeBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var recipeImgView: UIImageView!
    @IBOutlet weak var imageContainerview: UIView!
    @IBOutlet weak var costLabel: UILabel!
    
    var mySubscriptionObj : My_subscriptions?
    var global_Var = GlobalClass.sharedManager
    var updateSubscriptionObj = Get_Status()
    var acceptsUpdatedSubscriptionCostObj = Get_Status()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intializer()
    }
    
    override func viewDidLayoutSubviews() {
        print("called first")
    }
    
    
    func intializer(){
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Subscriptions")
        
        recipeImgView.layer.cornerRadius = recipeImgView.frame.height/2
        imageContainerview.layer.cornerRadius = imageContainerview.frame.height/2
        unsubscribeBtn.layer.cornerRadius = unsubscribeBtn.frame.height/2
        iAcceptBtn.layer.cornerRadius = iAcceptBtn.frame.height/2
        secondUnsbscribeBtn.layer.cornerRadius = secondUnsbscribeBtn.frame.height/2
        secondUnsbscribeBtn.layer.borderWidth = 1
        secondUnsbscribeBtn.layer.borderColor = UIColor.appOrangeColor().cgColor
        drawDottedLineForView(view: costView)
        drawDottedLineForView(view: chargesView)
        loadData()
    }
    
    func loadData()
    {
        recipeImgView.sd_setImage(with: URL(string: self.mySubscriptionObj?.recipe_image_url ?? ""), placeholderImage: UIImage(named: "dinner"))
        titleLbl.text = self.mySubscriptionObj?.recipe_name
        nameLbl.text = "by " + (self.mySubscriptionObj?.recipe_owner_name ?? "")
        costLabel.text = "Cost :$" + String(self.mySubscriptionObj?.cost ?? 0)
        
        
    }
    
    func drawDottedLineForView(view:UIView){
        
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = UIColor.lightGray.cgColor
        yourViewBorder.lineDashPattern = [1, 1]
        yourViewBorder.frame = view.bounds
        yourViewBorder.cornerRadius = 11
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: view.bounds).cgPath
        view.layer.addSublayer(yourViewBorder)
        
    }
    
    
    @IBAction func unsubscribeBtnTapped(_ sender: UIButton) {
        //both unsubscribe btn attached to this action
        if sender == unsubscribeBtn{
            print("first unsubscribed")
            updateSubscriptionApi()
        }
        else if sender == secondUnsbscribeBtn
        {
            print("second unsubscribed")
            updateSubscriptionApi()
        }
        else
        {
            print("I accept")
            acceptsUpdatedSubscriptionCostApi()
        }
        
    }
    
    @IBAction func iAcceptTapped(_ sender: UIButton) {
        
    }
}

extension SubscriptionDetailsVC
{
    func updateSubscriptionApi()
     {

         let param:[String:Any] = ["user_subscribe_id": self.mySubscriptionObj?.id , "flag":"2"]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.updateSubscription, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.updateSubscriptionObj = try JSONDecoder().decode(Get_Status.self, from: data)
                             Alert.showMiddleToast(message: self.updateSubscriptionObj.message, view_VC: self)
                             
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
    
    func acceptsUpdatedSubscriptionCostApi()
     {

         let param:[String:Any] = ["user_subscribed_recipe_plan_id": self.mySubscriptionObj?.id]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.acceptsUpdatedSubscriptionCost, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.acceptsUpdatedSubscriptionCostObj = try JSONDecoder().decode(Get_Status.self, from: data)
                             Alert.showMiddleToast(message: self.acceptsUpdatedSubscriptionCostObj.message, view_VC: self)
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
