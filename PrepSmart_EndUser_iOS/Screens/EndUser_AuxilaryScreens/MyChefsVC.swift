//
//  MyChefsVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 02/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SVProgressHUD

class MyChefsVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var feedViewBtn: UIButton!
    @IBOutlet weak var wifiBtn: UIButton!
    
    @IBOutlet weak var searchBarView: UIView!
    var childNumber: String = ""
    var exploreChefCell = "ExploreChefCell"
    var feedCell = "FeedCell"
    
    var whichCellToShow = 0 //0:Profile cell 1: Feed Cell
    var getChefObj : GetChef_Struct?
    var getChefObj2 : GetChef_Struct?
    var myChefObj: MyChef_Struct?
    var myChefObj2: MyChef_Struct?
    var global_Var = GlobalClass.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializer()
    }
    func initializer(){
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("My Chefs")
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = .white
        searchBar.isTranslucent = true
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBarView.layer.borderWidth = 0.50
        searchBarView.layer.cornerRadius = searchBarView.frame.height / 2
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: UISearchBar.Icon.search, state: .normal)
        
        tableView.register(UINib(nibName: exploreChefCell, bundle: .none), forCellReuseIdentifier: exploreChefCell)
        tableView.register(UINib(nibName: feedCell, bundle: .none), forCellReuseIdentifier: feedCell)
        feedViewBtn.layer.cornerRadius = feedViewBtn.frame.height/2
        
        bgImage.isHidden = true
        self.myChefApi()
        self.getAllChefApi()
    }
    
    @IBAction func feedViewTapped(_ sender: UIButton) {
        if feedViewBtn.currentTitle == "Profile View"{
            feedViewBtn.setTitle("Feed View", for: .normal)
            whichCellToShow = 0
            searchBar.text = nil
            myChefApi()
            
        } else {
            whichCellToShow = 1
            feedViewBtn.setTitle("Profile View", for: .normal)
            searchBar.text = nil
            getAllChefApi()
        }
    }
    
    @IBAction func wifiTapped(_ sender: UIButton) {
        
    }
    
    @objc func onClickviewProfileBtn(_ sender : UIButton){
        let dic = getChefObj?.chef_list?[sender.tag]
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "ChefProfileViewController") as! ChefProfileViewController
        vc.chefId = dic?.chef_id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyChefsVC : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if whichCellToShow == 0
        {
            return self.getChefObj?.chef_list?.count ?? 0
        }
        else
        {
            return self.myChefObj?.recipeList?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if whichCellToShow == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: exploreChefCell, for: indexPath) as! ExploreChefCell
            let dic = self.getChefObj?.chef_list?[indexPath.row]
            
            cell.Lbl_name.text = dic?.name
            cell.profilePic.sd_setImage(with: URL(string: dic?.chef_pic ?? ""), placeholderImage: UIImage(named: "dinner"))
            cell.profilePic.layer.cornerRadius = cell.profilePic.frame.height/2
            cell.recipesCountLbl.text = String(dic?.total_recipes ?? 0)
            cell.blogsCountLbl.text = String(dic?.total_blog ?? 0)
            cell.subscribersCountLbl.text = String(dic?.total_subscribers ?? 0)
            cell.viewProfileBtn.tag = indexPath.row
            cell.viewProfileBtn.addTarget(self, action: #selector(self.onClickviewProfileBtn(_:)), for: .touchUpInside)
            if let rating = dic?.avg_ratings! {
                switch rating {
                case .integer(let int):
                    cell.ratingView.rating  = Double(int)
                case .string(let string):
                    cell.ratingView.rating = Double(string) ?? 0.0
                }
            }
            cell.ratingCount.text = "( " + String(dic?.total_ratings ?? 0) + " )"
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: feedCell, for: indexPath) as! FeedCell
            let dic = self.myChefObj?.recipeList?[indexPath.row]
            
            cell.titleLbl.text = dic?.item_title
            cell.dateLbl.text = convertDateFormater(date: dic?.added_date ?? "")
            cell.profilePic.sd_setImage(with: URL(string: dic?.item_image ?? ""), placeholderImage: UIImage(named: "dinner"))
            //   cell.cosmosView.rating = Double(dic?.ratting! )
            if let rating = dic?.ratting! {
                switch rating {
                case .integer(let int):
                    cell.cosmosView.rating = Double(int)
                case .string(let string):
                    cell.cosmosView.rating = Double(string) ?? 0.0
                }
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if whichCellToShow == 1{
            let dic = self.myChefObj?.recipeList?[indexPath.row]
            let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "ViewRecipeViewController") as! ViewRecipeViewController
            vc.recipeId = String(dic?.item_id ?? 0)
            vc.recipeOwnerId = String(dic?.chef_id ?? 0)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
}
extension MyChefsVC : IndicatorInfoProvider{
    
