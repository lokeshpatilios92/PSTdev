//
//  PrivacyPolicyViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sumit Gade on 20/01/22.
//  Copyright © 2022 Exceptionaire.co. All rights reserved.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: BaseViewController {

    @IBOutlet weak var webView: WKWebView!
    var naviTag = 0
    
    var getContentsObj: PrivacyPolicy_Struct?
    var global_Var = GlobalClass.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        getContentsApi()
    }
    
    func getData()
    {
        if naviTag == 2 // Privacy Policy
        {
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Privacy Policy")
            webView.loadHTMLString(self.getContentsObj?.content?[1].content_data ?? "", baseURL: nil)
        }
        else if naviTag == 3 // Terms & condition
        {
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Terms & Conditions")
            webView.loadHTMLString(self.getContentsObj?.content?[0].content_data ?? "", baseURL: nil)
        }
        else if naviTag == 4 // Terms of services Payments
        {
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Payments Terms of Service")
            webView.loadHTMLString(self.getContentsObj?.content?[3].content_data ?? "", baseURL: nil)
        }
        else // Terms of services
        {
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Terms of service")
            webView.loadHTMLString(self.getContentsObj?.content?[2].content_data ?? "", baseURL: nil)
        }
       
    }
 
}

extension PrivacyPolicyViewController
{
    func getContentsApi()
     {

         let param:[String:String] = ["":  ""]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getContents, params: param , method: .get) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.getContentsObj = try JSONDecoder().decode(PrivacyPolicy_Struct.self, from: data)
                             self.getData()
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
