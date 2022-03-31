//
//  WeeklyPlanContainerViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 18/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class WeeklyPlanContainerViewController: BaseViewController {

    @IBOutlet weak var tblview_mealTimings: UITableView!
    @IBOutlet weak var constraintTblViewHT: NSLayoutConstraint!
    
    let addRecipeTableViewCell = "AddRecipeTableViewCell"
    let weeklyPlanTitleTableViewCell = "WeeklyPlanTitleTableViewCell"
    let macroCounterTableViewCell = "MacroCounterTableViewCell"
    let weeklyPackHeaderTableViewCell = "WeeklyPackHeaderTableViewCell"
    let weeklyPlanInfoTableViewCell = "WeeklyPlanInfoTableViewCell"
    let macroCounterForDayTableViewCell = "MacroCounterForDayTableViewCell"
    let nutritionCollectionViewCell = "NutritionCollectionViewCell"
    let notesTableViewCell = "NotesTableViewCell"
    let addRecipeAdvanceUserBtnCell = "AddRecipeAdvanceUserBtnCell"
    
    var isTitleExpanded = [true,false,false,false,false,true,true]
    var arrTitleData = ["Breakfast", "Lunch", "Snacks", "Dinner", "" , "Weekly Plan Info", "Notes"]
    var weekDay = ""
    var arrIcons = [#imageLiteral(resourceName: "breakfast_white"),#imageLiteral(resourceName: "lunch_white"),#imageLiteral(resourceName: "snacks_white"),#imageLiteral(resourceName: "dinner_white")]
    //    var isSubTitleExpanded = [false,false,false,false]
    //    var arrSubTitleData = ["Breakfast", "Lunch", "Snacks", "Dinner"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialize()
    }
    
    func initialize()
    {
        tblview_mealTimings.dataSource = self
        tblview_mealTimings.delegate = self
        
        tblview_mealTimings.register(UINib.init(nibName: weeklyPlanTitleTableViewCell, bundle: nil), forCellReuseIdentifier: weeklyPlanTitleTableViewCell)
        tblview_mealTimings.register(UINib.init(nibName: addRecipeTableViewCell, bundle: nil), forCellReuseIdentifier: addRecipeTableViewCell)
        tblview_mealTimings.register(UINib.init(nibName: macroCounterTableViewCell, bundle: nil), forCellReuseIdentifier: macroCounterTableViewCell)
        tblview_mealTimings.register(UINib.init(nibName: weeklyPackHeaderTableViewCell, bundle: nil), forCellReuseIdentifier: weeklyPackHeaderTableViewCell)
        tblview_mealTimings.register(UINib.init(nibName: macroCounterForDayTableViewCell, bundle: nil), forCellReuseIdentifier: macroCounterForDayTableViewCell)
        tblview_mealTimings.register(UINib.init(nibName: weeklyPlanInfoTableViewCell, bundle: nil), forCellReuseIdentifier: weeklyPlanInfoTableViewCell)
        tblview_mealTimings.register(UINib.init(nibName: notesTableViewCell, bundle: nil), forCellReuseIdentifier: notesTableViewCell)
        tblview_mealTimings.register(UINib(nibName: addRecipeAdvanceUserBtnCell, bundle: .none), forCellReuseIdentifier: addRecipeAdvanceUserBtnCell)
        
        tblview_mealTimings.reloadData()
        //self.constraintTblViewHT.constant = self.tblview_mealTimings.contentSize.height + 150
        self.tblview_mealTimings.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tblview_mealTimings.layer.removeAllAnimations()
        constraintTblViewHT.constant = tblview_mealTimings.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.tblview_mealTimings.updateConstraints()
            self.tblview_mealTimings.layoutIfNeeded()
        }
    }
    
    @objc func onClickExpandCollapse(_ sender : UIButton)
    {
        isTitleExpanded[sender.tag] = !isTitleExpanded[sender.tag]
        tblview_mealTimings.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
        self.constraintTblViewHT.constant = self.tblview_mealTimings.contentSize.height
    }
    
