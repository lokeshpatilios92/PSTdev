//
//  SubscriptionViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 08/11/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD164

import UIKit

class SubscriptionViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarView: UIView!
    
    let subscriptionsTableCell = "SubscriptionsTableCell"
    var mySubscriptionObj : MySubscription_Struct?
    var global_Var = GlobalClass.sharedManager
    var subscriptionTag = 0
    var updateSubscriptionObj = Get_Status()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialization()
    }
    
    func initialization() {
         self.navigationItem.titleView = UtilityManager.getTitleLabel("Subscriptions")
        
         searchBar.barTintColor = UIColor.clear
         searchBar.backgroundColor = .white
         searchBar.isTranslucent = true
         searchBar.layer.borderColor = UIColor.lightGray.cgColor
         searchBarView.layer.borderWidth = 0.50
         searchBarView.layer.cornerRadius = searchBarView.frame.height / 2
         searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
         searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: UISearchBar.Icon.search, state: .normal)
        
        tableView.register(UINib(nibName: subscriptionsTableCell, bundle: .none), forCellReuseIdentifier: subscriptionsTableCell)
        tableView.delegate = self
        tableView.dataSource = self
        mySubscriptionApi()
    }
    
    @objc func planInfoClicked(sender: UIButton){
        let dic = self.mySubscriptionObj?.my_subscriptions?[sender.tag]
        
        if dic?.type == 2
        {
            let vc = UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "MembershipLevelViewController") as! MembershipLevelViewController
            self.navigationController?.pushViewController(vc, animated: false)
            
        }
        else
        {
           
            self.subscriptionTag = sender.tag
            showOneLabelAndTwoButtonPopUp(setTitleText: "Are you sure you want to unsubscribe?.You wioo loose access to those recipes and they will be no longer accesible from weekly plan Templates and Recipes Packs they are a part of.", isHiddenLeftButton: false, setRightButtonTitle: "Confirm", setLeftButtonTitle: "Cancel", customDelegate:self)
        }
        
        
    }
    
    
}

extension SubscriptionViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mySubscriptionObj?.my_subscriptions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: subscriptionsTableCell, for: indexPath) as! SubscriptionsTableCell
        let dic = self.mySubscriptionObj?.my_subscriptions?[indexPath.row]
        
        cell.img_Profile.sd_setImage(with: URL(string: dic?.recipe_image_url ?? ""), placeholderImage: UIImage(named: "dinner"))
        cell.lbl_Title.text = dic?.recipe_name
        cell.lbl_SubTitle.text = "by " + (dic?.chef_name ?? "")
        cell.lbl_Cost.text = "Cost :$" + String(dic?.cost ?? 0)
        
        if dic?.type == 2
        {
            cell.btn_PlanInfo.setTitle("Plan Info", for: .normal)
        }
        else
        {
            cell.btn_PlanInfo.setTitle("Unsubscribe", for: .normal)
        }
        cell.btn_PlanInfo.tag = indexPath.row
        cell.btn_PlanInfo.addTarget(self, action: #selector(planInfoClicked(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dic = self.mySubscriptionObj?.my_subscriptions?[indexPath.row]
        if dic?.type == 2
        {
            
        }
        else
        {
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "SubscriptionDetailsVC") as! SubscriptionDetailsVC
            vc.mySubscriptionObj = self.mySubscriptionObj?.my_subscriptions?[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
 
}

extension SubscriptionViewController : CustomOneLabelAndTwoButtonPopUpDelegate{
    
    func onClickRightButton() {
        print("Right Button Clicked id = \(subscriptionTag)")
        let id = self.mySubscriptionObj?.my_subscriptions?[subscriptionTag].id
        self.updateSubscriptionApi(id: id)
        //showAlertWithOkButtonPopUpVC(setTitle: "Unsubscription Successful. You will not be charged for this subscription in the next billing cycle.", setMessage: "", setButtonTitle: "Ok", customDelegate: nil)
    }
    
    
}

extension SubscriptionViewController
{
    func mySubscriptionApi()
     {

         let param:[String:String] = ["": ""]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getMySubscriptions, params: param , method: .get) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.mySubscriptionObj = try JSONDecoder().decode(MySubscription_Struct.self, from: data)
                             self.tableView.reloadData()
                             
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
    
    func updateSubscriptionApi(id: Int?)
     {

         let param:[String:Any] = ["user_subscribe_id": id ?? 0 , "flag":"2"]

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
}
