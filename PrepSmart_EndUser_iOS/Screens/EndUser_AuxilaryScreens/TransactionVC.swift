//
//  TransactionVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 08/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD155-1

import UIKit

class TransactionVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let transactionCell = "TransactionCell"
    var global_Var = GlobalClass.sharedManager
    var transactionObj : Transaction_Struct?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       initializer()
    }
    

    func initializer(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Transactions")
        tableView.register(UINib(nibName: transactionCell, bundle: .none), forCellReuseIdentifier: transactionCell)
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = .white
        searchBar.isTranslucent = true
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 0.50
        searchBar.layer.cornerRadius = searchBar.frame.height / 2
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: UISearchBar.Icon.search, state: .normal)
        transactionApi()
    }

}

extension TransactionVC : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionObj?.transaction_history?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: transactionCell, for: indexPath) as! TransactionCell
        let dic = self.transactionObj?.transaction_history?[indexPath.row]
        
        cell.transactionIdLbl.text = "Transaction ID: \(dic?.transaction_id ?? "")"
        cell.priceLbl.text = "$\(String(dic?.cost ?? 0))"
        cell.dateLbl.text = "Date: \(convertDateFormater(date: dic?.date_time ?? ""))"
        
        if indexPath.row == 0{
            cell.recipeNameLbl.isHidden = true
        }else{
            cell.recipeNameLbl.isHidden = false
        }
        return cell
    }
    
    
}

extension TransactionVC
{
    func transactionApi()
     {

         let param:[String:String] = ["": ""]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getTransactions, params: param , method: .get) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.transactionObj = try JSONDecoder().decode(Transaction_Struct.self, from: data)
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
