//
//  SplashVc.swift
//  FannanArtist
//
//  Created by mac on 13/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class SplashVc: UIViewController {
    
   
    //MARK:- Outlets
   
   
   

    override func viewDidLoad() {
        super.viewDidLoad()
        //crash_Check()
        app_delegate.story_obj    = self.storyboard
        app_delegate.navi_obj = self.navigationController
    
       
        self.auto_Login()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    
    func auto_Login()
    {
        
       Api_Http_Class.shareinstance.get_Data_NsUser_Default(vc: self,completion : { (success) -> Void in
            if success
            {
               // let story = UIStoryboard(name: UIStoryboard.DashboardStoryboard, bundle: nil)
                let homeVC = UIStoryboard.DashboardStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                    self.navigationController?.pushViewController(homeVC, animated: false)
            }
            else
            {
                                Loader.sharedInstance.hideIndicator()
            }
        })
    }
}


/*
extension SplashVc:updateRoleDelegate
{
    func upadteRole(Role: String, media_Type: Int) {
        if loginType == 0
        {
            let signUp = SignUpVC.viewController()
            signUp.roleSelected = Role
            self.navigationController?.pushViewController(signUp, animated: false)
        } else {
            let logVC = LoginViewController.viewController()
            logVC.roleSelected = Role
            self.navigationController?.pushViewController(logVC, animated: false)
        }
    }
}


extension SplashVc
{
    func chat_ViewCont()
    {
      let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self,selector:#selector(self.chatOpenViewCont(notification:)),
                                       name: .openChat,
                                       object: nil)
    
        
        notificationCenter.addObserver(self,selector:#selector(self.chatOpenViewCont(notification:)),
                                       name: .openOther,
                                       object: nil)
    }
    
    @objc func chatOpenViewCont(notification: Notification)
    {
        if let userInfo = notification.userInfo as NSDictionary?
        {
             if let data = userInfo["data"] as? NSDictionary
             {
                     if let type = data["type"] as? String
                     {
                         if type == "10007"
                         {
                            if let role = self.global_var.logindicObj.data?.role, role == 1
                            {
                                app_delegate.story_obj = UIStoryboard(name: "ArtistMain", bundle: nil)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    
                                let rootVC = app_delegate.story_obj?.instantiateViewController(withIdentifier: "ArtistTabBarController") as! ArtistTabBarController
                                    
                                rootVC.indexSelect = 104
                                self.navigationController?.pushViewController(rootVC, animated: true)
                                }
                            }
                            else
                            {
                                app_delegate.story_obj = UIStoryboard(name: "CustomerMain", bundle: nil)
                                
                               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                let rootVC = app_delegate.story_obj?.instantiateViewController(withIdentifier: "CustomerTabBarController") as! CustomerTabBarController
                                  rootVC.indexSelect = 104
                                   self.navigationController?.pushViewController(rootVC, animated: true)
                               }
                            }
                        }
                        else
                         {
                            if let role = self.global_var.logindicObj.data?.role as? Int, role == 1
                            {
                                app_delegate.story_obj = UIStoryboard(name: "ArtistMain", bundle: nil)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    let rootVC = app_delegate.story_obj?.instantiateViewController(withIdentifier: "Artist_NotificationsVC") as! Artist_NotificationsVC
                                    self.navigationController?.pushViewController(rootVC, animated: true)
                                }
                            }
                            else
                            {
                               app_delegate.story_obj = UIStoryboard(name: "CustomerMain", bundle: nil)
                                
                               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                let rootVC = app_delegate.story_obj?.instantiateViewController(withIdentifier: "CustomerNotificationsVC") as! CustomerNotificationsVC
                                   self.navigationController?.pushViewController(rootVC, animated: true)
                               }
                            }
                         }
                  }
               }
          }
      }
 }

extension SplashVc
{
    func notifyMathod()
    {
        if  let userInfo = notificationCenter?.notification.request.content.userInfo {
            
            if let data = userInfo["data"] as? NSDictionary
            {
                if let type = data["type"] as? String
                {
                    if type == "10007"
                    {
                        NotificationCenter.default.post(name: .openChat, object: nil, userInfo: userInfo)
                    }
                    else
                    {
                        NotificationCenter.default.post(name: .openOther, object: nil, userInfo: userInfo)
                    }
                }
            }
        }
    }
}

extension SplashVc:updateLoactionDelegate
{
    func updateLoacationMathod(locationClass: LocationManager)
    {
        self.crl = locationClass.currentLocation
        if (self.crl?.coordinate != nil)
        {
            GlobalClass.lat_str = String(crl?.coordinate.latitude ?? 0.0)
            GlobalClass.long_str = String(crl?.coordinate.longitude ?? 0.0)
         }
     }
}

*/
