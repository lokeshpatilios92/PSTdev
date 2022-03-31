//
//  GetHelpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 31/01/20.
//  Copyright © 2020 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD158

import UIKit

class GetHelpVC: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let getHelpAllTopicsTableCell = "GetHelpAllTopicsTableCell"
    let getHelpContactSupportHeaderCell = "GetHelpContactSupportHeaderCell"
    let getHelpTableHearderCell = "GetHelpTableHearderCell"
    let getHelpMessageTableCell = "GetHelpMessageTableCell"
    let getHelpTwoButtonTableCell = "GetHelpTwoButtonTableCell"
    
    var headerTitleArray = ["Recommended Topics","All Topics","","Subject",""]
    let topicArray = ["Getting Started","Booking","Payment","Your Account"]
    var isExpanded = [false,false,false,false,false]
    
    var getHelpTopicObj: HelpTopic_Struct?
    var getHelpSubjectObj: HelpSubject_Struct?
    var submitHelpObj = Get_Status()
    var global_Var = GlobalClass.sharedManager
    var messageStr = ""
    var subjectId = 000
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initializer()
        // Do any additional setup after loading the view.
    }
    
    
    func initializer()
    {
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Get Help")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        searchBar.barTintColor = UIColor.clear
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .white
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 0.50
        searchBar.layer.cornerRadius = searchBar.frame.height / 2
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: UISearchBar.Icon.search, state: .normal)
        
        self.tableView.register(UINib.init(nibName: getHelpAllTopicsTableCell, bundle: nil), forCellReuseIdentifier: getHelpAllTopicsTableCell)
        //Contactus
        self.tableView.register(UINib.init(nibName: getHelpContactSupportHeaderCell, bundle: nil), forCellReuseIdentifier: getHelpContactSupportHeaderCell)
        self.tableView.register(UINib.init(nibName: getHelpTableHearderCell, bundle: nil), forCellReuseIdentifier: getHelpTableHearderCell)
        self.tableView.register(UINib.init(nibName: getHelpMessageTableCell, bundle: nil), forCellReuseIdentifier: getHelpMessageTableCell)
        self.tableView.register(UINib.init(nibName: getHelpTwoButtonTableCell, bundle: nil), forCellReuseIdentifier: getHelpTwoButtonTableCell)
        getHelpTopicApi()
    }
    
    
    @objc func sectionButtonTapped(sender: UIButton){
        isExpanded[sender.tag] = !isExpanded[sender.tag]
             tableView.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
    }

    @objc func sectionContactSupportButtonTapped(sender: UIButton){
//        isExpanded[sender.tag] = !isExpanded[sender.tag]
             tableView.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
    }
    
}


extension GetHelpVC : UITableViewDelegate,UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitleArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        if section == 5
        {
            return 60
        }
        else if section == 4
        {
            return 80
        }
        else
        {
            return 65
        }
        
    }
//
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
     
        if section == 2 {
            
            let headerView = self.tableView.dequeueReusableCell(withIdentifier: getHelpContactSupportHeaderCell) as! GetHelpContactSupportHeaderCell
            
            headerView.contactSupportBtn.addTarget(self, action: #selector(sectionContactSupportButtonTapped(sender:)), for: .touchUpInside)
            
            return headerView.contentView
     
        }
        else if section == 4
        {
            let headerView = self.tableView.dequeueReusableCell(withIdentifier: getHelpMessageTableCell) as! GetHelpMessageTableCell
            headerView.msgTextField.delegate = self
            return headerView.contentView
        }
        else if section == 5
        {
            let headerView = self.tableView.dequeueReusableCell(withIdentifier: getHelpTwoButtonTableCell) as! GetHelpTwoButtonTableCell
            
            headerView.submitButton.layer.cornerRadius = headerView.submitButton.frame.height / 2
            headerView.cancelButton.layer.cornerRadius = headerView.cancelButton.frame.height / 2
            
            headerView.cancelButton.layer.borderWidth = 0.5
            headerView.cancelButton.layer.borderColor = UIColor.appOrangeColor().cgColor
            
            headerView.submitButton.tag = section
            headerView.submitButton.addTarget(self, action: #selector(onClickSubmitBtn(_sender:)), for: .touchUpInside)
            
            headerView.cancelButton.tag = section
            headerView.cancelButton.addTarget(self, action: #selector(onClickCancelBtn(_sender:)), for: .touchUpInside)
        
            return headerView.contentView
        }
        else
        {
           let headerView = self.tableView.dequeueReusableCell(withIdentifier: getHelpTableHearderCell) as! GetHelpTableHearderCell
           headerView.headerViewBtn.tag = section
           
           headerView.titleLabel.text = headerTitleArray[section]
           
           headerView.headerViewBtn.addTarget(self, action: #selector(sectionButtonTapped(sender:)), for: .touchUpInside)
            
           if isExpanded[section]{
               headerView.dropDownImageView.image = #imageLiteral(resourceName: "up_arrow")
           }
           else
           {
                headerView.dropDownImageView.image = #imageLiteral(resourceName: "drop_arrow")
           }
           return headerView.contentView

        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            
            if isExpanded[section]
            {
                return self.getHelpTopicObj?.recommonded_topics?.count ?? 0
                
            }
        }
        else if section == 1
        {
            if isExpanded[section]
            {
                return self.getHelpTopicObj?.all_topics?.count ?? 0
            }
        }
        else if section == 3
        {
           if isExpanded[section]
            {
               return self.getHelpSubjectObj?.help_subjects?.count ?? 0
            }
        }
       
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: getHelpAllTopicsTableCell, for: indexPath) as! GetHelpAllTopicsTableCell
            let dic = self.getHelpTopicObj?.recommonded_topics?[indexPath.row]
            cell.titleLabel.text = dic?.name
            
            if indexPath.row == topicArray.count - 1
            {
                cell.bottomSepreatorLabel.isHidden = true
            }
            else
            {
                cell.bottomSepreatorLabel.isHidden = false
            }
            
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: getHelpAllTopicsTableCell, for: indexPath) as! GetHelpAllTopicsTableCell
            let dic = self.getHelpTopicObj?.all_topics?[indexPath.row]
            cell.titleLabel.text = dic?.name
            
            if indexPath.row == topicArray.count - 1
            {
                cell.bottomSepreatorLabel.isHidden = true
            }
            else
            {
                cell.bottomSepreatorLabel.isHidden = false
            }
            
            return cell
        }
        else if indexPath.section == 3
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: getHelpAllTopicsTableCell, for: indexPath) as! GetHelpAllTopicsTableCell
            let dic = self.getHelpSubjectObj?.help_subjects?[indexPath.row]
            cell.titleLabel.text = dic?.name
            
            if indexPath.row == topicArray.count - 1
            {
                cell.bottomSepreatorLabel.isHidden = true
            }
            else
            {
                cell.bottomSepreatorLabel.isHidden = false
            }
            
            return cell
        }
        else if indexPath.section == 4
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: getHelpMessageTableCell, for: indexPath) as! GetHelpMessageTableCell
            self.messageStr = cell.msgTextField.text ?? ""
            return cell
        }
