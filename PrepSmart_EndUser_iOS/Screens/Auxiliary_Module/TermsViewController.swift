//
//  TermsViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 06/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen id : PSTMOBSTD014

import UIKit

class TermsViewController: BaseViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    var termsArray : [String] = []
    var global_Var = GlobalClass.sharedManager
    
    let termsHeaderTableCell = "TermsHeaderTableCell"
    var sectionToggleArray:[Bool] = [false,false,false,false]
    var privacyPolicyObj : PrivacyPolicy_Struct?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.privacyPolicyApi()
        self.initiolizer()
    }
    
    func initiolizer() {
        
      //  self.navigationItem.titleView = UtilityManager.getTitleLabel("Terms")
         self.navigationItem.titleView = UtilityManager.getTitleLabel("Food Interests")
        //termsArray = ["Terms of Service", "Payments Terms of Service", "Privacy Policy"]
        tableView.register(UINib(nibName: termsHeaderTableCell, bundle: .none), forCellReuseIdentifier: termsHeaderTableCell)
    }
    
    //    MARK: OnClick Func
    @objc func toggle(_ sender: UIButton) {
        for (i,_) in self.sectionToggleArray.enumerated() {
            if i != sender.tag {
                self.sectionToggleArray[i] = false //!self.sectionToggleArray[sender.tag]
            }
        }
        self.sectionToggleArray[sender.tag] = !self.sectionToggleArray[sender.tag]
        //        UIView.performWithoutAnimation {
        
        tableView.reloadSections(IndexSet(integersIn: 0..<(termsArray.count)), with: .automatic)
        let index = IndexPath.init(row: NSNotFound, section: sender.tag)
        tableView.scrollToRow(at: index, at: .top, animated: true)
    }
}

extension TermsViewController : UITableViewDelegate, UITableViewDataSource {
    
    //        MARK: TableView Delegate, Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return termsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionToggleArray[section] {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: termsHeaderTableCell, for: indexPath) as! TermsHeaderTableCell
        
        let dic = self.privacyPolicyObj?.content?[indexPath.row]
        
       // cell.titleLabel.text = dic?.content_data
        cell.setData(setHeader: dic?.content_data ?? "", sideImageWidth: 0.0, sideImageHeight: 0.0, sideImage: UIImage())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.viewForHeaderInSection(section: section).frame.height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func viewForHeaderInSection(section:Int) -> UIView {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: termsHeaderTableCell) as! TermsHeaderTableCell
        cell.setData(setHeader: termsArray[section], sideImageWidth: 20.0, sideImageHeight: 20.0, sideImage:#imageLiteral(resourceName: "forward_arrow_black"))
        
        cell.toggleButton.tag = section
        cell.toggleButton.addTarget(self, action: #selector(self.toggle(_:)), for: .touchUpInside)
        
        if sectionToggleArray[section] {
            cell.sideImageView.image = #imageLiteral(resourceName: "up_arrow_dark")
        }
        else {
            cell.sideImageView.image = #imageLiteral(resourceName: "drop_arrow_dark")
        }
        
        return cell.contentView
    }
}

extension TermsViewController
{
    func privacyPolicyApi()
     {
         let param:[String:String] = ["": "" ]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getContents, params: param , method: .get) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.privacyPolicyObj = try JSONDecoder().decode(PrivacyPolicy_Struct.self, from: data)
                             for i in self.privacyPolicyObj?.content ?? []
                             {
                                 self.termsArray.append(i.title ?? "")
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