    //    MARK: XLPagerTabStrip
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(childNumber)")
    }
}

extension MyChefsVC
{
    
    //MARK:-  All Chef API Calling
    func getAllChefApi()
    {
        let param:[String:Any] = ["start_index":"0",
                                  "type": "1",
                                  "record_count":"100"]
        SVProgressHUD.show()
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getChef, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        // SVProgressHUD.dismiss()
                        Loader.sharedInstance.hideIndicator()
                        Loader.sharedInstance.hideIndicator()
                        
                        do {
                            self.getChefObj = try JSONDecoder().decode(GetChef_Struct.self, from: data)
                            self.getChefObj2 = self.getChefObj
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
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
                // SVProgressHUD.dismiss()
                Loader.sharedInstance.hideIndicator()
                break
                
            case .failer(let error):
                
                Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                SVProgressHUD.dismiss()
                Loader.sharedInstance.hideIndicator()
                break
            }
        }
    }
    
    //MARK:-  My Chef API Calling
    func myChefApi()
    {
        let param:[String:Any] = ["":""]
        SVProgressHUD.show()
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.myChef, params: param , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        Loader.sharedInstance.hideIndicator()
                        SVProgressHUD.dismiss()
                        do {
                            self.myChefObj = try JSONDecoder().decode(MyChef_Struct.self, from: data)
                            self.myChefObj2 =  self.myChefObj
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
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
                SVProgressHUD.dismiss()
                Loader.sharedInstance.hideIndicator()
                break
                
            case .failer(let error):
                
                Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                SVProgressHUD.dismiss()
                Loader.sharedInstance.hideIndicator()
                break
            }
        }
    }
}


extension MyChefsVC: UISearchBarDelegate{
    
    func searchBar(_ Searchbar: UISearchBar, textDidChange searchText: String) {
        if whichCellToShow == 0{
            if searchText.count == 0
            {
                getChefObj?.chef_list = getChefObj2?.chef_list
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            else if searchText.count >= 1
            {
                getChefObj?.chef_list =  getChefObj2?.chef_list?.filter({( Obj : Chef_list) -> Bool in
                    return Obj.name!.contains(searchText)
                })
                self.tableView.reloadData()
            }
        }
        else{
            if searchText.count == 0
            {
                myChefObj?.recipeList = myChefObj2?.recipeList
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            else if searchText.count >= 1
            {
                myChefObj?.recipeList =  myChefObj2?.recipeList?.filter({( Obj : RecipeList) -> Bool in
                    return Obj.item_title!.contains(searchText) || (Obj.item_label?.contains(searchText))!
                })
                self.tableView.reloadData()
            }
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton = true
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        
        searchBar.showsCancelButton = false
        // searchBar.text = ""
        searchBar.resignFirstResponder()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        load_Table_Search()
    }
    
    func load_Table_Search()
    {
        if whichCellToShow == 0{
            getChefObj?.chef_list = getChefObj2?.chef_list
        }
        else{
            self.myChefObj?.recipeList = self.myChefObj2?.recipeList
        }
        DispatchQueue.main.async
        {
            self.tableView.reloadData()
        }
    }
}