//    override func viewWillLayoutSubviews() {
//        DispatchQueue.main.async {
//            self.constraintTblViewHT.constant = self.tblview_mealTimings.contentSize.height + 150
//        }
//    }
    //MARK: OnClick Func
    //addRecipeTapped
    @objc func addRecipeTapped(sender: UIButton){
        let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AddRecipesToRecipePackViewController") as! AddRecipesToRecipePackViewController
        //        let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AddRecipeViewController") as! AddRecipeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showNutritionInfo()
    {
        let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "DetailedNutritionalInfoViewController") as! DetailedNutritionalInfoViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension WeeklyPlanContainerViewController : UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return isTitleExpanded.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 5
        {
            if isTitleExpanded[section]
            {
                return 3
            }
        }
        else if section == 6
        {
            if isTitleExpanded[section]
            {
                return 1
            }
        }
        else
        {
            if isTitleExpanded[section]
            {
                return 5
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 5
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: weeklyPlanInfoTableViewCell) as! WeeklyPlanInfoTableViewCell
            return cell
        }
        if indexPath.section == 6
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: notesTableViewCell) as! NotesTableViewCell
            return cell
        }
        else
        {
            if indexPath.row == 4
            {
//                let cell = tableView.dequeueReusableCell(withIdentifier: macroCounterTableViewCell) as! MacroCounterTableViewCell
//                return cell
                let cell = tableView.dequeueReusableCell(withIdentifier: addRecipeAdvanceUserBtnCell, for: indexPath) as! AddRecipeAdvanceUserBtnCell
                cell.btn_AddRecipes.tag = indexPath.row
                cell.btn_AddRecipes.addTarget(self, action: #selector(addRecipeTapped), for: .touchUpInside)
                cell.btn_showNutritionDetails.addTarget(self, action: #selector(showNutritionInfo), for: .touchUpInside)
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: addRecipeTableViewCell) as! AddRecipeTableViewCell
                
                if indexPath.row == 3
                {
                    cell.lbl_bottomSeparator.isHidden = true
                }
                else
                {
                    cell.lbl_bottomSeparator.isHidden = false
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 4
        {
            return 230.0
        }
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 4
        {
            let headerViewCell = tableView.dequeueReusableCell(withIdentifier: macroCounterForDayTableViewCell) as! MacroCounterForDayTableViewCell
            headerViewCell.colView_nutrition.dataSource = self
            headerViewCell.colView_nutrition.delegate = self
            headerViewCell.colView_nutrition.register(UINib.init(nibName: nutritionCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: nutritionCollectionViewCell)
            return headerViewCell.contentView
        }
        else if section == 5 || section == 6
        {
            let headerViewCell = tableView.dequeueReusableCell(withIdentifier: weeklyPackHeaderTableViewCell) as! WeeklyPackHeaderTableViewCell
            
            headerViewCell.lbl_title.text = arrTitleData[section]
            headerViewCell.btn_header.tag = section
            headerViewCell.btn_header.addTarget(self, action: #selector(onClickExpandCollapse(_:)), for: .touchUpInside)
            
            if isTitleExpanded[section]
            {
                headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "arrow_up"), for: .normal)
            }
            else
            {
                headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "arrow_down"), for: .normal)
            }
            
            return headerViewCell.contentView
        }
        else
        {
            let headerViewCell = tableView.dequeueReusableCell(withIdentifier: weeklyPlanTitleTableViewCell) as! WeeklyPlanTitleTableViewCell
            
            headerViewCell.lbl_title.text = arrTitleData[section]
            headerViewCell.imgView_mealTime?.image = arrIcons[section]
            headerViewCell.btn_header.tag = section
            headerViewCell.btn_header.tblView = tableView
            headerViewCell.btn_header.addTarget(self, action: #selector(onClickExpandCollapse(_:)), for: .touchUpInside)
            
            if isTitleExpanded[section]
            {
//                headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "up_arrow_white"), for: .normal)
                headerViewCell.arraowImageView.image = #imageLiteral(resourceName: "up_arrow_white")
            }
            else
            {
//                headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "drop_arrow_white"), for: .normal)
                headerViewCell.arraowImageView.image = #imageLiteral(resourceName: "drop_arrow_white")
            }
            
            return headerViewCell.contentView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 4
        {
            return 15.0
        }
        return 0.000001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        return footerView
    }
}

extension WeeklyPlanContainerViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NutritionCollectionViewCell", for: indexPath) as! NutritionCollectionViewCell
        cell.progressView.maxValue = 1000.0
        cell.progressView.value = 500.0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 140.0)
    }
}
