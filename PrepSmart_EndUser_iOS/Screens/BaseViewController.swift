//
//  BaseViewController.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 27/05/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Popover

class BaseViewController: UIViewController {
    var bgImage : UIImageView!
     var popoverOptions: [PopoverOption] = [
        .type(.auto),
        .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    
    override func viewDidLoad()
    {
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
        
        bgImage = UIImageView(frame: CGRect(x: 0, y: 0, width: UtilityManager.getWidth(), height: UtilityManager.getHeight()))
        bgImage.image = UIImage(named: "base_Screen")
        self.view.addSubview(bgImage)
        self.view.sendSubviewToBack(bgImage)
        
        
    }
    
    //        MARK: Navigation Buttons
    
    func addBlogsNavButton() -> UIBarButtonItem {
        let addBlogsNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "add_recipe"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addBlogsNavButton.tag = 0
        return addBlogsNavButton
    }
    
    func addFilterNavButton() -> UIBarButtonItem {
        let addFilterNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter_white"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addFilterNavButton.tag = 1
        return addFilterNavButton
    }
    func addSortNavButton() -> UIBarButtonItem {
        let addSortNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "shortlist"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addSortNavButton.tag = 2
        return addSortNavButton
    }
    func addProfileNavButton() -> UIBarButtonItem {
        let addProfileNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "profiel"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addProfileNavButton.tag = 3
        return addProfileNavButton
    }
    func addSettingNavButton() -> UIBarButtonItem {
        let addSettingNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "setting"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addSettingNavButton.tag = 4
        return addSettingNavButton
    }
    func addNotificationNavButton() -> UIBarButtonItem {
        let addNotificationNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "notification"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addNotificationNavButton.tag = 5
        return addNotificationNavButton
    }
    func addNavSettingNavButton() -> UIBarButtonItem {
        let addSettingNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "setting"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addSettingNavButton.tag = 6
        return addSettingNavButton
    }
    func addNewRecipeNavButton() -> UIBarButtonItem {
        let addNewRecipeNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "add_white"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addNewRecipeNavButton.tag = 7
        return addNewRecipeNavButton
    }
    
    func addViewRecipeEditButton() -> UIBarButtonItem {
        let addNewRecipeNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "edit_icon"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addNewRecipeNavButton.tag = 8
        return addNewRecipeNavButton
    }
    
    func addViewRecipeDeleteButton() -> UIBarButtonItem {
        let addNewRecipeNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "delete"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addNewRecipeNavButton.tag = 9
        return addNewRecipeNavButton
    }
    
    func addNewWeelyPlanNavButton() -> UIBarButtonItem {
        let addNewRecipeNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "add_white"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addNewRecipeNavButton.tag = 10
        return addNewRecipeNavButton
    }
    
    func addDownloadNavButton() -> UIBarButtonItem {
        let addDownloadNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "download_white_icon"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addDownloadNavButton.tag = 11
        return addDownloadNavButton
    }
    
    func addSaveNavButton() -> UIBarButtonItem {
        let addBlogsNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "save"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addBlogsNavButton.tag = 12
        return addBlogsNavButton
    }
    
    func addWishListNavButton() -> UIBarButtonItem {
        let addBlogsNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "heart"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addBlogsNavButton.tag = 13
        return addBlogsNavButton
    }
    
 
    
    func addShareNavButton() -> UIBarButtonItem {
           let addBlogsNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "share_white_icon"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
           addBlogsNavButton.tag = 14
           return addBlogsNavButton
       }
    
    func addSaveOptionsButton() -> UIBarButtonItem {
        let addBlogsNavButton = UIBarButtonItem(image: UIImage(named: "export"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addBlogsNavButton.tag = 21
        return addBlogsNavButton
    }
    
    func addInfoButton() -> UIBarButtonItem {
        
        var image = UIImage()
        
        if #available(iOS 13.0, *) {
            image = #imageLiteral(resourceName: "info").withTintColor(.white)
        } else {
            // Fallback on earlier versions
        }
        
        let addBlogsNavButton = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addBlogsNavButton.tag = 15
        return addBlogsNavButton
    }
    
    func editWeeklyPlanNavButton() -> UIBarButtonItem {
        let editWeeklyPlanNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "edit_icon"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        editWeeklyPlanNavButton.tag = 16
        return editWeeklyPlanNavButton
    }
    
    func editRecipeNavButton() -> UIBarButtonItem {
        let editRecipeNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "edit_icon"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        editRecipeNavButton.tag = 17
        return editRecipeNavButton
    }
    
    func addWeeklyPlanNavButton() -> UIBarButtonItem {
        let addWeeklyPlanNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "add_white"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        addWeeklyPlanNavButton.tag = 18
        return addWeeklyPlanNavButton
    }
    
    func deleteWeeklyPlanNavButton() -> UIBarButtonItem {
        let deleteWeeklyPlanNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "delete"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        deleteWeeklyPlanNavButton.tag = 19
        return deleteWeeklyPlanNavButton
    }
    
    func saveWeeklyPlanNavButton() -> UIBarButtonItem {
        let saveWeeklyPlanNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "save"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        saveWeeklyPlanNavButton.tag = 20
        return saveWeeklyPlanNavButton
    }
    
    func deleteRecipeNavButton() -> UIBarButtonItem {
        let deleteRecipeNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "delete"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        deleteRecipeNavButton.tag = 21
        return deleteRecipeNavButton
    }
    
    func saveRecipeNavButton() -> UIBarButtonItem {
        let saveRecipeNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "save"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
        saveRecipeNavButton.tag = 22
        return saveRecipeNavButton
    }

    //    MARK: OnClick Navigation Func
    @objc func onClickNavigationBarButton(sender:UIBarButtonItem) {
        
        
        if sender.tag == 0 {
            let shortFilter = self.instanceFromSearchFilterNib()
            shortFilter.frame = CGRect(x: 0, y: 0, width: 350, height: 450)
            
            let popover = Popover(options: self.popoverOptions)
            popover.show(shortFilter, fromView: sender.plainView)
        }
        
        else if sender.tag == 1 {
//            let shortFilter = self.instanceFromSearchFilterNib()
//            shortFilter.frame = CGRect(x: 0, y: 0, width: 350, height: 450)
//
//            let popover = Popover(options: self.popoverOptions)
//            popover.show(shortFilter, fromView: sender.plainView)
            
            let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "FilterViewViewController") as! FilterViewViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
        else if sender.tag == 2 {
            let shortFilter = self.instanceFromShortListFilterNib()//BlogFilter(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: 300))
            shortFilter.frame = CGRect(x: 0, y: 0, width: 200, height: 450)
            
            let popover = Popover(options: self.popoverOptions)
            popover.show(shortFilter, fromView: sender.plainView)
        }else if sender.tag == 2 {
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
             self.navigationController?.pushViewController(vc, animated: true)
        }
            
        else if sender.tag == 7{
            let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AddNewViewController") as! AddNewViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 8{
            let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "EditRecipePackViewController") as! EditRecipePackViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 9{   //Delete
            
        }
        else if sender.tag == 10{
                        self.showAlertAddWeeklyPlanVC()
            
//            let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "AlertAddWeeklyPlanVC") as! AlertAddWeeklyPlanVC
//
//            vc.completionHandler = { (status) in
//
//                if status {
//                    //Positive
//                    let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "AlertLoadPlanTempletVC") as! AlertLoadPlanTempletVC
//
//                    vc.completionHandler = { (status) in
//                        if status {
//                            // positive
//                            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "WeekPlannerVC") as! WeekPlannerVC
////                             self.removeAnimation()
//                            self.navigationController?.pushViewController(vc, animated: true)
//
//                        } else {
//                            // negative
//                            print("negative")
//                        }
//                    }
//                    vc.view.frame = self.view.bounds;
//                    vc.willMove(toParent: self)
//                    self.view.addSubview(vc.view)
//                    self.addChild(vc)
//                    vc.didMove(toParent: self)
//
//                }
//            }
//            vc.view.frame = self.view.bounds;
//            vc.willMove(toParent: self)
//            self.view.addSubview(vc.view)
//            self.addChild(vc)
//            vc.didMove(toParent: self)
        }
        else if sender.tag == 4{
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "NotificationSettingsVC") as! NotificationSettingsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if sender.tag == 12
        {
            print("Save Button Clicked")
//            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
//            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if sender.tag == 13
        {
            print("Notification Button Clicked")
        }
        else if sender.tag == 15
        {
            print("Info Button Clicked")
        }
        else if sender.tag == 16
        {
            let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "EditWeeklyPlanTemplateVC") as! EditWeeklyPlanTemplateVC
            vc.isForAddWeeklyPlanTemplate = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if sender.tag == 17
        {
           let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "EditCreatedRecipeViewController") as! EditCreatedRecipeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if sender.tag == 18
        {
            let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "EditWeeklyPlanTemplateVC") as! EditWeeklyPlanTemplateVC
            vc.isForAddWeeklyPlanTemplate = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else if sender.tag == 21
        {
           // SaveOptionsPopUpVC(customDelegate : self)
        }
        else if sender.tag == 19
        {
            
        }
        else if sender.tag == 20
        {
            
        }
        else if sender.tag == 21
        {
           
        }
        else if sender.tag == 22
        {
           
        }
        
        
    }
 
    //MARK:- Show Alert
    func showAlertWithErrorMessage(_ message:String)
    {
        let alert = KKAlertController(title: "", message:message, preferredStyle:  UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { (action: UIAlertAction) -> Void in }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func instanceFromBlogFilterNib() -> UIView {
        return UINib(nibName: "BlogFilter", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BlogFilter
    }
    
    func instanceFromShortListFilterNib() -> UIView {
        return UINib(nibName: "ShortListFilterView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ShortListFilterView
    }
    
    func instanceFromSearchFilterNib() -> UIView {
        return UINib(nibName: "SearchFilter", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SearchFilter
    }
}
//extension BaseViewController : SaveOptionsPopUpVCDelegate {
//    func onClcikSubmitBtn() {
//        print("Submit tapped")
//    }
//
//
//
//
//}
