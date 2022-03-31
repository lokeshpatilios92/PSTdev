//
//  EditRecipePackViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 13/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id  : PSTMOBSTD0137

import UIKit

class EditRecipePackViewController: BaseViewController {
    
    @IBOutlet var btn_save: UIButton!
    @IBOutlet var btn_cancel: UIButton!
    @IBOutlet var txt_dietType: KKNEWTextFiled!
    @IBOutlet var txt_name: KKNEWTextFiled!
    @IBOutlet var btn_expand_info: UIButton!
    @IBOutlet var btn_expand_recipe: UIButton!
    
    @IBOutlet var txt_tags: KKNEWTextFiled!
    @IBOutlet var txt_season: KKNEWTextFiled!
    @IBOutlet var btn_add: UIButton!
    @IBOutlet var collectionRecipe: UICollectionView!

    @IBOutlet var height_viewSaveCancel: NSLayoutConstraint!
    @IBOutlet var height_viewAddFilter: NSLayoutConstraint!
    @IBOutlet var height_viewAddRecipe: NSLayoutConstraint!
    @IBOutlet var height_viewInfo: NSLayoutConstraint!
    @IBOutlet var height_collectionView: NSLayoutConstraint!
    @IBOutlet var txtView_description: UITextView!
    
    var isExpandViewInfoClicked = false
    var isExpandViewAddRecipeClicked = false
    
    var heightCollection = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionViewSetup()
    }
    
    func collectionViewSetup()
    {
        // Initialize UICollectionView without a layout
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: collectionRecipe.frame.size.width / 2 - 15, height: collectionRecipe.frame.size.width / 2)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        collectionRecipe.collectionViewLayout = layout
        
        collectionRecipe.showsVerticalScrollIndicator = false
        collectionRecipe.backgroundColor = .white
        
        collectionRecipe.isScrollEnabled = true
        collectionRecipe.reloadData()
        
        var height = CGFloat()
        height = collectionRecipe.collectionViewLayout.collectionViewContentSize.height
        heightCollection = height
        height_collectionView.constant = height
        
        self.view.layoutIfNeeded()
    }
    
    func initialize()
    {
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Edit Recipe Pack")
        
        self.navigationItem.rightBarButtonItems = [addSaveNavButton(),addViewRecipeDeleteButton()]
        
        self.collectionRecipe.dataSource = self
        self.collectionRecipe.delegate = self
        
        btn_save.layer.cornerRadius = btn_save.frame.size.height / 2
        btn_cancel.layer.cornerRadius = btn_cancel.frame.size.height / 2
        btn_cancel.layer.borderWidth = 1.0
        btn_cancel.layer.borderColor = UIColor.appOrangeColor().cgColor
        
        btn_add.layer.cornerRadius = btn_add.frame.size.height / 2
        collectionRecipe.dataSource = self
        collectionRecipe.delegate = self
        
        collectionRecipe.register(UINib(nibName: "Recipe_BoxCollectionCell", bundle: nil), forCellWithReuseIdentifier: "Recipe_BoxCollectionCell")
    }
    
    @IBAction func onClickBtnFliter(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickBtnShortList(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickBtnCancel(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickBtnSaave(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickBtnExpandRecipe(_ sender: UIButton) {
        
        if(isExpandViewAddRecipeClicked == false)
        {
            isExpandViewAddRecipeClicked = true
            height_collectionView.constant = 0.0
            height_viewAddRecipe.constant = 50.0
            height_viewAddFilter.constant = 0.0
            height_viewSaveCancel.constant = 80.0
            //            sender.setImage("", for: .normal)
        }
        else
        {
            isExpandViewAddRecipeClicked = false
            height_collectionView.constant = heightCollection
            height_viewAddRecipe.constant = 100.0
            height_viewAddFilter.constant = 50.0
            height_viewSaveCancel.constant = 80.0
            //            sender.setImage("", for: .normal)
        }
        
    }
    
    @IBAction func onClickBtnExpandInfo(_ sender: UIButton) {
        
        if(isExpandViewInfoClicked == false)
        {
            isExpandViewInfoClicked = true
            height_viewInfo.constant = 0.0
//            sender.setImage("", for: .normal)
        }
        else
        {
            isExpandViewInfoClicked = false
            height_viewInfo.constant = 600.0
//            sender.setImage("", for: .normal)
        }
        
    }
    
    
}


extension EditRecipePackViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Recipe_BoxCollectionCell", for: indexPath) as! Recipe_BoxCollectionCell
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width / 2 - 10, height: collectionView.frame.size.width / 2)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if let lastVisibleIndexPath = collectionView.indexPathsForVisibleItems.last {
//            if indexPath == lastVisibleIndexPath {
//                self.height_collectionView.constant = self.collectionRecipe.contentSize.height
//            }
//        }
//
//    }
    
}
