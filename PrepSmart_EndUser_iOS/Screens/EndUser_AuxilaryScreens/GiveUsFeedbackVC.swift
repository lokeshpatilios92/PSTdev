//
//  GiveUsFeedbackVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Nishant on 31/01/20.
//  Copyright © 2020 Exceptionaire.co. All rights reserved.
//

import UIKit
import DropDown

class GiveUsFeedbackVC: BaseViewController {
    
    
    @IBOutlet weak var Btn_submit: UIButton!
    @IBOutlet weak var Btn_cancel: UIButton!
    @IBOutlet weak var Lbl_count: UILabel!
    @IBOutlet weak var Txt_msg: UITextField!
    @IBOutlet weak var Txt_subject: UITextField!
    @IBOutlet weak var dropdownView: UIView!

   var subjectDropDown = DropDown()
    var supportSubjectObj: SupportSubject_Struct?
    var submitSupportObj = Get_Status()
    var global_Var = GlobalClass.sharedManager
    var subjectArr = [String]()
    var subjectId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialize()
    }
    
    func initialize(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Give us feedback")
        self.Btn_submit.layer.cornerRadius = self.Btn_submit.frame.height/2
        self.Btn_cancel.layer.cornerRadius = self.Btn_cancel.frame.height/2
        self.Btn_cancel.layer.borderWidth = 0.5
        self.Btn_cancel.layer.borderColor = UIColor.appOrangeColor().cgColor
        
        getSupportSubjectApi()
        subjectDropDown.anchorView = dropdownView
        subjectDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.Txt_subject.text = item
            
            for i in self.supportSubjectObj?.support_subject ?? []
            {
                if self.Txt_subject.text == item
                {
                    self.subjectId = i.subject_id ?? 0
                }
            }
            
        }
        
    }
    
   
    @IBAction func submitClicked(_ sender: UIButton) {
        
        if subjectId == 0
        {
            Alert.showH(titleStr: "", messageStr: "Please select subject")
        }
        else if self.Txt_msg.text == ""
        {
            Alert.showH(titleStr: "", messageStr: "Please write message")
        }
        else
        {
            submitSupportApi()
        }
    }
    
    @IBAction func cancelClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SubjectDropDownClick(_ sender: UIButton)
    {
        self.subjectDropDown.show()
    }
    


}


extension GiveUsFeedbackVC
{
    func getSupportSubjectApi()
     {
         let param:[String:String] = ["":""]
                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getSupportSubjects, params: param , method: .get) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.supportSubjectObj = try JSONDecoder().decode(SupportSubject_Struct.self, from: data)
                             for i in self.supportSubjectObj?.support_subject ?? []
                             {
                                 self.subjectArr.append(i.subject ?? "")
                             }
                             
                             self.subjectDropDown.dataSource = self.subjectArr
                             
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
    
    func submitSupportApi()
     {
         let param:[String:Any] = ["subject_id":self.subjectId,"message": self.Txt_msg.text ?? ""]
                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.submitSupport, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.submitSupportObj = try JSONDecoder().decode(Get_Status.self, from: data)
                             Alert.alert_PopMathod(vc: self, title: "Feedback", message_Str: self.submitSupportObj.message, action_Title: ["Ok"], action_Style: [.default], action: [({
                                 ok in
                                     self.navigationController?.popViewController(animated: true)

                                 
                                 })])
                           
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

