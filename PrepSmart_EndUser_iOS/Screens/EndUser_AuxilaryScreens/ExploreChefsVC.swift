//
//  ExploreChefsVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 02/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Popover

class ExploreChefsVC: BaseViewController {
    
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var filterbtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var expandFilterBtn: UIButton!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var searchBarView: UIView!
    
    var exploreChefCell = "ExploreChefCell"
    var global_Var = GlobalClass.sharedManager
    var findNewRecipeObj : FindNewRecipe_Struct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
    }
    
    func initializer(){
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Explore Chefs")
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = .white
        searchBar.isTranslucent = true
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBarView.layer.borderWidth = 0.50
        searchBarView.layer.cornerRadius = searchBarView.frame.height / 2
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: UISearchBar.Icon.search, state: .normal)
        
        tableView.register(UINib(nibName: exploreChefCell, bundle: .none), forCellReuseIdentifier: exploreChefCell)
        
        
        expandFilterBtn.layer.cornerRadius = expandFilterBtn.frame.height/2
        
        editProfileBtn.layer.cornerRadius = editProfileBtn.frame.height/2
        editProfileBtn.layer.borderColor = UIColor.appOrangeColor().cgColor
        editProfileBtn.layer.borderWidth = 1
        self.findNewRecipeApi()
    }
    
    @IBAction func filterBtntapped(_ sender: UIButton) {
        print("On Click Add Filter")
        let blogFilter = self.instanceFromBlogFilterNib()//BlogFilter(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: 300))
        blogFilter.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        
        let popover = Popover(options: self.popoverOptions)
        popover.show(blogFilter, point: CGPoint(x: self.view.frame.width - (self.view.frame.width / 4), y: 65))
    }
    
    @IBAction func sortbtnTapped(_ sender: UIButton) {
        print("On Click Add Sort")
        let shortFilter = self.instanceFromShortListFilterNib()//BlogFilter(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: 300))
        shortFilter.frame = CGRect(x: 0, y: 0, width: 250, height: 350)
        
        let popover = Popover(options: self.popoverOptions)
        popover.show(shortFilter, point: CGPoint(x: self.view.frame.width - (self.view.frame.width / 5), y: 65))
    }
    
    @IBAction func expandFilterTapped(_ sender: UIButton) {
    }
    
    @IBAction func editProfileTapped(_ sender: UIButton) {
    }
    
    @objc func viewProfileTapped(_ sender:UIButton){
        let dic = self.findNewRecipeObj?.chefList?[sender.tag]
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "ChefProfileViewController") as! ChefProfileViewController
        vc.chefId = dic?.chef_id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension ExploreChefsVC : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.findNewRecipeObj?.chefList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: exploreChefCell, for: indexPath) as! ExploreChefCell
        let dic = self.findNewRecipeObj?.chefList?[indexPath.row]
        cell.viewProfileBtn.backgroundColor = .clear
        cell.viewProfileBtn.layer.borderColor = UIColor.appOrangeColor().cgColor
        cell.viewProfileBtn.layer.borderWidth = 0.5
        let value = "Subscribe for $\(dic?.monthly_subscription_cost ?? "0")/Mo"
        cell.subscribeBtn.isHidden = false
        cell.subscribeBtn.setTitle(value, for: .normal)
        cell.profilePic.roundCorners(.allCorners, radius: 35)
        cell.profilePic.sd_setImage(with: URL(string: dic?.chef_pic ?? ""), placeholderImage: UIImage(named: "dinner"))
        cell.Lbl_name.text = dic?.name
        cell.ratingCount.text = String(dic?.total_ratings ?? 0)
        cell.recipesCountLbl.text = String(dic?.total_recipes ?? 0)
        cell.blogsCountLbl.text = String(dic?.total_blog ?? 0)
        cell.subscribersCountLbl.text = String(dic?.total_subscribers ?? 0)
        
        var rattingvalue:Double = 0.0
        if let rating = dic?.avg_ratings {
            switch rating {
            case .integer(let int):
                rattingvalue = Double(int)
            case .string(let string):
                 rattingvalue  = Double(string) ?? 0.0
            }
        }
        cell.ratingView.rating = rattingvalue / 20
        cell.viewProfileBtn.setTitleColor(UIColor.appOrangeColor(), for: .normal)
        cell.viewProfileBtn.addTarget(self, action: #selector(self.viewProfileTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    
}
extension ExploreChefsVC
{
    func findNewRecipeApi()
    {
        let param:[String:Any] = ["start_index":"0",
                                  "type": "8",
                                  "expand_filter":"0",
                                  "record_count":"100"]
      Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.findNewRecipes, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.findNewRecipeObj = try JSONDecoder().decode(FindNewRecipe_Struct.self, from: data)
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
