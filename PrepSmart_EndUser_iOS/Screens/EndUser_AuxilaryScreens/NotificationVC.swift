//
//  NotificationVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 09/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD0150, PSTMOBSTD137

import UIKit

class NotificationVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let notificationCell = "NotificationCell"
    var notificationObj: Notification_Struct?
    var global_Var = GlobalClass.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()

       initializer()
    }
    
    func initializer(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Notifications")
        tableView.register(UINib(nibName: notificationCell, bundle: .none), forCellReuseIdentifier: notificationCell)
        self.navigationItem.rightBarButtonItem = addSettingNavButton()
        getNotificationApi()
    }

}

extension NotificationVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notificationObj?.notification_list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: notificationCell, for: indexPath) as! NotificationCell
        
        let dic = self.notificationObj?.notification_list?[indexPath.row]
        cell.titleLbl.text = dic?.title
        cell.dateAndTimeLbl.text = convertDateFormater(date: dic?.datetime ?? "")
        return cell
    }
    
    
}

extension NotificationVC
{
    func getNotificationApi()
     {

         let param:[String:String] = ["": ""]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getNotifications, params: param , method: .get) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.notificationObj = try JSONDecoder().decode(Notification_Struct.self, from: data)
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
}
