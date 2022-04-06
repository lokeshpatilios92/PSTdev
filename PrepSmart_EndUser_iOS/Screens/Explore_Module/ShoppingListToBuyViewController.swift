//
//  ShoppingListToBuyViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 09/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//
//Screen Id :- PSTMOBSTD069,PSTMOBSTD070

import UIKit
import DropDown

class ShoppingListToBuyViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var sortByTextFiled: UITextField!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var expandColapsButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var bottomSavetimeButtonView: UIView!
    @IBOutlet weak var bottomDeleteButtonView: UIView!
    @IBOutlet weak var ButtonDelete: UIButton!
    
    var sortByDropDown = DropDown()
    @IBOutlet weak var viewTopFilters: UIView!
    
    var isExpanded : [Bool]! = []
    var selectedButton : UIButton!
    var selectedSectionButton = 0
    var deleteItem : Int?
    var global_Var = GlobalClass.sharedManager
    var shoppingListObj: ShoppingList_Struct?
    var DownloadShopListObj: DownloadShopListStruct?
    let shoppingListToBuyTableCell = "ShoppingListToBuyTableCell"
    let shoppingListToBuyTableHeaderCell = "ShoppingListToBuyTableHeaderCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    func initialize() {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Shopping List")
        bottomButton.layer.cornerRadius = bottomButton.frame.height / 2
        ButtonDelete.layer.cornerRadius = ButtonDelete.frame.height / 2
        let addDownload = UIBarButtonItem(image: #imageLiteral(resourceName: "download_white_icon"), style: .done, target: self, action: #selector(didTapdownLoadButton(sender:)))
        let shareButton = UIBarButtonItem(image: #imageLiteral(resourceName: "share_white_icon"), style: .done, target: self, action: #selector(didTapShareButton(sender:)))
        
        self.navigationItem.rightBarButtonItems = [addDownload,shareButton]
        
        addButton.layer.cornerRadius = addButton.frame.height / 2
        topLeftButton.layer.cornerRadius = 5//topLeftButton.frame.height / 2
        topRightButton.layer.cornerRadius = 5//topRightButton.frame.height / 2
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.placeholder = " Search"
        searchBar.sizeToFit()
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: .search, state: .normal)
        searchBar.layer.cornerRadius = 24.0
        searchBar.backgroundImage = UIImage()
        searchBar.clipsToBounds = true
        searchBar.layer.borderColor = UIColor.black.cgColor
        searchBar.layer.borderWidth = 0.5
        let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor.white
        searchBar.backgroundColor = UIColor.white
        
        self.topRightButton.addTarget(self, action: #selector(self.onClickTopButtons(_:)), for: .touchUpInside)
        self.topLeftButton.addTarget(self, action: #selector(self.onClickTopButtons(_:)), for: .touchUpInside)
        self.filterButton.addTarget(self, action: #selector(self.onClickFilterButton(_:)), for: .touchUpInside)
        self.bottomButton.addTarget(self, action: #selector(self.onClickBottomButton(_:)), for: .touchUpInside)
        self.ButtonDelete.addTarget(self, action: #selector(self.onClickDeleteAllAction(_:)), for: .touchUpInside)
        self.addButton.addTarget(self, action: #selector(self.onClickAddAction(_:)), for: .touchUpInside)

        self.selectedButton = topLeftButton
        self.sortByDropDown.backgroundColor = UIColor.white
        
        DropDown.startListeningToKeyboard()
        sortByTextFiled.text = "A-Z"
        sortByDropDown.dataSource = ["Day","Recipe","Store isle","A-Z"]
        self.alreadyHaveShopListApi()
        self.getShoppingListApi()
    }
    
    //    MARK: onClick Func
    @objc func onClickExpandCollapse(_ sender : UIButton) {
        isExpanded[sender.tag] = !isExpanded[sender.tag]
        tableView.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
    }
    @objc func didTapdownLoadButton(sender: AnyObject){
        print("Download")
        downLoadShopListApi()
    }
    
    @objc func didTapShareButton(sender: AnyObject){
        print("Share")
    }
    @objc func onClickTopButtons(_ sender : UIButton) {
        if sender == self.topRightButton {
            self.topRightButton.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
            self.topLeftButton.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.35)
            alreadyHaveShopListApi()
            selectedSectionButton = 1
            viewTopFilters.isHidden = true
            bottomSavetimeButtonView.isHidden = true
            bottomDeleteButtonView.isHidden = false
        } else {
            self.topLeftButton.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
            self.topRightButton.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.35)
            getShoppingListApi()
            selectedSectionButton = 0
            viewTopFilters.isHidden = false
            bottomSavetimeButtonView.isHidden = false
            bottomDeleteButtonView.isHidden = true
        }
        selectedButton = sender
        tableView.reloadData()
    }
    
    
    @objc func onClickFilterButton(_ sender : UIButton){
        
        let vc =  UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        vc.FilterDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sortByClicked(_ sender: UIButton) {
        sortByDropDown.anchorView = self.sortByTextFiled
        sortByDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.sortByTextFiled.text = item
        }
        sortByDropDown.width = self.sortByTextFiled.frame.width
        sortByDropDown.show()
        
    }
    
    
    
    //Mark:- BottomButtonAction
    @objc func onClickBottomButton(_ sender : UIButton) {
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "ShopNowVC") as! ShopNowVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //Mark:- ButtonADeleteAllAction
    @objc func onClickDeleteAllAction(_ sender : UIButton) {
        print("Delete All Pressed")
            // self.TwoButtonAndNoteDelegate(title: "You can also uncheck items to move them back onto the To Buy list if they are still needed.", note: "Are you sure you want to remove all items from this shopping List?", customDelegate: self)
        self.TwoButtonAndNoteDelegate(title: "Deleting this ingredient removes it from this shopping list all togather.Do you want to procceed?", note: "Note: Use the check box feature as you purchase ingredients which moves them to the Already Have list for later viewing ", customDelegate: self)
    }
    //Mark:- ButtonAddAction
    @objc func onClickAddAction(_ sender : UIButton) {
        searchIngredientForShopApi()
    }
    
}

extension ShoppingListToBuyViewController : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return selectedSectionButton == 0 ? self.shoppingListObj?.shopping_list?.count ?? 0 : self.shoppingListObj?.alreadyHaveList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSectionButton == 0 {
            if  self.shoppingListObj?.shopping_list?[section].grocery_list?.count != nil
            {
                return self.shoppingListObj?.shopping_list?[section].grocery_list?.count ?? 0
            }
        } else {
            if  self.shoppingListObj?.alreadyHaveList?[section].grocery_list?.count != nil
            {
                return self.shoppingListObj?.alreadyHaveList?[section].grocery_list?.count ?? 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shoppingListToBuyTableCell, for: indexPath) as! ShoppingListToBuyTableCell
        let dic = selectedSectionButton == 0 ? self.shoppingListObj?.shopping_list?[indexPath.section].grocery_list?[indexPath.row] : self.shoppingListObj?.alreadyHaveList?[indexPath.section].grocery_list?[indexPath.row]
        cell.titleLabel.text = dic?.name
        cell.dicLabel.text = dic?.recipes_names
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(onClickDeleteButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewCell = tableView.dequeueReusableCell(withIdentifier: shoppingListToBuyTableHeaderCell) as! ShoppingListToBuyTableHeaderCell
        if self.shoppingListObj?.shopping_list?.count ?? 0 > 0{
            let dict = self.shoppingListObj?.shopping_list?[section]
            if isExpanded[section] {
                headerViewCell.sideImage.image = #imageLiteral(resourceName: "up_arrow_white")
            }
            else {
                headerViewCell.sideImage.image = #imageLiteral(resourceName: "drop_arrow_white")
            }
            headerViewCell.headerTitleLabel.text = dict?.category_name ?? ""
            headerViewCell.toggleButton.tag = section
            headerViewCell.toggleButton.addTarget(self, action: #selector(onClickExpandCollapse(_:)), for: .touchUpInside)
        }
        return headerViewCell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .groupTableViewBackground
        return view
    }
    
    @objc func onClickDeleteButton(_ sender : UIButton){
       deleteItem = sender.tag
        self.TwoButtonAndNoteDelegate(title: "Deleting this ingredient removes it from this shopping list all togather.Do you want to procceed?", note: "Note: Use the check box feature as you purchase ingredients which moves them to the Already Have list for later viewing ", customDelegate: self)
    }
}

extension ShoppingListToBuyViewController : TwoButtonAndNotePopUpDelegate {
    func onClcikDeleteButton() {
        //self.removeAnimation()
        print("delete all pressed")
    }
}

extension ShoppingListToBuyViewController
{
    func getShoppingListApi()
    {
        let param:[String:String] = ["": ""]
        
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getShoppingList, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.shoppingListObj = try JSONDecoder().decode(ShoppingList_Struct.self, from: data)
                            let count = self.shoppingListObj?.shopping_list?.count ?? 0
                            for _ in 0..<count{
                                self.isExpanded.append(false)
                            }
                            self.topLeftButton.setTitle("To Buy (\(count))", for: .normal)
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
    
    func alreadyHaveShopListApi()
    {
        let param:[String:String] = ["": ""]
        
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.alreadyHaveShopList, params: param , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.shoppingListObj = try JSONDecoder().decode(ShoppingList_Struct.self, from: data)
                            let count = self.shoppingListObj?.alreadyHaveList?.count ?? 0
                            self.topRightButton.setTitle("Alread Have (\(count))", for: .normal)
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
    
    func searchIngredientForShopApi()
    {
        let param:[String:String] = ["query": searchBar.text ?? ""]
        
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.searchIngredientForShop, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.shoppingListObj = try JSONDecoder().decode(ShoppingList_Struct.self, from: data)
                            self.shoppingListObj?.shopping_list? = self.shoppingListObj?.searchShoppingList ?? [Shopping_list]()
                            self.tableView.reloadData()
                        }
                        catch
                        {
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                            
                        }
                    }
                    else
                    {
                        Alert.showToast(message: self.global_Var.get_status.message, view_VC: self)
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
    func downLoadShopListApi()
    {
        let param:[String:String] = ["": ""]
        
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.downloadShopList, params: param , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.DownloadShopListObj = try JSONDecoder().decode(DownloadShopListStruct.self, from: data)
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: self.DownloadShopListObj?.original?.message ?? "")
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
    
    func getFilterWiseShoppingListApi(filterflag:String, startDate:String, endDate:String, SpecificDays:String) {
        
        let param:[String:String] = ["filter_flag": filterflag,
                                     "start_date": startDate,
                                     "end_date" : endDate,
                                     "specific_days": SpecificDays]
        print("param \(param)")
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getFilterWiseShoppingList, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.shoppingListObj = try JSONDecoder().decode(ShoppingList_Struct.self, from: data)
                           self.tableView.reloadData()
                        }
                        catch
                        {
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                            
                        }
                    }
                    else
                    {
                        Alert.showToast(message: self.global_Var.get_status.message, view_VC: self)
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

extension ShoppingListToBuyViewController : CustomSpecifyDaysVCDelegate {
    func onClickApplyButton(filterType: String, startdate: String, endDate: String, specificDays: String) {
if filterType != ""{
        getFilterWiseShoppingListApi(filterflag: filterType, startDate: startdate, endDate: endDate,SpecificDays: specificDays )
        }
    }
}

//MARK: TableView Cell
class ShoppingListToBuyTableHeaderCell : UITableViewCell {
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var sideImage: UIImageView!
    @IBOutlet weak var toggleButton : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}



class ShoppingListToBuyTableCell : UITableViewCell {
    @IBOutlet weak var checkBoxView: BEMCheckBox!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dicLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxView.boxType = .square
    }
    
}


