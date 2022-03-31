//
//  Dashboard_ConsultationsViewController.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 29/05/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//
//Screen Id :- PSTMOBSTD0146, PSTMOBSTD0149, PSTMOBSTD0147

import UIKit

class Dashboard_ConsultationsViewController: BaseViewController {
    
    @IBOutlet weak var btn_active: UIButton!
    @IBOutlet weak var btn_archived: UIButton!
    @IBOutlet weak var tblView_consultation: UITableView!
    
    let consultationCell = "ConsultationTableViewCell"
    var isActive: Bool = true
    var global_Var = GlobalClass.sharedManager
    var consultationObj: Consultation_Struct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.initialize()
    }
    
    func initialize() {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Consultations Requests")
        
        btn_active.clipsToBounds = true
        btn_active.layer.cornerRadius = 4.0
        
        btn_archived.clipsToBounds = true
        btn_archived.layer.cornerRadius = 4.0
        
        tblView_consultation.dataSource = self
        tblView_consultation.delegate = self
        
        tblView_consultation.register(UINib.init(nibName: consultationCell, bundle: nil), forCellReuseIdentifier: consultationCell)
        
        tblView_consultation.contentInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 15.0, right: 0.0)
        getConsultationApi(flag: "1")
//        self.navigationItem.rightBarButtonItem = addConfigNavButton()
    }
    
    func addConfigNavButton() -> UIBarButtonItem {
        let addConfigNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter_top"), style: .done, target: self, action: #selector(self.showPopUp))
        return addConfigNavButton
    }
    
    @objc func showPopUp()
    {
//        self.showConfigurePopUp()
    }
    
    @IBAction func onClicklChangeTab(_ sender: UIButton) {
        if sender == btn_active
        {
            isActive = true
            btn_active.backgroundColor = UIColor.appOrangeColor()
            btn_archived.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
            getConsultationApi(flag: "1")
           
        }
        else
        {
            isActive = false
            btn_archived.backgroundColor = UIColor.appOrangeColor()
            btn_active.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
            getConsultationApi(flag: "2")
        }
         tblView_consultation.reloadData()
    }
}

extension Dashboard_ConsultationsViewController : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.consultationObj?.booking_list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: consultationCell, for: indexPath) as! ConsultationTableViewCell
        let dic = self.consultationObj?.booking_list?[indexPath.row]
        
        cell.imgView_profile.clipsToBounds = true
        cell.imgView_profile.layer.cornerRadius = cell.imgView_profile.frame.width/2
        
        cell.view_border.clipsToBounds = true
        cell.view_border.layer.cornerRadius = 4.0
        cell.view_border.layer.borderWidth = 0.5
        cell.view_border.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.view_indicator.clipsToBounds = true
        cell.view_indicator.layer.cornerRadius = cell.view_indicator.frame.width/2
        cell.view_indicator.backgroundColor = .green
        
        if isActive == true{
            cell.lbl_status.textColor = UIColor.appOrangeColor()
            cell.lbl_status.setTextUnderline(UIColor.appOrangeColor(), string: "Status : Completed")
        }else{
            cell.lbl_status.textColor = UIColor.darkText
            cell.lbl_status.setTextUnderline(UIColor.clear, string: "Status : Completed")
            
        }
        cell.imgView_profile.sd_setImage(with: URL(string: dic?.user_pic ?? ""), placeholderImage: UIImage(named: "dinner"))
        cell.lbl_name.text = dic?.user_name
        cell.lbl_date.text = convertDateFormater(date: dic?.booking_date ?? "")
        cell.lbl_status.text = "Status: \(dic?.booking_status ?? "")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = UIStoryboard.ConsultationsStoryboard.instantiateViewController(withIdentifier: "ConsultationViewController") as! ConsultationViewController
        detailsVC.isActive = isActive
        detailsVC.bookingListObj = self.consultationObj?.booking_list?[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//extension Dashboard_ConsultationsViewController : ConfigurePopUpViewControllerDelegate
//{
//    func onClickSaveButton(duration: String, fee: String) {
//        print("\(duration) \(fee)")
//    }
//}

extension Dashboard_ConsultationsViewController
{
    func getConsultationApi(flag: String?)
     {

         let param:[String:String] = ["flag": flag ?? ""]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getConsultation, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.consultationObj = try JSONDecoder().decode(Consultation_Struct.self, from: data)
                             self.tblView_consultation.reloadData()
                             
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
