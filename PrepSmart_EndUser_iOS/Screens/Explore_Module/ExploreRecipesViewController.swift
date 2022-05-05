//
//  ExploreRecipesViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh Kulkarni on 30/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen ID : PSTMOBSTD025

import UIKit
import Popover

class ExploreRecipesViewController: BaseViewController, filterDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewByBgView: UIView!
    @IBOutlet weak var viewByLabel:UILabel!
    @IBOutlet weak var totalItemsCountLabel: UILabel!
    
    var exploreType = "1"
    var global_Var = GlobalClass.sharedManager
    var findNewRecipeObj : FindNewRecipe_Struct?
    var filterFindNewRecipeObj : FindNewRecipe_Struct?
    
    let recipe_BoxCollectionCell = "Recipe_BoxCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.dismissKeyboardOnTap()
        addKeyboardNotificationObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotificationObserver()
    }
    
    func initialize() {
        switch exploreType {
        case "1":
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Explore Recipes")
        case "2":
            let label = UILabel()
            label.backgroundColor = .clear
            label.numberOfLines = 2
            label.font = UIFont.boldSystemFont(ofSize: 16.0)
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.FONT_BUTTON()
            label.text = "Explore Weely Plan Templates"
            self.navigationItem.titleView = label
        case "3":
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Explore Recipes Pack")
        case "4":
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Trending Recipes")
        case "5":
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Prepsmart's Choice")
        case "6":
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Best Selling Recipes")
        case "7":
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Seasonal Recipes")
        default:
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Explore Recipes")
        }
        self.navigationItem.rightBarButtonItems = [addSortNavigationButton(),addFilterNavigationButton()]
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.placeholder = " Search"
        searchBar.sizeToFit()
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: .search, state: .normal)
        searchBar.layer.borderColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 0.5077373798)
        searchBar.layer.borderWidth = 1
        searchBar.layer.cornerRadius = 20.0
        searchBar.backgroundImage = UIImage()
        searchBar.clipsToBounds = true
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (view.frame.width) / 2 - 15, height: view.frame.width / 2)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: recipe_BoxCollectionCell, bundle: nil), forCellWithReuseIdentifier: recipe_BoxCollectionCell)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.viewByBgView.layer.cornerRadius = viewByBgView.frame.height / 2
        self.viewByBgView.layer.borderColor = UIColor.black.cgColor
        self.viewByBgView.layer.borderWidth = 0.50
        self.findNewRecipeApi()
    }
    
    //    MARK: On Click Func
    @IBAction func onClickViewByButton(_ sender: Any) {
    }
    
    
    func addFilterNavigationButton() -> UIBarButtonItem {
        let addFilterNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter_white"), style: .done, target: self, action: #selector(self.filterButtonClicked(button:)))
        return addFilterNavButton
    }
    func addSortNavigationButton() -> UIBarButtonItem {
        let addSortNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "shortlist"), style: .done, target: self, action: #selector(self.sortButtonClicked(button:)))
        return addSortNavButton
    }
    
    @objc func filterButtonClicked(button: UIButton) {
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "FilterViewViewController") as! FilterViewViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sortButtonClicked(button: UIButton) {
        let shortFilter = self.instanceFromShortListFilterNib()//BlogFilter(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: 300))
        shortFilter.frame = CGRect(x: 0, y: 0, width: 200, height: 450)
        
        let popover = Popover(options: self.popoverOptions)
        popover.show(shortFilter, fromView: button.plainView)
    }
    
}

