//
//  ViewRecipePackViewController.swift
//  PrepSmart_ETPL
//
//  Created by Etpl-Mac on 17/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  //  Screen Id : PSTMOBSTD038

import UIKit
import Popover

class ViewRecipePackViewController: BaseViewController {

    
    @IBOutlet weak var dietTypeLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var downArrowFilter: UIButton!
    @IBOutlet weak var readMoreOutlet: UIButton!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var contanierView: UIView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var isReadMoreTapped = true
    
   
    @IBOutlet weak var collectionView   : UICollectionView!
    @IBOutlet weak var totalItemsCountLabel: UILabel!
    
    let recipe_BoxCollectionCell    = "Recipe_BoxCollectionCell"
    
    var recipeArray                 : [UIImage] = [#imageLiteral(resourceName: "recipe-img-15"),#imageLiteral(resourceName: "tomato"),#imageLiteral(resourceName: "recipe-img-13"),#imageLiteral(resourceName: "recipe-img-17"), #imageLiteral(resourceName: "recipe-img-16"),#imageLiteral(resourceName: "recipe-img-9"),#imageLiteral(resourceName: "recipe-img-6"),#imageLiteral(resourceName: "recipe-img-18")]
    
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
        self.navigationItem.titleView = UtilityManager.getTitleLabel("View Recipe Pack")
        

        self.navigationItem.rightBarButtonItem = addViewRecipeEditButton()
        
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
        
     
        self.totalItemsCountLabel.text = "\(recipeArray.count) of 250 Recipes"
    }
    override func viewWillLayoutSubviews()
    {
        DispatchQueue.main.async {
            
            self.collectionViewHeight.constant = self.collectionView.contentSize.height
        }
        
    }
    
    
    //MARK: Read More Tapped
    @IBAction func readMoreTapped(_ sender: UIButton) {
        if isReadMoreTapped == true {
            self.descLabel.numberOfLines = 0
           isReadMoreTapped = false
        }else{
            self.descLabel.numberOfLines = 3
            isReadMoreTapped = true
        }
        
        
    }
    
    //MARK: Filter Button Tapped
    @IBAction func filterTapped(_ sender: UIButton) {
        
        let popoverOptions: [PopoverOption] = [
            .type(.auto),
            .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
        ]
        
        let blogFilter = self.instanceFromBlogFilterNib()//BlogFilter(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: 300))
        blogFilter.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        
        let popover = Popover(options: popoverOptions)
            popover.show(blogFilter, fromView: filterButton)
//        popover.show(blogFilter, point: CGPoint(x: self.view.frame.width - (self.view.frame.width / 4), y: filter.frame.maxY))
    }
    
    //MARK: Down Filter Button Tapped
    @IBAction func downArrowFilterTapped(_ sender: UIButton) {
    }
    
    
}
extension ViewRecipePackViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    //    MARK: UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipe_BoxCollectionCell, for: indexPath) as! Recipe_BoxCollectionCell
        
                cell.setCellImages(itemImage: "", label0Image: nil, label1Image: nil, label2Image: nil, label3Image: nil, label4Image: nil, recipe0Image: nil, recipe1Image: nil, recipe2Image: nil)
        
        cell.setContainData(itemTitle: "Stew You Never Knew You Loved", amountString: "$10 Per month", rating: "(450)", starValue: 4)
        
        if indexPath.row % 2 == 0{
            cell.lockImgView.image = UIImage(named : "lock_icon")
            cell.lockView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5165614298)
        }
              
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           showAlertWithOkButtonPopUpVC(setTitle: "", setMessage: "Subscribe now for immediate access to all content.", setButtonTitle: "Learn More", customDelegate: nil)
       }
   
}
