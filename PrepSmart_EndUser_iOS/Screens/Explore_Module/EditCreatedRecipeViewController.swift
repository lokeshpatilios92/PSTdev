//
//  EditCreatedRecipeViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 10/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
// PSTMOBSTD128

import UIKit
import SwipeMenuViewController

class EditCreatedRecipeViewController: BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    @IBOutlet weak var constraintSwipeViewHt: NSLayoutConstraint!
    
    var recipeDtails = RecipeDetailsStruct()
    
    let arrTitles = ["Recipe Info", "Ingredients and Instructions", "Nutrition Info", "Pair it with", "Save Option"]
    
    
    
    let recipeInfoVC = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "EditRecipeInfoViewController") as! EditRecipeInfoViewController

    
    let ingredientsVC = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "EditIngredientsAndInstructionsViewController") as! EditIngredientsAndInstructionsViewController
    let nutritionVC = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "EditNutritionalInfoViewController") as! EditNutritionalInfoViewController
    let pairItWith = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "EditPairItViewController") as! EditPairItViewController
    let saveOptionVc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "SaveOptionViewController") as! SaveOptionViewController
    
//    let recipeInfoVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "ViewRecipeInfoVIewController") as! ViewRecipeInfoVIewController
//       let notesVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
//       let nutritionalInfoVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "ViewNutritionalInfoViewController") as! ViewNutritionalInfoViewController
//       let rateThisRecipe = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "RateThisRecipeViewController") as! RateThisRecipeViewController
//       let reviewAndRatingVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "ReviewsandRatingsVC") as! ReviewsandRatingsVC
//       let viewIngredientVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "ViewIngredientsAndInstructionsViewController") as! ViewIngredientsAndInstructionsViewController
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        DispatchQueue.main.async {
            self.constraintSwipeViewHt.constant = self.view.safeAreaFrame.height - 20
            self.swipeMenuView.layoutIfNeeded()
        }
    }
    
    func initialize()
    {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Edit Recipe")
        self.navigationItem.rightBarButtonItems = [deleteRecipeNavButton(),saveRecipeNavButton()]
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
    }
    
    override func deleteRecipeNavButton() -> UIBarButtonItem {
           let deleteRecipeNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "delete"), style: .done, target: self, action: #selector(self.onClickDeleteButton))
           
           return deleteRecipeNavButton
       }
    
    override func saveRecipeNavButton() -> UIBarButtonItem {
        let saveRecipeNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "save"), style: .done, target: self, action: #selector(self.onClickSaveButton))
        
        return saveRecipeNavButton
    }
    
    @objc func onClickDeleteButton()
    {
        self.showDeleteAndChangeRecipePopUp(leftBtnTitle: "Cancel", rightBtnTitle: "Confirm", lblText: "Are you sure you want to delete this recipe?", customDelegate: self)
    }
    
    @objc func onClickSaveButton()
    {
        self.showDeleteAndChangeRecipePopUp(leftBtnTitle: "Cancel", rightBtnTitle: "Confirm", lblText: "Are you sure you want to make changes to this recipe?", customDelegate: self)
    }
    
}

extension EditCreatedRecipeViewController : SwipeMenuViewDelegate {
    
    // MARK - SwipeMenuViewDelegate
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
        // Codes
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
        // Codes
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        index = toIndex
        self.scrollView.isScrollEnabled = true
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
    }
}

extension EditCreatedRecipeViewController: SwipeMenuViewDataSource {
    
    //MARK - SwipeMenuViewDataSource
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return self.arrTitles.count
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return self.arrTitles[index]
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        if index == 0 {
            self.recipeInfoVC.parentVC = self
            self.recipeInfoVC.recipeDtails = self.recipeDtails
            self.recipeInfoVC.didMove(toParent: self)
            return recipeInfoVC
        } else if index == 1 {
            self.ingredientsVC.parentVC = self
            self.ingredientsVC.didMove(toParent: self)
            return ingredientsVC
        } else if index == 2{
            self.nutritionVC.parentVC = self
            self.nutritionVC.recipeDtails = self.recipeDtails
            self.nutritionVC.didMove(toParent: self)
            return nutritionVC
            
        } else if index == 3 {
            self.pairItWith.parentVC = self
            self.pairItWith.recipeDtails = recipeDtails
            self.pairItWith.didMove(toParent: self)
            return pairItWith
        } else {
            
            self.saveOptionVc.parentVC = self
            self.saveOptionVc.cancelTap = {
                self.navigationController?.popViewController(animated: true)
            }
            self.saveOptionVc.didMove(toParent: self)
            return saveOptionVc
        }
        
    }
}
extension EditCreatedRecipeViewController : UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("scrolled")
//        if scrollView == collectionView
//        {
//
//        }
//        else
        if scrollView == self.scrollView
        {
            if scrollView.isAtBottom
            {
                if index == 0
                {
                    if recipeInfoVC.scrollView.contentSize.height > recipeInfoVC.scrollView.frame.size.height
                    {
                        self.scrollView.isScrollEnabled = false
                        self.recipeInfoVC.scrollView.isScrollEnabled = true
                    }
                    else
                    {
                        self.scrollView.isScrollEnabled = true
                        self.recipeInfoVC.scrollView.isScrollEnabled = false
                    }
                }
                else if index == 1
                {
                    if ingredientsVC.scrollView.contentSize.height > ingredientsVC.scrollView.frame.size.height
                    {
                        self.scrollView.isScrollEnabled = false
                        self.ingredientsVC.scrollView.isScrollEnabled = true
                    }
                    else
                    {
                        self.scrollView.isScrollEnabled = true
                        self.ingredientsVC.scrollView.isScrollEnabled = false
                    }
                }
                else if index == 2
                {
                    if nutritionVC.scrollView.contentSize.height > nutritionVC.scrollView.frame.size.height
                    {
                        self.scrollView.isScrollEnabled = false
                        self.nutritionVC.scrollView.isScrollEnabled = true
                    }
                    else
                    {
                        self.scrollView.isScrollEnabled = true
                        self.nutritionVC.scrollView.isScrollEnabled = false
                    }
                }
                else if index == 3
                {
                    if pairItWith.scrollView.contentSize.height > pairItWith.scrollView.frame.size.height
                    {
                        self.scrollView.isScrollEnabled = false
                        self.pairItWith.scrollView.isScrollEnabled = true
                    }
                    else
                    {
                        self.scrollView.isScrollEnabled = true
                        self.pairItWith.scrollView.isScrollEnabled = false
                    }
                }
                else if index == 4
                {
                    if saveOptionVc.scrollView.contentSize.height > saveOptionVc.scrollView.frame.size.height
                    {
                        self.scrollView.isScrollEnabled = false
                        self.saveOptionVc.scrollView.isScrollEnabled = true
                    }
                    else
                    {
                        self.scrollView.isScrollEnabled = true
                        self.saveOptionVc.scrollView.isScrollEnabled = false
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
extension EditCreatedRecipeViewController : DeleteAndChangeRecipePopUpDelegate
{
    func onClickRightButton() {
        self.removeAnimation()
    }
}