extension ExploreRecipesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    //    MARK: UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return findNewRecipeObj?.recipeList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipe_BoxCollectionCell, for: indexPath) as! Recipe_BoxCollectionCell
        let dic = findNewRecipeObj?.recipeList?[indexPath.row]
        
        if indexPath.row == 0 {
            cell.setCellImages(itemImage: "", label0Image: #imageLiteral(resourceName: "prepsmarts-choice"), label1Image: nil, label2Image: nil, label3Image: nil, label4Image: nil, recipe0Image: nil, recipe1Image: nil, recipe2Image: nil)
        }
        else if indexPath.row == 1 {
            cell.setCellImages(itemImage: "", label0Image: #imageLiteral(resourceName: "premium"), label1Image: nil, label2Image: nil, label3Image: nil, label4Image: nil, recipe0Image: nil, recipe1Image: nil, recipe2Image: nil)
        }
        else if indexPath.row == 2 {
            cell.setCellImages(itemImage: "", label0Image: #imageLiteral(resourceName: "free"), label1Image: nil, label2Image: nil, label3Image: nil, label4Image: nil, recipe0Image: nil, recipe1Image: nil, recipe2Image: nil)
        }
        else if indexPath.row == 3 {
            cell.setCellImages(itemImage: "", label0Image: #imageLiteral(resourceName: "premium"), label1Image: #imageLiteral(resourceName: "prepsmarts-choice"), label2Image: nil, label3Image: nil, label4Image: nil, recipe0Image: nil, recipe1Image: nil, recipe2Image: nil)
        }
        else {
            cell.setCellImages(itemImage: "", label0Image: nil, label1Image: nil, label2Image: nil, label3Image: nil, label4Image: nil, recipe0Image: nil, recipe1Image: nil, recipe2Image: nil)
        }
        
        cell.config(dict: dic)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dic = findNewRecipeObj?.recipeList?[indexPath.row]
        switch exploreType {
        case "1" :
            print("Explore Recipes")
        case "2" :
            let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreWeeklyPlanDetailsViewController") as! ExploreWeeklyPlanDetailsViewController
            vc.recipyPlanId = dic?.item_id ?? 0
            vc.recipyChefId = dic?.chef_id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        case "3" :
            print("Explore Recipes Pack")
            let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreRecipePackDetailsViewController") as! ExploreRecipePackDetailsViewController
            vc.recipyPackId = dic?.item_id ?? 0
            vc.recipyChefId = dic?.chef_id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        case "4" :
            print("Trending Recipes")
        case "5" :
            print("Prepsmart's Choice")
        case "6" :
            print("Best Selling Recipes")
        case "7" :
            print("Seasonal Recipes")
        default:
            print("Explore Recipes")
        }
        
        //        let vc =  UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "ExploreRecipeDetailsViewController") as! ExploreRecipeDetailsViewController
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func filterDelegateMethod(start_index: Int, type: Int, display_type: Int, record_count: Int, category_id: String, diet_type_ids: String, courses: String, tags: String, seasons: String, ingredient_ids: String) {
        self.filteredRecipesListApi(start_index: start_index, type: type, display_type: display_type, record_count: record_count, category_id: category_id, diet_type_ids: diet_type_ids, courses: courses, tags: tags, seasons: seasons, ingredient_ids: ingredient_ids)
    }
}

extension ExploreRecipesViewController
{
    func findNewRecipeApi()
    {
        let param:[String:Any] = ["start_index":"0",
                                  "type": exploreType,
                                  "expand_filter":"1",
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
                            self.filterFindNewRecipeObj = self.findNewRecipeObj
                            self.collectionView.reloadData()
                            self.totalItemsCountLabel.text = "\(self.findNewRecipeObj?.recipeList?.count ?? 0) results found"
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
                            self.findNewRecipeObj = try JSONDecoder().decode(FindNewRecipe_Struct.self, from: data)
                            //self.dataParse()
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

extension ExploreRecipesViewController: UISearchBarDelegate{
    
    func searchBar(_ Searchbar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0
        {
            findNewRecipeObj?.recipeList = filterFindNewRecipeObj?.recipeList
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        else if searchText.count >= 1
        {
            findNewRecipeObj?.recipeList =  filterFindNewRecipeObj?.recipeList?.filter({( Obj : RecipeList) -> Bool in
                return Obj.item_title!.contains(searchText)
            })
            self.collectionView.reloadData()
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
        loadcollection()
    }
    
    func loadcollection()
    {
        self.findNewRecipeObj?.recipeList = self.filterFindNewRecipeObj?.recipeList
        DispatchQueue.main.async
        {
            self.collectionView.reloadData()
        }
    }
}
