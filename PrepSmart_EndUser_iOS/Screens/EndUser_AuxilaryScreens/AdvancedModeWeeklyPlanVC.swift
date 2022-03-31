//
//  AdvancedModeWeeklyPlanVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Nishant on 05/02/20.
//  Copyright © 2020 Exceptionaire.co. All rights reserved.
//

import UIKit

class AdvancedModeWeeklyPlanVC: BaseViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var view_loadWeeklyPlanTemplate: UIView!
    @IBOutlet weak var btn_ok: UIButton!
    
    
    let addRecipeTableViewCell = "AddRecipeTableViewCell"
     let weeklyPlanTitleTableViewCell = "WeeklyPlanTitleTableViewCell"
     let macroCounterTableViewCell = "MacroCounterTableViewCell"
     let weeklyPackHeaderTableViewCell = "WeeklyPackHeaderTableViewCell"
     let weeklyPlanInfoTableViewCell = "WeeklyPlanInfoTableViewCell"
     let macroCounterForDayTableViewCell = "MacroCounterForDayTableViewCell"
     let nutritionCollectionViewCell = "NutritionCollectionViewCell"
     let notesTableViewCell = "NotesTableViewCell"
     let addRecipeAdvanceUserBtnCell = "AddRecipeAdvanceUserBtnCell"
    let loadWeeklyPlanCell = "LoadWeeklyPlanCell"
    
    var isExpandable : [Bool] = [false,false,false,false]
    
    let sectionImageArray = [#imageLiteral(resourceName: "breakfast_white"),#imageLiteral(resourceName: "lunch_white"),#imageLiteral(resourceName: "snacks_white"),#imageLiteral(resourceName: "dinner_white")]
    
    let sectionTitleArray = ["Breakfast (1 of 2 complete)","Lunch (0 of 2 complete)","Dinner (3 of 5 complete)","Other (3 of 5 complete)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialize()
    }
    
    func initialize(){
         self.navigationItem.titleView = UtilityManager.getTitleLabel("Weekly Plan")
        tableView.register(UINib.init(nibName: loadWeeklyPlanCell, bundle: nil), forCellReuseIdentifier: loadWeeklyPlanCell)
        tableView.register(UINib.init(nibName: weeklyPlanTitleTableViewCell, bundle: nil), forCellReuseIdentifier: weeklyPlanTitleTableViewCell)
        tableView.register(UINib.init(nibName: addRecipeTableViewCell, bundle: nil), forCellReuseIdentifier: addRecipeTableViewCell)
        tableView.register(UINib.init(nibName: macroCounterTableViewCell, bundle: nil), forCellReuseIdentifier: macroCounterTableViewCell)
        tableView.register(UINib.init(nibName: weeklyPackHeaderTableViewCell, bundle: nil), forCellReuseIdentifier: weeklyPackHeaderTableViewCell)
        tableView.register(UINib.init(nibName: macroCounterForDayTableViewCell, bundle: nil), forCellReuseIdentifier: macroCounterForDayTableViewCell)
        tableView.register(UINib.init(nibName: weeklyPlanInfoTableViewCell, bundle: nil), forCellReuseIdentifier: weeklyPlanInfoTableViewCell)
        tableView.register(UINib.init(nibName: notesTableViewCell, bundle: nil), forCellReuseIdentifier: notesTableViewCell)
        tableView.register(UINib(nibName: addRecipeAdvanceUserBtnCell, bundle: .none), forCellReuseIdentifier: addRecipeAdvanceUserBtnCell)
        self.view_loadWeeklyPlanTemplate.layer.cornerRadius = self.view_loadWeeklyPlanTemplate.frame.height/2
        self.btn_ok.layer.cornerRadius = self.btn_ok.layer.frame.height/2
    }
    
  

    @IBAction func loadWeekPlanClicked(_ sender: UIButton) {
    }
    
    @objc func onClickToggleButton(sender:UIButton) {
          isExpandable[sender.tag] = !isExpandable[sender.tag]
          tableView.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
          //        self.constraintTblViewHT.constant = self.tblview_mealTimings.contentSize.height
      }
    
}
extension AdvancedModeWeeklyPlanVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isExpandable.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if isExpandable[section]{
                return 3
            }
        case 1:
            if isExpandable[section]{
                return 2
            }
        case 2:
            if isExpandable[section]{
                return 4
            }
        case 3:
            if isExpandable[section] {
                return 3
            }
        case 4:
            if isExpandable[section] {
                return 1
            }
        default:
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: macroCounterForDayTableViewCell, for: indexPath) as! MacroCounterForDayTableViewCell
            cell.colView_nutrition.delegate = self
            cell.colView_nutrition.dataSource = self
            cell.colView_nutrition.register(UINib.init(nibName: nutritionCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: nutritionCollectionViewCell)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: loadWeeklyPlanCell, for: indexPath) as! LoadWeeklyPlanCell
            return cell
        }
        
       
  
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: weeklyPlanTitleTableViewCell) as! WeeklyPlanTitleTableViewCell
        cell.contentView.backgroundColor = .groupTableViewBackground
        cell.btn_header.tag = section
        cell.arraowImageView.image = #imageLiteral(resourceName: "drop_arrow_white")
        cell.lbl_title.text = sectionTitleArray[section]
        cell.imgView_mealTime.image = sectionImageArray[section]
        cell.btn_header.addTarget(self, action: #selector(self.onClickToggleButton(sender:)), for: .touchUpInside)
        
        
        if isExpandable[section]
        {
            cell.arraowImageView.image = #imageLiteral(resourceName: "up_arrow_white")
        }
        else
        {
            cell.arraowImageView.image = #imageLiteral(resourceName: "drop_arrow_white")
        }
        
        return cell.contentView
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .groupTableViewBackground
        return view
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "CookListIngredients_InstructionVC") as! CookListIngredients_InstructionVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
extension AdvancedModeWeeklyPlanVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
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
