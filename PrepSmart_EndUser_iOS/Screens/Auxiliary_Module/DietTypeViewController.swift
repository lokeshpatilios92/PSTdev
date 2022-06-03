//
//  DietTypeViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh Kulkarni on 23/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD009

import UIKit
import Toaster

class DietTypeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableTitleView: UIView!
    @IBOutlet weak var tableBottomView: UIView!
    @IBOutlet weak var tableTitleLabel: UILabel!
    @IBOutlet weak var tableBottomLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var diteArray : [String] = []
    var selectedDiteArray : [String] = []
    
    let dietTableCell = "DietTableCell"
    var dietTypeObj : DietType_Struct?
    var global_Var = GlobalClass.sharedManager
    var id = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    func initialize() {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Food Interests")
        
//        diteArray = ["Everything Goes","Flexitarion","Low Carb","Pescetarion","Vegetarion","Paleo","Keto","Vegan","Gluten-Free","Crnivore","API","Low Histamine","SCD"]
        getDietTypeAPI()
        tableBottomLabel.text = "Don't see your dite here?\nClick here to recommend additions"
        tableBottomLabel.setTextUnderline(.appOrangeColor(), string: "Click here")
        tableBottomLabel.setTextColor(.appOrangeColor(), string: "Click here")
        
        tableView.register(UINib(nibName: dietTableCell, bundle: .none), forCellReuseIdentifier: dietTableCell)
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
    }
    
    //    MARK: onClick Func
    @IBAction func onClickNextButton(_ sender: UIButton) {
       
        if id == 0
        {
            Alert.showToast(message: "Please select a diet type", view_VC: self)
        }
        else
        {
            let vc =  UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "MembershipLevelViewController") as! MembershipLevelViewController
            self.updateFoodInterestAPI()
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        
    }
    
}

extension DietTypeViewController : UITableViewDelegate, UITableViewDataSource {
    
    //    MARK: UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: dietTableCell, for: indexPath) as! DietTableCell
        cell.titleLabel.text = diteArray[indexPath.row]
        cell.bottomLabel.text = ""
        
        if indexPath.row == 0 {
            cell.bottomLabel.text = "No Restrictions"
        }
        
        cell.rightImage.image = #imageLiteral(resourceName: "radio_normal")
        
//        if(self.selectedDiteArray.contains(diteArray[indexPath.row])) {
//            cell.rightImage.image = #imageLiteral(resourceName: "check_mark_orange")
//        }
//        else {
//            cell.rightImage.image = #imageLiteral(resourceName: "check_mark_orange_normal")
//        }
        
        if(self.selectedDiteArray.contains(diteArray[indexPath.row])) {
            cell.rightImage.image = #imageLiteral(resourceName: "check_mark_orange")
        }
        else {
            cell.rightImage.image = #imageLiteral(resourceName: "check_mark_orange_normal")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DietTableCell
        
        if(self.selectedDiteArray.contains(diteArray[indexPath.row]) == true) {
            
            self.selectedDiteArray.remove( at: self.selectedDiteArray.firstIndex(of: diteArray[indexPath.row])! )
            self.id = 0
            cell.rightImage.image = #imageLiteral(resourceName: "check_mark_orange_normal")
            
        }
        else {
            if(self.selectedDiteArray.count == 0 ) {
                self.selectedDiteArray.append(diteArray[indexPath.row])
                self.id = self.dietTypeObj?.diettype_list?[indexPath.row].diet_id ?? 0
                cell.rightImage.image = #imageLiteral(resourceName: "check_mark_orange")
            }
            else {
                let row = self.diteArray.firstIndex(of: selectedDiteArray[0])
                
                for visibleCell in self.tableView.visibleCells as! [DietTableCell] {
                    if(self.tableView.indexPath(for: visibleCell)?.row == row) {
                        visibleCell.rightImage.image = #imageLiteral(resourceName: "check_mark_orange_normal")
                        break
                    }
                }
                self.selectedDiteArray[0] = diteArray[indexPath.row]
                cell.rightImage.image = #imageLiteral(resourceName: "check_mark_orange")
            }
        }
    }
}

extension DietTypeViewController
{
    func updateFoodInterestAPI()
     {
         let param:[String:Any] = ["ids": self.id]

         Loader.sharedInstance.showIndicator()
         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.updateFoodInterest, params: param , method: .post) { [self] (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.dietTypeObj = try JSONDecoder().decode(DietType_Struct.self, from: data)
                             
                             for i in self.dietTypeObj?.diettype_list ?? []
                             {
                                 self.diteArray.append(i.diet_name ?? "")
                             }
                             self.tableView.reloadData()
                             Alert.showToast(message: self.dietTypeObj?.message, view_VC: self)
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
    
    func getDietTypeAPI()
     {
         let param:[String:String] = ["":""]
         
                 Loader.sharedInstance.showIndicator()
         
         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getDietTypes, params: param , method: .get) { [self] (result) in
             switch result
             {
             case .success(let data, let dictionary):
                 
                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.dietTypeObj = try JSONDecoder().decode(DietType_Struct.self, from: data)
                             
                             for i in self.dietTypeObj?.diettype_list ?? []
                             {
                                 self.diteArray.append(i.diet_name ?? "")
                                 print(self.diteArray)
                             }
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
