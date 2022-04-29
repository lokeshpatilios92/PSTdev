//
//  ParentHomeScreenVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 26/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen id : PSTMOBSTD017

import UIKit
import XLPagerTabStrip

class ParentHomeScreenVC : ButtonBarPagerTabStripViewController, UnsubscribeRecipePopUpVCDelegate {
    
    override func viewDidLoad() {
        
        self.settings.style.selectedBarHeight = 0.0
        self.settings.style.selectedBarBackgroundColor = UIColor.clear
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back_screen")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back_screen")
        
        self.navigationController?.navigationBar.tintColor          = .white//UIColor.appBlueColor()
        self.navigationController?.view.backgroundColor             = .clear
        self.navigationController?.navigationBar.shadowImage        = UIImage()
        self.navigationController?.navigationBar.backgroundColor    = .clear//UIColor.groupTableViewBackground
        self.navigationController?.navigationBar.isTranslucent      = true
        self.navigationItem.backBarButtonItem                       = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Home")
        //
        NotificationCenter.default.addObserver(self, selector: #selector(self.navigateToDesiredVC), name: NSNotification.Name(rawValue: "TabBarNotification"), object: nil)
        
        let bgImage : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UtilityManager.getWidth(), height: UtilityManager.getHeight()))
        bgImage.image = UIImage(named: "base_Screen")
        self.view.addSubview(bgImage)
        self.view.sendSubviewToBack(bgImage)
        self.navigationItem.rightBarButtonItem = addNotifNavButton()
        self.navigationItem.leftBarButtonItem = addMaskNavButton()
        
        
        
        
        configureButtonBar()
    }
    
    
    func addNewRecipeNavButton() -> UIBarButtonItem {
        let addNewRecipeNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "add_recipe"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addNewRecipeNavButton.tag = 1
        return addNewRecipeNavButton
    }
    
    func addMaskNavButton() -> UIBarButtonItem {
        let addNewRecipeNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "profiel"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addNewRecipeNavButton.tag = 2
        return addNewRecipeNavButton
    }
    
    func addNotifNavButton() -> UIBarButtonItem {
        let addNewRecipeNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "notification"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addNewRecipeNavButton.tag = 3
        return addNewRecipeNavButton
    }
    
    @objc func onClickNavigationBarButton(sender:UIBarButtonItem) {
        
        if sender.tag == 2{
//            let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AddNewViewController") as! AddNewViewController
//            self.navigationController?.pushViewController(vc, animated: true)
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
             self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 3{
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
    }
    
    // MARK: On Click Push Notification
    @objc func navigateToDesiredVC(){
        
        //        let notificationName : Int? = Int(Notification_Name)
        //        if previous_Notification_Name != Notification_Name {
        //        previous_Notification_Name = Notification_Name
        
        switch Notification_Name {
            
        case 0:
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
            self.navigationController?.pushViewController(vc, animated: false) //= vc
            break
            
        case 1:
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "SubscriptionViewController") as! SubscriptionViewController
            self.navigationController?.pushViewController(vc, animated: false)
            break
        case 2:
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "TransactionVC") as! TransactionVC
            self.navigationController?.pushViewController(vc, animated: false)
            break
        case 3:
            let vc = UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "MembershipLevelViewController") as! MembershipLevelViewController
            self.navigationController?.pushViewController(vc, animated: false)
            break
        case 4:
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
            
            self.navigationController?.pushViewController(vc, animated: false)
            break
        case 5:
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
            self.navigationController?.pushViewController(vc, animated: false)
            break
        case 6:
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "SupportCenterVC") as! SupportCenterVC
            self.navigationController?.pushViewController(vc, animated: false)
            break
        case 7:
            let vc = UIStoryboard.DashboardStoryboard.instantiateViewController(withIdentifier: "Dashboard_ConsultationsViewController") as! Dashboard_ConsultationsViewController
            self.navigationController?.pushViewController(vc, animated: false)
            break
        case 8:
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
            self.navigationController?.pushViewController(vc, animated: false)
            break
            
        case 9:
            self.showLogOutPopUp1(leftBtnTitle: "Cancel", rightBtnTitle: "Confirm", lblText: "Are you sure you want to log out", isLogOut: true, customDelegate: self)
            break
        default:
            //            let vc = UIStoryboard.OrderStoaryboard.instantiateViewController(withIdentifier: "ParentMyOrderVC") as! ParentMyOrderVC
            //            self.navigationController?.viewControllers = [vc]
            break
            
        }
        //        }
    }
    
    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1 = UIStoryboard.DashboardStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        child1.childNumber = "Dashboard"
        
        let child2 = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "MyRecipesVC") as! MyRecipesVC
        child2.childNumber = "My Stuff"
        
        let child3 = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "MyChefsVC") as! MyChefsVC
        child3.childNumber = "My Chefs"
        
        let child4 = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "ExploreVC") as! ExploreVC
        child4.childNumber = "Explore"
        
        return [child1, child2, child3, child4]
    }
    
    func configureButtonBar() {
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.buttonBarItemBackgroundColor = .clear
        
        settings.style.buttonBarItemFont = UIFont(name: "engcarnation", size: 14.0)!
        settings.style.buttonBarItemTitleColor = .white
        
        settings.style.buttonBarMinimumLineSpacing = 0
        //        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        //        settings.style.
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        // Changing item text color on swipe
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = .white
            oldCell?.contentView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.15)
            oldCell?.contentView.layer.cornerRadius = 8
            
            newCell?.contentView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
            newCell?.label.textColor = .white
            newCell?.contentView.layer.cornerRadius = 8
        }
    }
    
    //    MARK: UnsubscribeRecipePopUpVCDelegate
    func onClcikRightButton() {
        print("Hi...")
        UserDefaults.standard.removePersistentDomain(forName: "PrepSmart")
        if let bundleID = Bundle.main.bundleIdentifier {
            print(bundleID)
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        let story = UIStoryboard(name: "Login_Model_Storyboard", bundle: nil)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let vc = story.instantiateViewController(withIdentifier: "SignInViewController")as! SignInViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
