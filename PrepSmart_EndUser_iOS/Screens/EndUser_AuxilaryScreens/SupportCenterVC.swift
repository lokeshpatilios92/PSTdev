//
//  SupportCenterVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 30/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen id : PSTMOBSTD157

import UIKit


class SupportCenterVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var supportCentreCell = "SupportCentreCell"
    
    let titleArray = ["Get us feedback","Get help","FAQs"]
    let imageArray = ["send_feedback","contact_support","faq"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
        
    }
    
    func initializer(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Support Center")
        tableView.register(UINib(nibName: supportCentreCell, bundle: .none), forCellReuseIdentifier: supportCentreCell)
    }
    
}
extension SupportCenterVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: supportCentreCell, for: indexPath) as! SupportCentreCell
        cell.titleLbl.text = titleArray[indexPath.row]
        cell.imgView.image = UIImage(named: imageArray[indexPath.row])
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "GiveUsFeedbackVC") as! GiveUsFeedbackVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1{
            let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "GetHelpVC") as! GetHelpVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 2{
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
