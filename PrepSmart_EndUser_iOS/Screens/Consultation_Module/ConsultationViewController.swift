//
//  ConsultationViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 03/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//
//Screen ID :- PSTMOBSTD0148

import UIKit
import Popover
import DropDown
import Toaster

class ConsultationViewController: BaseViewController {

    @IBOutlet weak var btn_addToCalendar: UIButton!
    @IBOutlet weak var btn_archive: UIButton!
    @IBOutlet weak var imgView_profile: UIImageView!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var lbl_contactNo: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_info: UILabel!
    @IBOutlet weak var lbl_myNotes: UILabel!
    @IBOutlet weak var btn_info: UIButton!
    @IBOutlet weak var btn_dropdown: UIButton!
    @IBOutlet weak var btn_status: UIButton!
    
    let statusDropDown = DropDown()
    
    var isActive : Bool = false
    var bookingListObj: Booking_list?
    var global_Var = GlobalClass.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialize()
    }

    func initialize()
    {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Booking Details")
        
        btn_addToCalendar.clipsToBounds = true
        btn_addToCalendar.layer.cornerRadius = btn_addToCalendar.frame.height/2
        
        btn_archive.clipsToBounds = true
        btn_archive.layer.cornerRadius = btn_addToCalendar.frame.height/2
        
        if isActive
        {
            btn_addToCalendar.setTitle("Add to Calendar", for: .normal)
            btn_archive.setTitle("Archive", for: .normal)
        }
        else
        {
            btn_addToCalendar.setTitle("Move To Active", for: .normal)
            btn_archive.setTitle("Delete", for: .normal)
        }
        statusDropDown.dataSource = ["Select Status","Pending", "Completed"]
        setupDropDown()
        self.showAnimation()
        getBookingData()
    }
    
    func getBookingData()
    {
        imgView_profile.sd_setImage(with: URL(string: bookingListObj?.user_pic ?? ""), placeholderImage: UIImage(named: "dinner"))
        lbl_userName.text = bookingListObj?.user_name
        lbl_date.text = convertDateFormater(date: bookingListObj?.booking_date ?? "")
        lbl_contactNo.text = bookingListObj?.user_contact
        lbl_email.text = bookingListObj?.user_email
        lbl_info.text = bookingListObj?.issue
        lbl_myNotes.text = bookingListObj?.chef_reply
    }
        
    func setupDropDown(){
        statusDropDown.anchorView = btn_status
        statusDropDown.width = self.btn_status.frame.width
        DropDown.appearance().textColor = UIColor.darkText
        DropDown.appearance().selectedTextColor = UIColor.darkText
        DropDown.appearance().textFont = UIFont(name: "ENGCARNATION", size: 14.0)!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().cellHeight = 60
        DropDown.startListeningToKeyboard()
    }
    
    @IBAction func onClickAddToCalendar(_ sender: Any) {
    
    }
    
    @IBAction func onClickArchive(_ sender: Any) {
        if isActive
        {
            self.showCustomOkCancelPopUp(titleText: "", mesgText: "Are you sure? You are attempting to archive an incomplete transaction. In order to complete this transaction, please update the status to 'Complete' at the conclusion of your consultation before archiving.", okButtonName: "Archive Anyway", cancelButtonName: "Cancel", leftCornerImage: nil, customDelegate:self)
        }
        else
        {
            self.showCustomOkCancelPopUp(titleText: "", mesgText: "Are you sure you want to delete?", okButtonName: "Delete", cancelButtonName: "Cancel", leftCornerImage: nil, customDelegate:self)
        }
        
    }
    
    @IBAction func onClickExpandCollapse(_ sender: Any) {
    
    }
    
    @IBAction func onClickStatus(_ sender: Any) {
        statusDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
             print("Selected item: \(item) at index: \(index)")
             self.lbl_status.text = item
            
            if item == "Completed"
            {
                self.showAlertWithOkButtonPopUpVC(setTitle: "", setMessage: "Thanks for marking this consultation as complete! This will finalize this consultation request and will complete the payment transaction (cannot be undone).", setButtonTitle: "Finalize", customDelegate: self)
            }
            else if item == "Pending"
            {
                self.updateConsultationStatusApi(Status: "1")
            }
        }
        self.statusDropDown.show()
    }
    
    
    @IBAction func onClickInfo(_ sender: Any) {
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: aView.frame.width - 40, height: 300))
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.font = UIFont.REGULAR_FONT_SMALLEST()
        infoLabel.textColor = .textColor()
        infoLabel.text = "Update this status to 'Complete' at the conclusion of your consultation to finalize this transaction"
        infoLabel.sizeToFit()
        infoLabel.frame = CGRect(x: infoLabel.frame.origin.x, y: infoLabel.frame.origin.y, width: infoLabel.frame.width, height: infoLabel.frame.height)
        
        let y = infoLabel.frame.height
        
        aView.addSubview(infoLabel)
        aView.frame = CGRect(x: aView.frame.origin.x, y: aView.frame.origin.y, width: aView.frame.width, height: y + 20)
        
        let popoverOptions: [PopoverOption] = [
            .type(.auto),
            .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
        ]
        
        let popover = Popover(options: popoverOptions)
        popover.show(aView, fromView: btn_info)
    }
    
}

extension ConsultationViewController : CustomOkCancelPopUpViewControllerDelegate
{
    func onClickOkButton() {
        print("Archive Button Clicked")
        if btn_archive.titleLabel?.text == "Archive"
        {
            self.updateConsultationApi(flag: "3") //for archive
        }
        else
        {
            self.updateConsultationApi(flag: "4") //for delete
        }
        
    }
    
    func onClickCancelButton() {
        print("Cancel Button Clicked")
    }
}

extension ConsultationViewController : CustomAlertWithOkButtonPopUpDelegate
{
    func onClickOkButtonAction() {
        self.updateConsultationStatusApi(Status: "1")
    }
}

extension ConsultationViewController
{
    func updateConsultationStatusApi(Status: String?)
     {
         //status = 1 for pending, 2 for complete
         let param:[String:Any] = ["status": Status ?? "","consultation_id": self.bookingListObj?.consultation_id ?? 0]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.updateConsulatationStatus, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             let updateConsultation = try JSONDecoder().decode(Get_Status.self, from: data)
                             Alert.showH(titleStr: "", messageStr: updateConsultation.message )
                             
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
    
    func updateConsultationApi(flag: String?)
     {
         //flag = 2 for active, 3 for archive, 4 for delete
         let param:[String:Any] = ["flag": flag ?? "","consultation_id": self.bookingListObj?.consultation_id ?? 0]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.updateConsulatation, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             let updateConsultation = try JSONDecoder().decode(Get_Status.self, from: data)
                             Alert.showMiddleToast(message: updateConsultation.message, view_VC: self)
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
