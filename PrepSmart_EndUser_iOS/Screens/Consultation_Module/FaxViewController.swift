//
//  FaxViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sanket ETPL on 12/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

//  Screen ID - PSTMOBSTD075

import UIKit
import DropDown

class FaxViewController: UIViewController {
    
    @IBOutlet weak var btn_currentOrder: UIButton!
    @IBOutlet weak var btn_yourItems: UIButton!
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var txtFld_search: UITextField!
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var tblView_product: UITableView!
    @IBOutlet weak var table_ht: NSLayoutConstraint!
    @IBOutlet weak var btn_addNew: UIButton!
    @IBOutlet weak var txt_restaurant: UILabel!
    @IBOutlet weak var txt_state: UILabel!
    @IBOutlet weak var txt_city: UILabel!
    var restaurantDropDown = DropDown()
    var stateDropDown = DropDown()
    var cityDropDown = DropDown()
    
    var global_Var = GlobalClass.sharedManager
    var restaurantListObj: RestaurantList_Struct?
    var stateListObj: StateList_Struct?
    var cityListObj: CityList_Struct?
    var faxOrderHistoryObj: FaxOrderHistory_Struct?
    
    let yourItemsCell = "YourItemsTableViewCell"
    let currentItemsCell = "CurrentOrderItemTableViewCell"
    let yourItemsNotAvailable = "YourItemsNotAvailableTableViewCell"
    
    var yourItemCount = 6
    var currOrderCount = 3
    var isCurrentOrderSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    func initialize()
    {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Fax Details")
        btn_currentOrder.clipsToBounds = true
        btn_currentOrder.layer.cornerRadius = 4.0
        btn_currentOrder.layer.borderColor = UIColor.appOrangeColor().cgColor
        btn_currentOrder.layer.borderWidth = 0.5
        
        btn_yourItems.clipsToBounds = true
        btn_yourItems.layer.cornerRadius = 4.0
        btn_yourItems.layer.borderColor = UIColor.appOrangeColor().cgColor
        btn_yourItems.layer.borderWidth = 0.5
        
        btn_next.clipsToBounds = true
        btn_next.layer.cornerRadius = btn_next.frame.height / 2
        btn_next.addTarget(self, action: #selector(nextButtonMethod(sender:)), for: .touchUpInside)
        //btn_next.layer.borderColor = UIColor.gray.cgColor
        //btn_next.layer.borderWidth = 0.5
        
        view_search.clipsToBounds = true
        view_search.layer.cornerRadius = view_search.frame.height / 2
        view_search.layer.borderColor = UIColor.gray.cgColor
        view_search.layer.borderWidth = 0.5
        
        btn_addNew.clipsToBounds = true
        btn_addNew.layer.cornerRadius = btn_addNew.frame.height / 2
        btn_addNew.isHidden = true
        
        restaurantDropDown.backgroundColor = UIColor.white
        cityDropDown.backgroundColor = UIColor.white
        stateDropDown.backgroundColor = UIColor.white
        DropDown.startListeningToKeyboard()
        
        tblView_product.register(UINib.init(nibName: yourItemsCell, bundle: nil), forCellReuseIdentifier: yourItemsCell)
        
        tblView_product.register(UINib.init(nibName: yourItemsNotAvailable, bundle: nil), forCellReuseIdentifier: yourItemsNotAvailable)
        
        tblView_product.register(UINib.init(nibName: currentItemsCell, bundle: nil), forCellReuseIdentifier: currentItemsCell)
        //self.view.layoutIfNeeded()
        self.tblView_product.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        restaurantListApi()
        getStateApi()
        faxOrderHistoryApi()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tblView_product.layer.removeAllAnimations()
        table_ht.constant = tblView_product.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.tblView_product.updateConstraints()
            self.tblView_product.layoutIfNeeded()
        }
    }
    
    override func viewDidLayoutSubviews() {
        //tblView_product.reloadData()
        
    }
    
    @objc func nextButtonMethod(sender: UIButton)
    {
        let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "FaxDetailsVC") as! FaxDetailsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickToggle(_ sender: UIButton) {
        if sender == btn_currentOrder
        {
            isCurrentOrderSelected = true
            
            btn_currentOrder.setTitleColor(UIColor.white, for: .normal)
            btn_currentOrder.backgroundColor = UIColor.appOrangeColor()
            
            btn_yourItems.setTitleColor(UIColor.appOrangeColor(), for: .normal)
            btn_yourItems.backgroundColor = UIColor.white
            
            btn_addNew.isHidden = false
        }
        else
        {
            isCurrentOrderSelected = false
            btn_yourItems.setTitleColor(UIColor.white, for: .normal)
            btn_yourItems.backgroundColor = UIColor.appOrangeColor()
            
            btn_currentOrder.setTitleColor(UIColor.appOrangeColor(), for: .normal)
            btn_currentOrder.backgroundColor = UIColor.white
            
            btn_addNew.isHidden = true
        }
        tblView_product.reloadData()
    }
    