//        else if indexPath.section == 3
//        {
//            let cell = tableView.dequeueReusableCell(withIdentifier: getHelpMessageTableCell, for: indexPath) as! GetHelpMessageTableCell
////            cell.msgTextField.layer.cornerRadius = 0
//            cell.msgTextField.layer.borderColor = UIColor.clear.cgColor
//            cell.msgTextField.layer.borderWidth = 0.0
//            cell.msgTextField.placeholder = "Message"
//            return cell
//        }
        
        return UITableViewCell()
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 25
//}
    
    
    @objc func onClickSubmitBtn(_sender : UIButton)
    {
        print("Submit Button")
        
        print(self.messageStr)
        
        if self.subjectId == 000
        {
            Alert.showH(titleStr: "", messageStr: "Please select subject")
        }
        else if self.messageStr == ""
        {
            Alert.showH(titleStr: "", messageStr: "Please write message")
        }
        else
        {
            submitHelpRequestApi()
        }
        self.messageStr = ""
    }
    
    
    @objc func onClickCancelBtn(_sender : UIButton)
    {
        print("Cancel Button")
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 0
        {
            let dic = self.getHelpTopicObj?.recommonded_topics?[indexPath.row]
            self.headerTitleArray[0] = dic?.name ?? ""
            isExpanded[0] = !isExpanded[0]
            tableView.reloadSections(IndexSet.init(integer: 0), with: .automatic)
        }
        else if indexPath.section == 1
        {
            let dic = self.getHelpTopicObj?.all_topics?[indexPath.row]
            self.headerTitleArray[1] = dic?.name ?? ""
            isExpanded[1] = !isExpanded[1]
            tableView.reloadSections(IndexSet.init(integer: 1), with: .automatic)
        }
        else if indexPath.section == 3
        {
            let dic = self.getHelpSubjectObj?.help_subjects?[indexPath.row]
            self.subjectId = dic?.id ?? 000
            self.headerTitleArray[3] = dic?.name ?? ""
            isExpanded[3] = !isExpanded[3]
            tableView.reloadSections(IndexSet.init(integer: 3), with: .automatic)
        }
    }
    
}

extension GetHelpVC
{
    func getHelpTopicApi()
     {
         let param:[String:String] = ["":""]
                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getHelpTopics, params: param , method: .get) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.getHelpTopicObj = try JSONDecoder().decode(HelpTopic_Struct.self, from: data)
                             self.getHelpSubjectApi()
                           
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
    
    func getHelpSubjectApi()
     {
         let param:[String:String] = ["":""]
                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getHelpSubjects, params: param , method: .get) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.getHelpSubjectObj = try JSONDecoder().decode(HelpSubject_Struct.self, from: data)
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
    
    func submitHelpRequestApi()
     {
         let param:[String:Any] = ["subject_id":self.subjectId,"message": self.messageStr]
                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.submitHelpRequest, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.submitHelpObj = try JSONDecoder().decode(Get_Status.self, from: data)
                             Alert.alert_PopMathod(vc: self, title: "Help", message_Str: self.submitHelpObj.message, action_Title: ["Ok"], action_Style: [.default], action: [({
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

extension GetHelpVC: UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField) {
   print("TextField did end editing method called")

        if !(textField.text!.isEmpty) // check textfield contains value or not
    {
        self.messageStr = textField.text ?? ""
    }

   func textFieldShouldReturn(textField: UITextField) -> Bool {

   textField.resignFirstResponder();
   return true;
   }

     func textFieldDidBeginEditing(textField: UITextField!) {
         self.messageStr = ""
     }
    }
}
