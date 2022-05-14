//
//  AppDelegate.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh Kulkarni on 23/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD
import FBSDKCoreKit
import GoogleSignIn
import Stripe

var app_delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navi_obj : UINavigationController?
    var story_obj : UIStoryboard?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //To hide Back button title on navigation controller
        let attributes = [NSAttributedString.Key.font:  UIFont(name: "Helvetica-Bold", size: 0.1)!, NSAttributedString.Key.foregroundColor: UIColor.clear]
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .normal)
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .highlighted)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = mainStoryboard.instantiateViewController(withIdentifier: "RevealViewController") as! RevealViewController

        let navi_gationController = UINavigationController(rootViewController: profileViewController)
        let window = UIApplication.shared.delegate!.window!!
        window.rootViewController = navi_gationController
        // Stripe
        StripeAPI.defaultPublishableKey = Constants.PUBLISHABLE_KEY
        
        // Override point for customization after application launch.
        SetUpIQKeyboardManager()
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = GIDSignIn.sharedInstance.handle(url)
          if handled {
            return true
          }
        return ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
      }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    func SetUpIQKeyboardManager() -> Void {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        SVProgressHUD.setForegroundColor(.orange)
        SVProgressHUD.setRingThickness(6.0)
    }

}

