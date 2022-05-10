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
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblpdfName: UILabel!
    
    var mealAsperday : [MealList]?
    var weeklyPlanData : GetWeeklyPlanTemplateDetailsStruct?
    var dayId : Int = 1
    var global_Var = GlobalClass.sharedManager
    var PlanNutritionixDetailData : DayWiseWeeklyPlanNutritionixDetailsStruct?

    
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
    var arrTitleData = ["Breakfast", "Lunch", "Snacks", "Dinner","other", "" , "Weekly Plan Info", "Notes"]
    var weekDay = ""
    var arrIcons = [#imageLiteral(resourceName: "breakfast_white"),#imageLiteral(resourceName: "lunch_white"),#imageLiteral(resourceName: "snacks_white"),#imageLiteral(resourceName: "dinner_white"),#imageLiteral(resourceName: "breakfast_white"),#imageLiteral(resourceName: "lunch_white"),#imageLiteral(resourceName: "snacks_white"),#imageLiteral(resourceName: "dinner_white")]
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    @IBAction func onPdfCkick(_sender: UIButton){
      print("Download pdf")
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
        let id = weeklyPlanData?.weeklyPlanDetails?.id ?? 0
       if id != 0{
       getNutritionixDetails(dayId:String(dayId), planId:String(id))
        }
        self.tblview_mealTimings.reloadData()
        self.tblview_mealTimings.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.lblTitle.text = self.weeklyPlanData?.weeklyPlanDetails?.name?.capitalized
        self.lblDesc.text = self.weeklyPlanData?.weeklyPlanDetails?.weeklyPlanDetailsDescription
        self.lblpdfName.text = self.weeklyPlanData?.weeklyPlanDetails?.pdfFile
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
        if sender.tag < mealAsperday?.count ?? 0{
            if  mealAsperday?[sender.tag].isExpandable  == false {
                mealAsperday?[sender.tag].isExpandable = true
            }
            else {
                mealAsperday?[sender.tag].isExpandable = false
            }
            tblview_mealTimings.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
            self.constraintTblViewHT.constant = self.tblview_mealTimings.contentSize.height
        }
    }
    //MARK: OnClick Func
    //addRecipeTapped
    @objc func addRecipeTapped(sender: UIButton){
        let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AddRecipesToRecipePackViewController") as! AddRecipesToRecipePackViewController
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
        let count = mealAsperday?.count ?? 0
        return count + 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < mealAsperday?.count ?? 0{
            if mealAsperday?[section].isExpandable == true {
                return mealAsperday?[section].recipeList?.count ?? 0
            }
        }else {
            if section == (mealAsperday?.count ?? 0){
                return 0
            }
            if section == (mealAsperday?.count ?? 0)+1 {
                return 2
            }
            else
            {
                return 1
            }
        }
        return 0
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == (mealAsperday?.count ?? 0) + 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: weeklyPlanInfoTableViewCell) as! WeeklyPlanInfoTableViewCell
            return cell
        }
        if indexPath.section == (mealAsperday?.count ?? 0) + 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: notesTableViewCell) as! NotesTableViewCell
            cell.txtView_notes.text = weeklyPlanData?.weeklyPlanDetails?.planNote
            return cell
        }
        else
        {
            if indexPath.section == (mealAsperday?.count ?? 0)
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
                let dict = mealAsperday?[indexPath.section].recipeList?[indexPath.row]
                cell.lbl_recipeName.text = dict?.recipeName
                cell.itemCountLabel.text = dict?.totalServings
                cell.itemCount = Int(dict?.totalServings ?? "0") ?? 0
                cell.imgView_recipe.sd_setImage(with: URL(string: dict?.recipeImg ?? ""), placeholderImage: UIImage(named: "dinner"))
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == mealAsperday?.count ?? 0 {
            return 150
        }
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section ==  (mealAsperday?.count ?? 0)
        {
            let headerViewCell = tableView.dequeueReusableCell(withIdentifier: macroCounterForDayTableViewCell) as! MacroCounterForDayTableViewCell
            headerViewCell.colView_nutrition.dataSource = self
            headerViewCell.colView_nutrition.delegate = self
            headerViewCell.colView_nutrition.register(UINib.init(nibName: nutritionCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: nutritionCollectionViewCell)
            return headerViewCell.contentView
        }
        
        
        if section == (mealAsperday?.count ?? 0)+1 || section == (mealAsperday?.count ?? 0)+2
        {
            let headerViewCell = tableView.dequeueReusableCell(withIdentifier: weeklyPackHeaderTableViewCell) as! WeeklyPackHeaderTableViewCell
            
            headerViewCell.lbl_title.text = arrTitleData[section]
            headerViewCell.btn_header.tag = section
            headerViewCell.btn_header.addTarget(self, action: #selector(onClickExpandCollapse(_:)), for: .touchUpInside)
            if section < mealAsperday?.count ?? 0{
                if mealAsperday?[section].isExpandable == true
                {
                    headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "arrow_up"), for: .normal)
                }
                else
                {
                    headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "arrow_down"), for: .normal)
                }
            }
            return headerViewCell.contentView
        }
        else
        {
            let headerViewCell = tableView.dequeueReusableCell(withIdentifier: weeklyPlanTitleTableViewCell) as! WeeklyPlanTitleTableViewCell
            
            headerViewCell.lbl_title.text = mealAsperday?[section].mealName
            headerViewCell.imgView_mealTime?.image = arrIcons[section]
            headerViewCell.btn_header.tag = section
            headerViewCell.btn_header.tblView = tableView
            headerViewCell.btn_header.addTarget(self, action: #selector(onClickExpandCollapse(_:)), for: .touchUpInside)
            
            if mealAsperday?[section].isExpandable == true
            {
                //                headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "up_arrow_white"), for: .normal)
                headerViewCell.arraowImageView.image = #imageLiteral(resourceName: "up_arrow_white")
            }
            else
            {
                //   headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "drop_arrow_white"), for: .normal)
                headerViewCell.arraowImageView.image = #imageLiteral(resourceName: "drop_arrow_white")
            }
            
            return headerViewCell.contentView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
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


extension WeeklyPlanContainerViewController {
    func getNutritionixDetails(dayId:String, planId:String)
    {
        let param:[String:Any] = ["weekly_plan_id": planId,
                                  "day_id": dayId]
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getWeeklyPlanTemplateNutritionixDetails, params: param , method: .post) {  (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.PlanNutritionixDetailData = try JSONDecoder().decode(DayWiseWeeklyPlanNutritionixDetailsStruct.self, from: data)
                            self.tblview_mealTimings.reloadData()
                            self.tblview_mealTimings.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
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
