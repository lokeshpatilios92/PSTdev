//
//  AlertLoadPlanTempletVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 12/11/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import DropDown
class AlertLoadPlanTempletVC: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var btn_Load: UIButton!
    @IBOutlet weak var btn_Template: UIButton!
    @IBOutlet weak var btn_DropDown: UIButton!
    @IBOutlet weak var lbl_SelectedPlan: UILabel!

    var myStuffObj : MyStuff_Struct?
    var global_Var = GlobalClass.sharedManager
    var completionHandler: ((Bool) -> Void)!
    var planDropDown = DropDown()
    var allWeeklyPlanId:[Int] = []
    var selectedWeeklyPlanId:Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAnimation()
        myStuffApi(startIndex: 0, type: 3, displayType: 2, recordCount: 100)
        self.planDropDown.backgroundColor = UIColor.white
        DropDown.startListeningToKeyboard()
    //    sortByTextFiled.text = "A-Z"
    //  planDropDown.dataSource = ["Day","Recipe","Store isle","A-Z"]
    }
    
    //    MARK : OnClick Func
    @IBAction func onClickButton(_ sender: UIButton) {
        if sender == btn_Load {
            if selectedWeeklyPlanId == -1 || lbl_SelectedPlan.text == "Select Plan" {
                Alert.showToast(message: "Please select plan", view_VC: self)
            }
            else {
            print("selectedWeeklyPlanId \(selectedWeeklyPlanId)")
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "WeekPlannerVC") as! WeekPlannerVC
            vc.weeaklyPlanId = selectedWeeklyPlanId
            self.removeAnimation()
            self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else if sender == btn_DropDown {
            planDropDown.anchorView = self.lbl_SelectedPlan
            planDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.lbl_SelectedPlan.text = item
                self.selectedWeeklyPlanId = allWeeklyPlanId[index]
            }
            planDropDown.width = self.lbl_SelectedPlan.frame.width
            planDropDown.show()
        }
        else if sender == btn_Template {
        }
        
        else {
            self.removeAnimation()
        }
    }
}

extension AlertLoadPlanTempletVC{
    func myStuffApi(startIndex:Int, type:Int, displayType:Int, recordCount:Int)
    {
        let param:[String:Any] = ["start_index":startIndex,
                                  "type": type,
                                  "display_type": displayType,
                                  "record_count":recordCount]
        print("params \(param)")
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.myStuff, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.myStuffObj = try JSONDecoder().decode(MyStuff_Struct.self, from: data)
                            for i in self.myStuffObj?.recipeList ?? []
                            {
                                self.planDropDown.dataSource.append(i.item_title ?? "")
                                self.allWeeklyPlanId.append(i.item_id ?? -1)
                            }
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