    @IBAction func restaurantDropDownClicked(_ sender: UIButton) {
        restaurantDropDown.anchorView = self.txt_restaurant
        restaurantDropDown.textFont = UIFont.REGULAR_FONT()
        
        restaurantDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txt_restaurant.text = item
            
        }
        
        self.txt_restaurant.resignFirstResponder()
        restaurantDropDown.show()
    }
    
    @IBAction func stateDropDownClicked(_ sender: UIButton) {
        stateDropDown.anchorView = self.txt_state
        stateDropDown.textFont = UIFont.REGULAR_FONT()
        
        stateDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txt_state.text = item
            if item == self.stateListObj?.state_list?[index].name
            {
                self.cityDropDown.dataSource.removeAll()
                let id = self.stateListObj?.state_list?[index].id
                self.getCityApi(stateId: id ?? 0)
                
            }
            
        }
        
        self.txt_state.resignFirstResponder()
        stateDropDown.show()
    }
    
    @IBAction func cityDropDownClicked(_ sender: UIButton) {
        cityDropDown.anchorView = self.txt_city
        cityDropDown.textFont = UIFont.REGULAR_FONT()
        
        cityDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txt_city.text = item
            
        }
        
        self.txt_city.resignFirstResponder()
        cityDropDown.show()
    }
}

extension FaxViewController : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isCurrentOrderSelected
        {
            if currOrderCount > 0
            {
                return currOrderCount
            }
        }
        else
        {
            if yourItemCount > 0
            {
                return self.faxOrderHistoryObj?.order_history?.count ?? 0
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isCurrentOrderSelected
        {
            if currOrderCount > 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: currentItemsCell, for: indexPath) as! CurrentOrderItemTableViewCell
                
                
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: yourItemsNotAvailable, for: indexPath) as! YourItemsNotAvailableTableViewCell
                return cell
            }
        }
        else
        {
            if yourItemCount > 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: yourItemsCell, for: indexPath) as! YourItemsTableViewCell
                
                let dic = self.faxOrderHistoryObj?.order_history?[indexPath.row]
                
                cell.itemIdLabel.text = String(dic?.id ?? 0)
                cell.itemNameLabel.text = dic?.ingredient_name
                cell.currentPriceLabel.text = String(dic?.price ?? 0)
                cell.estimatedPriceLabel.text = String(dic?.price ?? 0)
                
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: yourItemsNotAvailable, for: indexPath) as! YourItemsNotAvailableTableViewCell
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension FaxViewController
{
    func restaurantListApi()
    {
        let param:[String:Any] = ["":""]
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.listOfRestaurantDepot, params: param , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.restaurantListObj = try JSONDecoder().decode(RestaurantList_Struct.self, from: data)
                            if self.restaurantDropDown.dataSource != [""]
                            {
                                for i in self.restaurantListObj?.restaurant_depo_list ?? []
                                {
                                    self.restaurantDropDown.dataSource.append(i.depo_name ?? "")
                                }
                            }
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
    
    func getStateApi()
    {
        let param:[String:Any] = ["":""]
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getStateList, params: param , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.stateListObj = try JSONDecoder().decode(StateList_Struct.self, from: data)
                            if self.restaurantDropDown.dataSource != [""]
                            {
                                for i in self.stateListObj?.state_list ?? []
                                {
                                    self.stateDropDown.dataSource.append(i.name ?? "")
                                }
                            }
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
    
    func getCityApi(stateId: Int)
    {
        let param:[String:Any] = ["state_id":stateId]
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getCityList, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.cityListObj = try JSONDecoder().decode(CityList_Struct.self, from: data)
                            if self.cityDropDown.dataSource != [""]
                            {
                                for i in self.cityListObj?.city_list ?? []
                                {
                                    self.cityDropDown.dataSource.append(i.name ?? "")
                                }
                            }
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
    
    func faxOrderHistoryApi()
    {
        let param:[String:Any] = ["":""]
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.faxOrderHistory, params: param , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.faxOrderHistoryObj = try JSONDecoder().decode(FaxOrderHistory_Struct.self, from: data)
                            self.tblView_product.reloadData()
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
