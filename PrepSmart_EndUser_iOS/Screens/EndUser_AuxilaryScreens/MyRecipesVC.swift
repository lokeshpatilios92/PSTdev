//
//  MyRecipesVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 31/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD049, PSTMOBSTD0106

import UIKit
import DropDown
import Popover
import XLPagerTabStrip

class MyRecipesVC: BaseViewController , filterDelegate{
    
    func filterDelegateMethod(start_index: Int, type: Int, display_type: Int, record_count: Int, category_id: String, diet_type_ids: String, courses: String, tags: String, seasons: String, ingredient_ids: String) {
        
        filteredRecipesListApi(start_index: start_index,
                               type: type,
                               display_type: display_type,
                               record_count: record_count,
                               category_id: category_id,
                               diet_type_ids: diet_type_ids,
                               courses: courses,
                               tags: tags,
                               seasons: seasons,
                               ingredient_ids: ingredient_ids)
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var Lbl_resultCount: UILabel!
    @IBOutlet weak var downArrowBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favView: UIView!
    @IBOutlet weak var cretedByMeView: UIView!
    @IBOutlet weak var allView: UIView!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var createdByMebtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var Lbl_All: UILabel!
    @IBOutlet weak var Lbl_CreatedByMe: UILabel!
    @IBOutlet weak var Lbl_Fav: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbl_dropDown: UILabel!
    
    var childNumber = ""
    let myRecipesCell = "MyRecipesCell"
    let recipe_BoxCollectionCell = "Recipe_BoxCollectionCell"
    var viewbyType = 5
    var topdisplayType = 1
    var chefsDropDown = DropDown()
    
    var global_Var = GlobalClass.sharedManager
    var myStuffObj : MyStuff_Struct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func initializer(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("My Stuff")
        applyBorderToView(view: allView)
        applyBorderToView(view: cretedByMeView)
        applyBorderToView(view: favView)
        
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = .white
        searchBar.isTranslucent = true
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 0.50
        searchBar.layer.cornerRadius = 20.0
        //        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.backgroundImage = UIImage()
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: UISearchBar.Icon.search, state: .normal)
        
        //SearchBar Text
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.font = UIFont.REGULAR_FONT()
        
        //        //SearchBar Placeholder
        //        let textFieldInsideUISearchBarLabel = searchBar!.value(forKey: "placeholderLabel") as? UILabel
        //        textFieldInsideUISearchBarLabel?.font = UIFont.REGULAR_FONT()
        
        dropDownView.layer.cornerRadius = dropDownView.frame.height / 2
        dropDownView.layer.borderColor = UIColor.lightGray.cgColor
        dropDownView.layer.borderWidth = 0.5
        
        tableView.register(UINib(nibName: myRecipesCell, bundle: .none), forCellReuseIdentifier: myRecipesCell)
        // Initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (view.frame.width) / 2 - 15, height: view.frame.width / 2)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: recipe_BoxCollectionCell, bundle: nil), forCellWithReuseIdentifier: recipe_BoxCollectionCell)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        self.lbl_dropDown.text = "View By"
        
        chefsDropDown.backgroundColor = UIColor.white
        DropDown.startListeningToKeyboard()
        
        bgImage.isHidden = true
        
        myStuffApi(startIndex: 0, type: viewbyType, displayType: topdisplayType, recordCount: 500)
    }
    
    
    @objc func showAddToPopUp()
    {
        self.showAddToPopUpVC(customDelegate: self)
    }
    
    @objc func favraitButtonClicked(button: UIButton) {
        let receipe = self.myStuffObj?.recipeList?[button.tag]
        
        self.addTOFavAPI(with: "\(receipe?.recipe_type ?? 0)", recipeId: "\(receipe?.item_id ?? 0)", chefId: "\(receipe?.chef_id ?? 0)", favStatus: 1)
    }
    
    func applyBorderToView(view:UIView){
        view.layer.cornerRadius = favView.frame.height/2
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.appOrangeColor().cgColor
    }
    
