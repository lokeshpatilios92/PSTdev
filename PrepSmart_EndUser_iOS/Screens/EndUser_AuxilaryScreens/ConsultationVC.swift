//
//  ConsultationVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 25/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ConsultationVC: BaseViewController {

 
    @IBOutlet weak var confirmConsultationBtn: UIButton!
    @IBOutlet weak var consultationFeeTxtField: KKNEWTextFiled!
    @IBOutlet weak var comnsultationDurationTxtField: KKNEWTextFiled!
    @IBOutlet weak var notesTxtView: UITextView!
    @IBOutlet weak var phoneTxtField: KKNEWTextFiled!
    @IBOutlet weak var emailTxtField: KKNEWTextFiled!
    @IBOutlet weak var whatToExceptBtn: UIButton!
    
    let global_Var = GlobalClass.sharedManager
    var chefId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
    }
    
    
    func initializer(){
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Consultation")
        whatToExceptBtn.setTextUnderline(UIColor.appOrangeColor(), string: whatToExceptBtn.currentTitle!)
        whatToExceptBtn.setTextColor(UIColor.appOrangeColor(), string: whatToExceptBtn.currentTitle!)
        confirmConsultationBtn.layer.cornerRadius = confirmConsultationBtn.frame.height/2
       
    }
    

    @IBAction func whatToExceptBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickConfirm(_ sender: Any) {
        self.addConsultationApi()
       
    }
}

extension ConsultationVC
{
    func addConsultationApi()
     {
         let param:[String:Any] = ["chef_id": self.chefId, "duration": self.comnsultationDurationTxtField.text ?? "","fee": self.consultationFeeTxtField.text ?? "","notes": self.notesTxtView.text ?? "","phone": self.phoneTxtField.text ?? "","email": self.emailTxtField.text ?? ""]
                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.addConsultation, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             let addConsultationObj = try JSONDecoder().decode(Get_Status.self, from: data)
                             Alert.showMiddleToast(message: addConsultationObj.message, view_VC: self)
                             self.navigationController?.popViewController(animated: true)
                           
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
