//
//  ExploreRecipeDetailsViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 07/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Cosmos
import SwipeMenuViewController

class ExploreRecipeDetailsViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var startView: CosmosView!
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var starRatingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descripstionLabel: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var addToRecipeBoxButton: UIButton!
    @IBOutlet weak var btn_reportRecipe: UIButton!
    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    @IBOutlet weak var constraintSwipeViewHt: NSLayoutConstraint!

    let previewBlogCollectionCell = "PreviewBlogCollectionCell"
    let arrTitles = ["Recipe Info", "Ingredients and Instructions", "Nutrition Info", "Rate this Recipe", "Reviews and Comments", "Notes"]
    let recipeInfoVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "ViewRecipeInfoVIewController") as! ViewRecipeInfoVIewController
    let notesVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
    let nutritionalInfoVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "ViewNutritionalInfoViewController") as! ViewNutritionalInfoViewController
    let rateThisRecipe = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "RateThisRecipeViewController") as! RateThisRecipeViewController
    let reviewAndRatingVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "ReviewsandRatingsVC") as! ReviewsandRatingsVC
    let viewIngredientVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "ViewIngredientsAndInstructionsViewController") as! ViewIngredientsAndInstructionsViewController
    
    var index = 0
    var isDelete = false
    var isComeFrom : String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalize()
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        DispatchQueue.main.async {
            self.constraintSwipeViewHt.constant = self.view.safeAreaFrame.height - 80
            self.swipeMenuView.layoutIfNeeded()
        }
    }
    
    func initalize(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("View Recipe")
        if isComeFrom == "MyRecipesVC"
        {
            self.navigationItem.rightBarButtonItems = [addViewRecipeDeleteButton(), addWishListNavButton(),addToNavButton()]
        }
        else
        {
            self.navigationItem.rightBarButtonItems = [editRecipeNavButton()]
        }
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 270)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.isPagingEnabled = true
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: previewBlogCollectionCell, bundle: nil), forCellWithReuseIdentifier: previewBlogCollectionCell)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //Swipe Menu
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        
        swipeMenuView.contentScrollView?.bounces = false
        swipeMenuView.contentScrollView?.alwaysBounceVertical = false
        
        var options: SwipeMenuViewOptions = .init()
        options.tabView.itemView.font = UIFont.BOLD_FONT(size: 16.0)
        options.tabView.itemView.selectedTextColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
        options.tabView.additionView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
        options.contentScrollView.isScrollEnabled = true
        swipeMenuView.reloadData(options: options)
        
        subscribeButton.layer.cornerRadius = subscribeButton.frame.height / 2
        addToRecipeBoxButton.layer.cornerRadius = addToRecipeBoxButton.frame.height / 2
        
        btn_reportRecipe.layer.cornerRadius = btn_reportRecipe.frame.height / 2
        btn_reportRecipe.clipsToBounds = true
        btn_reportRecipe.layer.borderWidth = 0.5
        btn_reportRecipe.layer.borderColor = UIColor.appOrangeColor().cgColor
        
        scrollView.delegate = self
    }
    
    func addToNavButton() -> UIBarButtonItem {
        let addBlogsNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "add_recipe"), style: .done, target: self, action: #selector(self.onClickAddNavButton))
        return addBlogsNavButton
    }
    
    @objc func onClickAddNavButton()
    {
        self.showAddToPopUpVC(customDelegate: self)
    }
    
    override func addViewRecipeDeleteButton() -> UIBarButtonItem {
        let addNewRecipeNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "delete"), style: .done, target: self, action: #selector(self.onClickDeleteNavButton))
        return addNewRecipeNavButton
    }
    
    @objc func onClickDeleteNavButton()
    {
        isDelete = true
        self.showCustomOkCancelPopUp(titleText: "", mesgText: "Are you sure you want to delete this recipe?", okButtonName: "Confirm", cancelButtonName: "Cancel", leftCornerImage: nil, customDelegate: self)
    }
    
    @IBAction func onClickReportRecipe(_ sender: Any)
    {
        isDelete = false
        self.showCustomOkCancelPopUp(titleText: "Report Review", mesgText: "If you find this content inappropriate and think it should be removed, click on the Report button below to proceed.", okButtonName: "Report", cancelButtonName: "Cancel", leftCornerImage: nil, customDelegate: self)
    }
}

extension ExploreRecipeDetailsViewController : ReportThisRecipePopUpDelegate
{
    func onClicksubmitButton() {
        self.showAlertWithOkButtonPopUpVC(setTitle: "Reported Successfully", setMessage: "Thank you for your inputs! We are reviewing your submission and will work to ensure the best possible experience for our users.", setButtonTitle: "Ok", customDelegate: self)
    }
}

extension ExploreRecipeDetailsViewController : CustomAlertWithOkButtonPopUpDelegate
{
    func onClickOkButtonAction() {
        
    }
}

extension ExploreRecipeDetailsViewController : CustomAddToPopUpVCDelegate
{
    func onClickAddButton() {
        self.showAlertWithOkButtonPopUpVC(setTitle: "", setMessage: "Your recipe has been added successfully!", setButtonTitle: "Ok", customDelegate: self)
    }
}

extension ExploreRecipeDetailsViewController : CustomOkCancelPopUpViewControllerDelegate {
    func onClickOkButton() {
        if isDelete
        {
            print("Delete Button Clicked")
        }
        else
        {
            print("Report Button Clicked")
            self.ShowReportThisRecipePopUpVC(customDelegate: self)
        }
        
    }
    
