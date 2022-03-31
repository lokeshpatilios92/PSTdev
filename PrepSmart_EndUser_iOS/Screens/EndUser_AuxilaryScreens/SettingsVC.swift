//
//  SettingsVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 06/12/21.
//  Copyright © 2021 Exceptionaire.co. All rights reserved.
//

import UIKit

class SettingsVC: BaseViewController, CustomResetSettingsPopUpDelegate{
    
    func onClcikProceedButton() {
        self.resetSettingsApi()
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    var getSettingsObj : SettingsStruct?
    var resetSettingsObj = Get_Status()
    var global_Var = GlobalClass.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
        
    }
    func initializer(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Settings")
        tableView.register(UINib(nibName: "SettingsCell", bundle: .none), forCellReuseIdentifier: "SettingsCell")
        self.getsettingsApi()
    }

    @IBAction func resetButtonClicked(_ sender: UIButton)
    {
        showCustomResetSettingsPopUp(customDelegate: self)
        
    }

}


extension SettingsVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getSettingsObj?.user_setting?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        let dic = self.getSettingsObj?.user_setting?[indexPath.row]
        
        cell.titleLbl.text = dic?.name
        cell.descLbl.text = dic?.desc
        
        
        return cell
        
    }
}

extension SettingsVC
{
    
   func getsettingsApi()
    {

        let param:[String:String] = ["": ""]

                Loader.sharedInstance.showIndicator()

        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getSettings, params: param , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):

                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.getSettingsObj = try JSONDecoder().decode(SettingsStruct.self, from: data)
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
    
    func resetSettingsApi()
     {

         let param:[String:String] = ["":""]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.resetSettings, params: param , method: .get) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.resetSettingsObj = try JSONDecoder().decode(Get_Status.self, from: data)
                             Alert.showMiddleToast(message: self.resetSettingsObj.message , view_VC: self)
                             self.getsettingsApi()
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
