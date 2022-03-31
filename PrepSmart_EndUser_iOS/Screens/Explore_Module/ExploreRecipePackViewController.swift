//
//  ExploreRecipePackViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh Kulkarni on 30/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen ID: PSTMOBSTD026

import UIKit

class ExploreRecipePackViewController: BaseViewController {
    @IBOutlet weak var searchBar        : UISearchBar!
    @IBOutlet weak var collectionView   : UICollectionView!
    @IBOutlet weak var viewByBgView     : UIView!
    
    @IBOutlet weak var viewByLabel: UILabel!
    @IBOutlet weak var totalItemsCountLabel: UILabel!
    @IBOutlet weak var backSearchBarView: UIView!
    
    let recipe_BoxCollectionCell    = "Recipe_BoxCollectionCell"
    
    var recipeArray                 : [UIImage] = [#imageLiteral(resourceName: "recipe-img-15"),#imageLiteral(resourceName: "recipe-img-7"),#imageLiteral(resourceName: "recipe-img-13"),#imageLiteral(resourceName: "recipe-img-17"), #imageLiteral(resourceName: "recipe-img-16"),#imageLiteral(resourceName: "recipe-img-9"),#imageLiteral(resourceName: "recipe-img-6"),#imageLiteral(resourceName: "recipe-img-18")]
    
    var isComingFromChefName = 0
    
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
        
        if isComingFromChefName == 1{
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Laura C Robinson")

        }else{
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Explore Recipe Packs")

        }
        
        
        //        self.navigationItem.leftBarButtonItem = addNewRecipeNavButton()
        self.navigationItem.rightBarButtonItems = [addSortNavButton(),addFilterNavButton()]
        
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = .white
        searchBar.isTranslucent = true
        searchBar.layer.borderColor = UIColor.black.cgColor
        backSearchBarView.layer.borderWidth = 0.50
        backSearchBarView.layer.cornerRadius = backSearchBarView.frame.height / 2
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: UISearchBar.Icon.search, state: .normal)
        
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
        
        self.totalItemsCountLabel.text = "\(recipeArray.count) result found"
    }
    
    //    MARK: On Click Func
    @IBAction func onClickViewByButton(_ sender: Any) {
    }
    
    @objc func onClickAddTo()
    {
        self.showAddToMealPopUpVC(customDelegate: self)
    }
}

extension ExploreRecipePackViewController : CustomAddToMealPopUpVCDelegate
{
    func onClickAddButton() {
        
    }
}

extension ExploreRecipePackViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    //    MARK: UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipe_BoxCollectionCell, for: indexPath) as! Recipe_BoxCollectionCell
        
        cell.setCellImages(itemImage: "", label0Image: #imageLiteral(resourceName: "recipe-pack"), label1Image: nil, label2Image: nil, label3Image: nil, label4Image: nil, recipe0Image: #imageLiteral(resourceName: "recipe-img-20"), recipe1Image: #imageLiteral(resourceName: "recipe-img-7"), recipe2Image: #imageLiteral(resourceName: "recipe-img-24"))
        
        cell.setContainData(itemTitle: "Stew You Never Knew You Loved", amountString: "", rating: "(450)", starValue: 4)
        
        cell.btn_addTo.addTarget(self, action: #selector(self.onClickAddTo), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreRecipePackDetailsViewController") as! ExploreRecipePackDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

