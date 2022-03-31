//
//  ShopNowVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 13/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ShopNowVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var getYourGroceriesLabel: UILabel!
    @IBOutlet weak var choosePrefferedDeliveryLabel: UILabel!
    
    let shopNowTableCell = "ShopNowTableCell"
    
    let imgArray = ["insatcart","amazon fresh","amazon fresh","Layer 32","us foods","sysco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilization()
    }
    
    
    func initilization() {
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Shop Now")
        
        tableView.register(UINib.init(nibName: shopNowTableCell, bundle: nil), forCellReuseIdentifier: shopNowTableCell)
        
    }
}


extension ShopNowVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shopNowTableCell, for: indexPath) as! ShopNowTableCell
        cell.leftImage.image = UIImage(named: imgArray[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            self.showAlertWithOkButtonPopUpVC(setTitle: "Prepsmart Tip", setMessage: "You are just a couple step away from an Instacart grocery delivery! \n Please be sure to select the quantity of each ingredient to match the quantities displayed beneath the ingredient name before checking out.", setButtonTitle: "OK", customDelegate: self)
        }
        else if indexPath.row == 1{
            self.showAmazonLoginPopUpVC(customDelegate: self)
        }else if indexPath.row == 3{
            let vc = UIStoryboard.ConsultationsStoryboard.instantiateViewController(withIdentifier: "FaxViewController") as! FaxViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension ShopNowVC : CustomAlertWithOkButtonPopUpDelegate,CustomAmazonLoginPopUpDelegate {
    
    //AlertWithOkButtonPopUp Delegate Function
    func onClickOkButtonAction() {
        
    }
    
    //AmazonLoginPopUp Delegate Function
    func onClickLoginWithAmazon() {
        
    }
    
    //AmazonLoginPopUp Delegate Function
    func onClickCreateAmazonAccount() {
        
    }
    
    
}
