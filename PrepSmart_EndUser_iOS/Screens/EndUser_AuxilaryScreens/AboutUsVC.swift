//
//  AboutUsVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 29/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class AboutUsVC: BaseViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    var appDataObj : AppData_Struct?
    let global_Var = GlobalClass.sharedManager
    
    let abousUsCell = "AbousUsCell"
    
    let abousUsTitle = ["Rate Us on App Store","Prepsmart for chefs","Our Terms & Conditions","Privacy Policy","About App"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
    }
    
    func initializer(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("About Us")
        tableView.register(UINib(nibName: abousUsCell, bundle: .none), forCellReuseIdentifier: abousUsCell)
        getAppDataApi()
    }

    

}

extension AboutUsVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return abousUsTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: abousUsCell, for: indexPath) as! AbousUsCell
        cell.titleLbl.text = abousUsTitle[indexPath.row]
        cell.descLbl.text = "\nAre you a food professional or just happen to have the best recipes on the block? Start earning today!"
        if indexPath.row == 1{
            cell.descLbl.isHidden = false
        }else{
             cell.descLbl.isHidden = true
        }
        
//        if indexPath.row == abousUsTitle.count-1{
//           cell.underlineView.isHidden = true
//        }else{
//             cell.underlineView.isHidden = false
//        }
        print(indexPath.row)
        print(abousUsTitle.count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15.0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 // rate us on app store
        {
            showCustomRaitngPopUp(customDelegate: self)
        }
        else if indexPath.row == 1
        {
            
        }
        else if indexPath.row == 2 // Our Terms & Conditions
        {
            let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
            vc.naviTag = 3
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 3 // Privacy Policy
        {
            let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
            vc.naviTag = 2
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            let vc = UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "HowItWorkViewController") as! HowItWorkViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
}


extension AboutUsVC: RatingsPopUpViewControllerDelegate
{
    func onClcikRemindMeLaterBtn() {
        print("done")
    }
    
}

extension AboutUsVC
{
    func getAppDataApi()
     {

         let param:[String:Any] = ["": ""]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getAppData, params: param , method: .get) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.appDataObj = try JSONDecoder().decode(AppData_Struct.self, from: data)
                             if self.global_Var.contentArr == []
                             {
                                 for i in self.appDataObj?.intro_data ?? []
                                 {
                                     self.global_Var.contentArr.append(i.message ?? "")
                                     print(self.global_Var.contentArr)
                                 }
                             }
                             
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
