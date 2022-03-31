//
//  RevealViewController.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 24/05/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class RevealViewController: SWRevealViewController {
    
    var global_Var = GlobalClass.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        //auto_Login()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func auto_Login()
    {
        
       Api_Http_Class.shareinstance.get_Data_NsUser_Default(vc: self,completion : { (success) -> Void in

           
        
            if success
            {
              
               // let story = UIStoryboard(name: UIStoryboard.DashboardStoryboard, bundle: nil)
                let homeVC = UIStoryboard.DashboardStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                self.setFront( homeVC , animated: true)
                
            }
            else
            {
                let frontVC = UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "SignInNavigationController" )
                self.setFront( frontVC , animated: true)
            }
        })
    }
    
    func initialize() {
        
      logInData()
        
        if( UtilityManager.isLogedIn() == true ) {
            let frontVC = UIStoryboard.DashboardStoryboard.instantiateViewController(withIdentifier: "TabBarViewController" ) as! TabBarViewController
            self.setFront( frontVC , animated: true)
        }
        else {
            let frontVC = UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "SignInNavigationController" )
            self.setFront( frontVC , animated: true)
        }
    }
    
    func logInData()
    {
        if  let outData = UserDefaults.standard.data(forKey: "PrepSmart")
        {

            do {
                if  let dic = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(outData)
                {
                    let dic_Code : NSDictionary = dic as! NSDictionary

                    do
                    {
                        let dic = try JSONDecoder().decode(UserLogin_Struct.self, from: dic_Code.dict2json())

                        self.global_Var.logindicObj = dic

                        //Alert.showMiddleToast(message:   GlobalClass.sharedManager.get_status.message, view_VC: vc)

                    }
                    catch
                    {
                       /*
                        let alert = UIAlertController(title: Alert().message, message: Alert().try_again, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: StringConstants().ok, style: .default, handler: { (action) in
                            completion(false)

                        }))

                        vc.present(alert, animated: true, completion: nil)*/
                        Alert.show(vc: app_delegate.navi_obj ?? UIViewController(), titleStr: Alert.msg, messageStr: error.localizedDescription)
                        print(error.localizedDescription)
                    }

                }
                else
                {
                   
                }
            } catch {
                //handle error
                print(error)
            }
        }
    }
}