    @IBAction func topButtonAction(_ sender: UIButton) {
        if sender == self.allBtn{
            
            allView.backgroundColor = .appOrangeColor()
            Lbl_All.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            cretedByMeView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Lbl_CreatedByMe.textColor = .appOrangeColor()
            
            favView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Lbl_Fav.textColor = .appOrangeColor()
            topdisplayType = 1
            myStuffApi(startIndex: 0, type: viewbyType, displayType: topdisplayType, recordCount: 500)
            
        } else if sender == self.createdByMebtn {
            cretedByMeView.backgroundColor = .appOrangeColor()
            Lbl_CreatedByMe.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            allView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Lbl_All.textColor = .appOrangeColor()
            
            favView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Lbl_Fav.textColor = .appOrangeColor()
            topdisplayType = 2
            myStuffApi(startIndex: 0, type: viewbyType, displayType: topdisplayType, recordCount: 500)
        } else {
            favView.backgroundColor = .appOrangeColor()
            Lbl_Fav.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            allView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Lbl_All.textColor = .appOrangeColor()
            
            cretedByMeView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Lbl_CreatedByMe.textColor = .appOrangeColor()
            topdisplayType = 3
            myStuffApi(startIndex: 0, type: viewbyType, displayType: topdisplayType, recordCount: 500)
        }
    }
    
    @IBAction func filterTapped(_ sender: UIButton) {
        print("On Click Add Filter")
        //        let blogFilter = self.instanceFromBlogFilterNib()//BlogFilter(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: 300))
        //        blogFilter.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        //
        //        let popover = Popover(options: self.popoverOptions)
        //        popover.show(filterBtn, fromView: filterBtn)//show(blogFilter, fromView: filterBtn)//show(blogFilter, point: CGPoint(x: self.view.frame.width - (self.view.frame.width / 4), y: 65))
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "FilterViewViewController") as! FilterViewViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func downArrowTapped(_ sender: UIButton) {
        print("On Click Add Sort")
        let shortFilter = self.instanceFromShortListFilterNib()//BlogFilter(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: 300))
        shortFilter.frame = CGRect(x: 0, y: 0, width: 250, height: 350)
        
        let popover = Popover(options: self.popoverOptions)
        popover.show(shortFilter, fromView: downArrowBtn)//(shortFilter, point: CGPoint(x: self.view.frame.width - (self.view.frame.width / 5), y: 65))
    }
    
    @IBAction func viewByDropDownClicked(_ sender: UIButton) {
        chefsDropDown.anchorView = self.lbl_dropDown
        chefsDropDown.textFont = UIFont.REGULAR_FONT()
        chefsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            switch item {
            case "Recipe" :
                viewbyType = 1
            case "Recipe Pack" :
                viewbyType = 2
            case "Weekly Plan" :
                viewbyType = 3
            case "Chef" :
                viewbyType = 4
            case "View By" :
                viewbyType = 5
            default:
                viewbyType = 5
            }
            myStuffApi(startIndex: 0,
                       type: viewbyType,
                       displayType: topdisplayType,
                       recordCount: 500)
            self.lbl_dropDown.text = item
            if self.lbl_dropDown.text != "Chef"{
                self.tableView.isHidden = true
                self.collectionView.isHidden = false
            }else{
                self.tableView.isHidden = false
                self.collectionView.isHidden = true
            }
        }
        self.lbl_dropDown.resignFirstResponder()
        chefsDropDown.show()
    }
    
}