    func onClickCancelButton() {
        print("Cancel Button Clicked")
    }
}

extension ExploreRecipeDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource,  SwipeMenuViewDelegate, SwipeMenuViewDataSource{
    
    //    MARK: UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewBlogCollectionCell, for: indexPath) as! PreviewBlogCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageController.currentPage = indexPath.item
    }
    
    
    //    MARK: SwipeMenuViewDelegate
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
        // Codes
        //        DispatchQueue.main.async {
        //            self.constraintSwipeViewHt.constant = self.swipeMenuView.contentScrollView?.contentSize.height ?? 0.0
        //            self.swipeMenuView.layoutIfNeeded()
        //        }
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
        // Codes
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
        index = toIndex
        self.scrollView.isScrollEnabled = true
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
    }
    
    //    MARK: SwipeMenuViewDataSource
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return arrTitles.count
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return arrTitles[index]
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        //        let recipeInfoVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "RecipeInfoViewController") as! RecipeInfoViewController
        if index == 0
        {
            self.recipeInfoVC.parentVC = self
            self.recipeInfoVC.didMove(toParent: self)
            return recipeInfoVC
        }
        else if index == 1
        {
            self.viewIngredientVC.parentVC = self
            self.viewIngredientVC.didMove(toParent: self)
            return viewIngredientVC
        }
        else if index == 2
        {
            self.nutritionalInfoVC.parentVC = self
            self.nutritionalInfoVC.didMove(toParent: self)
            return nutritionalInfoVC
        }
        else if index == 3
        {
            self.rateThisRecipe.parentVC = self
            self.rateThisRecipe.didMove(toParent: self)
            return rateThisRecipe
        }
        else if index == 4
        {
            self.reviewAndRatingVC.parentVC = self
            self.reviewAndRatingVC.didMove(toParent: self)
            return reviewAndRatingVC
        }
        else if index == 5
        {
            self.notesVC.parentVC = self
            self.notesVC.didMove(toParent: self)
            return notesVC
        }
        return UIViewController()
    }
}

extension ExploreRecipeDetailsViewController : UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("scrolled")
        if scrollView == collectionView
        {
            
        }
        else if scrollView == self.scrollView
        {
            if scrollView.isAtBottom
            {
                if index == 0
                {
                    if recipeInfoVC.scrollView_inner.contentSize.height > recipeInfoVC.scrollView_inner.frame.size.height
                    {
                        self.scrollView.isScrollEnabled = false
                        self.recipeInfoVC.scrollView_inner.isScrollEnabled = true
                    }
                    else
                    {
                        self.scrollView.isScrollEnabled = true
                        self.recipeInfoVC.scrollView_inner.isScrollEnabled = false
                    }
                }
                else if index == 1
                {
                    if viewIngredientVC.scrollView_inner.contentSize.height > viewIngredientVC.scrollView_inner.frame.size.height
                    {
                        self.scrollView.isScrollEnabled = false
                        self.viewIngredientVC.scrollView_inner.isScrollEnabled = true
                    }
                    else
                    {
                        self.scrollView.isScrollEnabled = true
                        self.viewIngredientVC.scrollView_inner.isScrollEnabled = false
                    }
                }
                else if index == 2
                {
                    if nutritionalInfoVC.scrollView_inner.contentSize.height > nutritionalInfoVC.scrollView_inner.frame.size.height
                    {
                        self.scrollView.isScrollEnabled = false
                        self.nutritionalInfoVC.scrollView_inner.isScrollEnabled = true
                    }
                    else
                    {
                        self.scrollView.isScrollEnabled = true
                        self.nutritionalInfoVC.scrollView_inner.isScrollEnabled = false
                    }
                }
                else if index == 3
                {
                    if rateThisRecipe.scrollView_inner.contentSize.height > rateThisRecipe.scrollView_inner.frame.size.height
                    {
                        self.scrollView.isScrollEnabled = false
                        self.rateThisRecipe.scrollView_inner.isScrollEnabled = true
                    }
                    else
                    {
                        self.scrollView.isScrollEnabled = true
                        self.rateThisRecipe.scrollView_inner.isScrollEnabled = false
                    }
                }
                else if index == 4
                {
                    if reviewAndRatingVC.scrollView_inner.contentSize.height > reviewAndRatingVC.scrollView_inner.frame.size.height
                    {
                        self.scrollView.isScrollEnabled = false
                        self.reviewAndRatingVC.scrollView_inner.isScrollEnabled = true
                    }
                    else
                    {
                        self.scrollView.isScrollEnabled = true
                        self.reviewAndRatingVC.scrollView_inner.isScrollEnabled = false
                    }
                }
                else if index == 5
                {
                    if notesVC.scrollView_inner.contentSize.height > notesVC.scrollView_inner.frame.size.height
                    {
                        self.scrollView.isScrollEnabled = false
                        self.notesVC.scrollView_inner.isScrollEnabled = true
                    }
                    else
                    {
                        self.scrollView.isScrollEnabled = true
                        self.notesVC.scrollView_inner.isScrollEnabled = false
                    }
                }
                
            }
        }
        else
        {
            if scrollView.isAtTop
            {
                scrollView.isScrollEnabled = false
                self.scrollView.isScrollEnabled = true
            }
        }
    }
}
