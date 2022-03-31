//
//  ExploreWeeklyPlanViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh Kulkarni on 30/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD027

import UIKit

class ExploreWeeklyPlanViewController : BaseViewController {
    @IBOutlet weak var searchBar        : UISearchBar!
    @IBOutlet weak var collectionView   : UICollectionView!
    @IBOutlet weak var viewByBgView     : UIView!
    
    @IBOutlet weak var viewByLabel: UILabel!
    @IBOutlet weak var totalItemsCountLabel: UILabel!

    
    let recipe_BoxCollectionCell    = "Recipe_BoxCollectionCell"
    var global_Var = GlobalClass.sharedManager
    var findNewRecipeObj : FindNewRecipe_Struct?
    
    
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
        
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.FONT_BUTTON()
        label.text = "Explore Weely Plan Templates"
        self.navigationItem.titleView = label
        //        self.navigationItem.leftBarButtonItem = addNewRecipeNavButton()
        self.navigationItem.rightBarButtonItems = [addSortNavButton(),addFilterNavButton()]
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        //  searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.placeholder = " Search"
        searchBar.sizeToFit()
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: .search, state: .normal)
        searchBar.layer.borderColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 0.5077373798)
        searchBar.layer.borderWidth = 1
        searchBar.layer.cornerRadius = 20.0
        searchBar.backgroundImage = UIImage()
        searchBar.clipsToBounds = true
        
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
}

extension ExploreWeeklyPlanViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    //    MARK: UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.findNewRecipeObj?.recipeList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipe_BoxCollectionCell, for: indexPath) as! Recipe_BoxCollectionCell
    let dic = self.findNewRecipeObj?.recipeList?[indexPath.row]
        
//        if indexPath.row == 2 || indexPath.row == 4 {
//            cell.setCellImages(itemImage: dic?.item_image ?? "", label0Image: #imageLiteral(resourceName: "prepsmarts-choice"), label1Image: #imageLiteral(resourceName: "recipe-pack"), label2Image: nil, label3Image: nil, label4Image: nil, recipe0Image: nil, recipe1Image: nil, recipe2Image: nil)
//
//        } else {
            cell.setCellImages(itemImage: dic?.item_image ?? "", label0Image: #imageLiteral(resourceName: "recipe-pack"), label1Image: nil, label2Image: nil, label3Image: nil, label4Image: nil, recipe0Image: nil, recipe1Image: nil, recipe2Image: nil)
       // }
        cell.labelImageView0.isHidden = true
        cell.labelImageView1.isHidden = true
        cell.labelImageView2.isHidden = true
        cell.labelImageView3.isHidden = true
        cell.labelImageView4.isHidden = true
        var rattingvalue:Double = 0.0
        if let rating = dic?.ratting {
            switch rating {
            case .integer(let int):
                rattingvalue = Double(int)
            case .string(let string):
                 rattingvalue  = Double(string) ?? 0.0
            }
        }
        cell.setContainData(itemTitle: dic?.item_title ?? "",                             amountString: "",
                            rating: "",
                            starValue: rattingvalue)
        cell.freeTitleLbl.text = "Weekly Plan"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreWeeklyPlanDetailsViewController") as! ExploreWeeklyPlanDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
/*
 
 "recipeBoxViewTypeList": [
 {
 "type_id": 0,
 "type_name": "All"
 },
 {
 "type_id": 1,
 "type_name": "Recipe"
 },
 {
 "type_id": 2,
 "type_name": "Weekly Plan Template"
 },
 {
 "type_id": 3,
 "type_name": "Recipe Pack"
 },
 {
 "type_id": 4,
 "type_name": "Top Trending"
 },
 {
 "type_id": 5,
 "type_name": "Prepsmart Choice"
 },
 {
 "type_id": 6,
 "type_name": "Best selling"
 },
 {
 "type_id": 7,
 "type_name": "Seasonal"
 },
 {
 "type_id": 8,
 "type_name": "New Chef"
 }
 ]
 */
extension ExploreWeeklyPlanViewController
{
    func findNewRecipeApi()
    {
        let param:[String:Any] = ["start_index":"0",
                                  "type": "2",
                                  "expand_filter":"2",
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
                            self.collectionView.reloadData()
                            self.totalItemsCountLabel.text = "\(self.findNewRecipeObj?.recipeList?.count ?? 0) result found"
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
