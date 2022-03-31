//
//  TabBarViewController.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 29/05/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
// Screen Id : PSTMOBSTD023

import UIKit
import Popover

 var selectedIndexPath : Int?
class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var categoryArray : [String]  = ["My Profile","My Subscriptions","Billing & Payment","Plan Info", "Notifications","Settings","Support Center","Conusultation Requests","About Us","Log Out"]
    let imgArray = ["my_profile_active","my_subscriptions_active","billing_payment_active","plan_active","notifications_active","settings_active","contact_support","consultation_requests_active","about_us_active","logout_active"]
    let non_selected_ImgArray = ["my_profile","my_subscriptions","billing_payment","plan_info","notifications","settings","support_center","consultation_requests","about_us","logout_black"]
    
    let menuTableCell = "MenuTableCell"
    
     var popoverOptions: [PopoverOption] = [
        .type(.up),
        .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    
    var popover : Popover!
    
   
    private var bgView:UIView = UIView()
    private var middleButton:ETPLButton = ETPLButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initiolize()
        print("User token ==>\(GlobalClass.sharedManager.logindicObj?.userData?.access_token)")
    }
    
    func initiolize() {
        
        self.navigationController?.navigationBar.isHidden = true
        let tabBarItems = self.tabBar.items
       
        tabBarItems![0].selectedImage = #imageLiteral(resourceName: "home_active")
        tabBarItems![1].selectedImage = #imageLiteral(resourceName: "plan_active")
        tabBarItems![2].selectedImage = #imageLiteral(resourceName: "shop_active")
        tabBarItems![3].selectedImage = #imageLiteral(resourceName: "cook_active")
        tabBarItems![4].selectedImage = #imageLiteral(resourceName: "menu_active")
        
        tabBarItems![0].image = #imageLiteral(resourceName: "home")
        tabBarItems![1].image = #imageLiteral(resourceName: "plan")
        tabBarItems![2].image = #imageLiteral(resourceName: "shop")
        tabBarItems![3].image = #imageLiteral(resourceName: "cook")
        tabBarItems![4].image = #imageLiteral(resourceName: "menu")
        
        tabBarItems![0].title = "Home"
        tabBarItems![1].title = "Plan"
        tabBarItems![2].title = "Shop"
        tabBarItems![3].title = "Cook"
        tabBarItems![4].title = "Menu"
        
        tabBarItems![0].tag = 0
        tabBarItems![1].tag = 1
        tabBarItems![2].tag = 2
        tabBarItems![3].tag = 3
        tabBarItems![4].tag = 4
        
        self.tabBar.tintColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
        
        self.tabBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        selectedIndexPath = nil
        self.tabBar.backgroundColor = UIColor.clear
     //   self.tabBar.backgroundImage = UIImage()
     //   self.tabBar.shadowImage = UIImage()  // removes the border
        
        self.delegate = self
        self.setupMiddleButton()
    }
    
  
    
    //    MARK: Set up middel button
    func setupMiddleButton() {
        
        bgView.backgroundColor = .clear//UIColor.appTabBarColor()
        bgView.frame.size = CGSize(width: 150, height: 50)
        bgView.layer.masksToBounds = true
        bgView.center = CGPoint(x: self.view.frame.width, y: 20)
        
        middleButton.frame.size = CGSize(width: 150, height: 40)
        middleButton.layer.masksToBounds = true
        middleButton.center = CGPoint(x: self.view.frame.width, y: 20)
        middleButton.backgroundColor = .clear
        middleButton.addTarget(self, action: #selector(self.onClickMiddleButton(sender:)), for: .touchUpInside)
        self.tabBar.addSubview(bgView)
        self.tabBar.addSubview(middleButton)
        self.tabBar.bringSubviewToFront(middleButton)
    }

    //    MARK: Middelbutton action
    @objc func onClickMiddleButton(sender:ETPLButton) {

        let blogFilter = BlogFilter.instanceFromBlogFilterNib()
        blogFilter.frame = CGRect(x: 0, y: 0, width: 270, height: (self.view.frame.height - 160))
        
        blogFilter.filterTableView.delegate = self
        blogFilter.filterTableView.dataSource = self
        
        popover = Popover(options: self.popoverOptions)
        popover.show(blogFilter, point: CGPoint(x: self.view.frame.width - 40, y: self.view.frame.height - 60))
    }
}

extension TabBarViewController : UITableViewDelegate, UITableViewDataSource{
    //    MARK: UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuTableCell, for: indexPath) as! MenuTableCell
        cell.itemNameLabel.text = categoryArray[indexPath.row]
       // cell.itemImageView.image = UIImage(named: non_selected_ImgArray[indexPath.row])
        
        if selectedIndexPath != nil, selectedIndexPath == indexPath.row{
            cell.itemImageView.image = UIImage(named: imgArray[selectedIndexPath!])
        }else{
             cell.itemImageView.image = UIImage(named: non_selected_ImgArray[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        self.popover.dismiss()
         selectedIndexPath = indexPath.row
        Notification_Name = indexPath.row
        NotificationCenter.default.post(name: Notification.Name("TabBarNotification"), object: nil)
        print(Notification_Name ?? "")
        
       
        
        self.selectedIndex = 0
        popover.dismiss()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}
