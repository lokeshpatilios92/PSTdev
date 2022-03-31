//
//  FAQViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sanket on 05/02/20.
//  Copyright © 2020 Exceptionaire.co. All rights reserved.
//

import UIKit

class FAQViewController: BaseViewController {

    @IBOutlet weak var tblView_FAQ: UITableView!
    
    var faqCell = "FAQTableViewCell"
    var isexpanded = [true,false,false,false,false,false]
    var getFAQObj : FAQStruct?
    var global_Var = GlobalClass.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.titleView = UtilityManager.getTitleLabel("FAQs")
        
        tblView_FAQ.delegate = self
        tblView_FAQ.dataSource = self
        
        tblView_FAQ.register(UINib(nibName: faqCell, bundle: .none), forCellReuseIdentifier: faqCell)
        self.getFAQApi()
    }

}

extension FAQViewController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getFAQObj?.faq_list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: faqCell, for: indexPath) as! FAQTableViewCell
        let dic = getFAQObj?.faq_list?[indexPath.row]
        
        cell.lbl_question.text = dic?.faq_question
        cell.lbl_answer.text = dic?.faq_answer
        cell.view_bottom.isHidden = !isexpanded[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isexpanded[indexPath.row] = !isexpanded[indexPath.row]
        tableView.reloadData()
    }
    
}

extension FAQViewController
{
    func getFAQApi()
     {
         let param:[String:String] = ["":""]
                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getFAQ, params: param , method: .get) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.getFAQObj = try JSONDecoder().decode(FAQStruct.self, from: data)
                             self.tblView_FAQ.reloadData()
                           
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