extension MyRecipesVC : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myRecipesCell, for: indexPath) as! MyRecipesCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc =  UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreRecipePackViewController") as! ExploreRecipePackViewController
        vc.isComingFromChefName = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MyRecipesVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myStuffObj?.recipeList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipe_BoxCollectionCell, for: indexPath) as! Recipe_BoxCollectionCell
        
        let dic = self.myStuffObj?.recipeList?[indexPath.row]
        
        cell.itemTitleLabel.text = dic?.item_title
        cell.itemImageView.sd_setImage(with: URL(string: dic?.item_image ?? ""), placeholderImage: UIImage(named: "dinner"))
        cell.freeTitleLbl.text = dic?.item_label
        if let rating = dic?.ratting {
            switch rating {
            case .integer(let int):
                cell.cosmosStarView.rating = Double(int)
                cell.ratingLabel.text = "(\(int))"
            case .string(let string):
                cell.cosmosStarView.rating = Double(string) ?? 0.0
                cell.ratingLabel.text = "(\(string))"
            }
        }
        cell.btn_favorit.tag = indexPath.row
        cell.btn_favorit.addTarget(self, action: #selector(favraitButtonClicked(button:)), for: .touchUpInside)
        cell.btn_addTo.addTarget(self, action: #selector(showAddToPopUp), for: .touchUpInside)
        cell.img_favorit.image = (dic?.fav_status == 2) ? UIImage.init(named: "favorite") : UIImage.init(named: "heart")
        cell.labelImageView0.isHidden = true
        cell.labelImageView1.isHidden = true
        cell.labelImageView2.isHidden = true
        cell.labelImageView3.isHidden = true
        cell.labelImageView4.isHidden = true
        cell.view_favorit.isHidden = false
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dic = self.myStuffObj?.recipeList?[indexPath.row]
        let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "ViewRecipeViewController") as! ViewRecipeViewController
        vc.recipeId = String(dic?.item_id ?? 0)
        vc.recipeOwnerId = String(dic?.chef_id ?? 0)
        self.navigationController?.pushViewController(vc, animated: true)
        
        //        let vc =  UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "ExploreRecipeDetailsViewController") as! ExploreRecipeDetailsViewController
        //        vc.isComeFrom = "MyRecipesVC"
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension MyRecipesVC : IndicatorInfoProvider{
    
    //    MARK: XLPagerTabStrip
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(childNumber)")
    }
}

extension MyRecipesVC : CustomAddToPopUpVCDelegate
{
    func onClickAddButton() {
        self.showAlertWithOkButtonPopUpVC(setTitle: "", setMessage: "Your recipe has been added successfully!", setButtonTitle: "Ok", customDelegate: self)
    }
}

extension MyRecipesVC : CustomAlertWithOkButtonPopUpDelegate
{
    func onClickOkButtonAction() {
        
    }
}

extension MyRecipesVC
{
    func myStuffApi(startIndex:Int, type:Int, displayType:Int, recordCount:Int)
    {
        let param:[String:Any] = ["start_index":startIndex,
                                  "type": type,
                                  "display_type": displayType,
                                  "record_count":recordCount]
        print("params \(param)")
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.myStuff, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.myStuffObj = try JSONDecoder().decode(MyStuff_Struct.self, from: data)
                            self.dataParse()
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
    
    func filteredRecipesListApi(start_index: Int, type: Int, display_type: Int, record_count: Int, category_id: String, diet_type_ids: String, courses: String, tags: String, seasons: String, ingredient_ids: String)
    {
        let param:[String:Any] = ["start_index":start_index,
                                  "type": type,
                                  "display_type":display_type ,
                                  "record_count":record_count,
                                  "category_ids":category_id,
                                  "diet_type_ids":diet_type_ids,
                                  "courses":courses,
                                  "tags":tags,
                                  "seasons":seasons,
                                  "ingredient_ids":ingredient_ids]
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.filteredRecipesList, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.myStuffObj = try JSONDecoder().decode(MyStuff_Struct.self, from: data)
                            self.dataParse()
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
    
    func addTOFavAPI(with receipeType: String, recipeId: String, chefId: String, favStatus: Int) {
        let param:[String:Any] = ["recipe_type": receipeType ,"recipe_id": recipeId,
                                  "chef_id": chefId, "flag": favStatus]
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.addToFav, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        
                    }
                    else
                    {
                        Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: GlobalClass.sharedManager.get_status.message)
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: GlobalClass.sharedManager.get_status.message)
                }
                // SVProgressHUD.dismiss()
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

extension MyRecipesVC {
    func dataParse(){
        self.collectionView.reloadData()
        self.Lbl_resultCount.text = String(self.myStuffObj?.recipeList?.count ?? 0) + " Result found"
        let array: [String] = self.myStuffObj?.recipeBoxViewTypeList?.map{String($0.type_name ?? "")} ?? []
        chefsDropDown.dataSource = array
    }
}
