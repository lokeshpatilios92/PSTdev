//
//  SettingsVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 06/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD021

import UIKit

class NotificationSettingsVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var getNotificationObj: NotificationSettings_Struct?
    var updateNotificationObj = Get_Status()
    var global_Var = GlobalClass.sharedManager
    //@IBOutlet weak var resetSettingBtn: UIButton!
    
 
    let advanceModeSettingsCell = "AdvanceModeSettingsCell"

    let settingTitle = ["New Blogs from Chefs I'm Following","New Recipe from chefs I'm Followoing","Setup Weekly Plan Reminders","Best Recipes of the Month","Last Login Reminders","Payment Notifications"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
    }
    
    func initializer(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Settings")
        tableView.register(UINib(nibName: advanceModeSettingsCell, bundle: .none), forCellReuseIdentifier: advanceModeSettingsCell)
        getNotificationApi()
    }
    
   
}

extension NotificationSettingsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getNotificationObj?.user_data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: advanceModeSettingsCell, for: indexPath) as! AdvanceModeSettingsCell
        let dic = self.getNotificationObj?.user_data?[indexPath.row]
        
        cell.titleLbl.text = dic?.notification_type_name
        if dic?.status == 1
        {
            cell.switchSetting.isOn = true
        }
        else
        {
            cell.switchSetting.isOn = false
        }
        
        cell.switchSetting.tag = indexPath.row // for detect which row switch Changed
        cell.switchSetting.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        
        return cell
        
    }

    @objc func switchChanged(_ sender : UISwitch!){

        let dic = self.getNotificationObj?.user_data?[sender.tag]
        if dic?.status == 1
        {
            self.updateNotificationApi(settingId: String(dic?.setting_id ?? 0), status: "2")
        }
        else
        {
            self.updateNotificationApi(settingId: String(dic?.setting_id ?? 0), status: "1")
        }
        
    }

}

extension NotificationSettingsVC
{
    
   func getNotificationApi()
    {

        let param:[String:String] = ["": ""]

                Loader.sharedInstance.showIndicator()

        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getNotificationSetting, params: param , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):

                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.getNotificationObj = try JSONDecoder().decode(NotificationSettings_Struct.self, from: data)
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
    
    func updateNotificationApi(settingId: String?, status: String?)
     {

         let param:[String:String] = ["setting_id": settingId ?? "", "status": status ?? ""]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.updateNotificationSettings, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.updateNotificationObj = try JSONDecoder().decode(Get_Status.self, from: data)
                             self.getNotificationApi()
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
