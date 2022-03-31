//
//  EditWeeklyPlanContainerViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 10/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD134, PSTMOBSTD122, PSTMOBSTD136-1

import UIKit

class EditWeeklyPlanContainerViewController: BaseViewController {

    @IBOutlet var btn_save: UIButton!
    @IBOutlet var btn_cancel: UIButton!
    @IBOutlet var scroll_main: UIScrollView!
    @IBOutlet weak var tblview_mealTimings: UITableView!
    @IBOutlet weak var constraintTblViewHT: NSLayoutConstraint!
    
    let editWeeklyInfoTableCell = "EditWeeklyInfoTableCell"
    let editRecipeTableCell = "EditRecipeTableCell"
    let weeklyPlanTitleTableViewCell = "WeeklyPlanTitleTableViewCell"
    let macroCounterTableViewCell = "MacroCounterTableViewCell"
    let weeklyPackHeaderTableViewCell = "WeeklyPackHeaderTableViewCell"
    let macroCounterForDayTableViewCell = "MacroCounterForDayTableViewCell"
    let nutritionCollectionViewCell = "NutritionCollectionViewCell"
    let editMacroCounterTableCell = "EditMacroCounterTableCell"
    let editRecipeFooterTableCell = "EditRecipeFooterTableCell"
    
    var isTitleExpanded = [true,false,false,false,false,true]
    var arrTitleData = ["Edit Info","Breakfast","Lunch","Dinner","Other",""]
    var weekDay = ""
    var arrIcons = [#imageLiteral(resourceName: "breakfast_white"),#imageLiteral(resourceName: "breakfast_white"),#imageLiteral(resourceName: "lunch_white"),#imageLiteral(resourceName: "snacks_white"),#imageLiteral(resourceName: "dinner_white"),#imageLiteral(resourceName: "dinner_white")]
    var currentNutritionCollectionCell = 0
    var isPDFUploaded = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialize()
    }
    
    func initialize()
    {
        tblview_mealTimings.dataSource = self
        tblview_mealTimings.delegate = self
        
        self.tblview_mealTimings.estimatedRowHeight = 100.0
        self.tblview_mealTimings.rowHeight = UITableView.automaticDimension
        
        tblview_mealTimings.register(UINib.init(nibName: editRecipeFooterTableCell, bundle: nil), forCellReuseIdentifier: editRecipeFooterTableCell)
        tblview_mealTimings.register(UINib.init(nibName: editWeeklyInfoTableCell, bundle: nil), forCellReuseIdentifier: editWeeklyInfoTableCell)
        tblview_mealTimings.register(UINib.init(nibName: editMacroCounterTableCell, bundle: nil), forCellReuseIdentifier: editMacroCounterTableCell)
        tblview_mealTimings.register(UINib.init(nibName: weeklyPlanTitleTableViewCell, bundle: nil), forCellReuseIdentifier: weeklyPlanTitleTableViewCell)
        tblview_mealTimings.register(UINib.init(nibName: editRecipeTableCell, bundle: nil), forCellReuseIdentifier: editRecipeTableCell)
        tblview_mealTimings.register(UINib.init(nibName: macroCounterTableViewCell, bundle: nil), forCellReuseIdentifier: macroCounterTableViewCell)
        tblview_mealTimings.register(UINib.init(nibName: weeklyPackHeaderTableViewCell, bundle: nil), forCellReuseIdentifier: weeklyPackHeaderTableViewCell)
        tblview_mealTimings.register(UINib.init(nibName: macroCounterForDayTableViewCell, bundle: nil), forCellReuseIdentifier: macroCounterForDayTableViewCell)
 
        self.tblview_mealTimings.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        self.tblview_mealTimings.layoutIfNeeded()
        
        btn_save.layer.cornerRadius = btn_save.frame.height / 2
        btn_cancel.layer.borderWidth = 1.0
        btn_cancel.layer.borderColor = UIColor.appOrangeColor().cgColor
        btn_cancel.layer.cornerRadius = btn_cancel.frame.height / 2
//        self.tblview_mealTimings.reloadData()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tblview_mealTimings.layer.removeAllAnimations()
        constraintTblViewHT.constant = tblview_mealTimings.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.tblview_mealTimings.updateConstraints()
            self.tblview_mealTimings.layoutIfNeeded()
        }

    }
    
    @IBAction func onClickBtnAddRecipes(_ sender: UIButton) {
        
    }
    
    
    @objc func onClickExpandCollapse(_ sender : UIButton)
    {
        isTitleExpanded[sender.tag] = !isTitleExpanded[sender.tag]
        self.tblview_mealTimings.reloadData()
//        tblview_mealTimings.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
//        self.tblview_mealTimings.layoutIfNeeded()
//        self.constraintTblViewHT.constant = self.tblview_mealTimings.contentSize.height
    }
    
    override func viewWillLayoutSubviews() {
        DispatchQueue.main.async {
            self.constraintTblViewHT.constant = self.tblview_mealTimings.contentSize.height//+ 150
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView != scroll_main)
        {
            let indexPathOfCollection = IndexPath(row: 0, section: 5)
            let tableCell = tblview_mealTimings.cellForRow(at: indexPathOfCollection) as? EditMacroCounterTableCell
            
            let offSet1 = tableCell?.collection.contentOffset.x
            let width1 = tableCell?.collection.frame.width
            let horizontalCenter1 = (width1 ?? 0) / 2
            
            currentNutritionCollectionCell = Int((offSet1 ?? 0) + horizontalCenter1) / Int(width1 ?? 1)
            
            if(currentNutritionCollectionCell == 0)
            {
                tableCell?.btn_previous.isHidden = true
            }
            else
            {
                tableCell?.btn_previous.isHidden = false
            }
            
            if(currentNutritionCollectionCell == 9)
            {
                tableCell?.btn_next.isHidden = true
            }
            else
            {
                tableCell?.btn_next.isHidden = false
            }
        }
    }
    
    
    @IBAction func btn_cancel(_ sender: UIButton) {
        
        
    }
    
    @IBAction func onClickBtnSave(_ sender: UIButton) {
        
        
    }
    
    @IBAction func onClickBtnUpload(_ sender: UIButton) {
        
    }
    
    
    @IBAction func onClickBtnRemoveFile(_ sender: UIButton) {
        
    }
    
    
    @IBAction func onClickBtnPrevious(_ sender: UIButton) {
        let indexPathOfCollection = IndexPath(row: 0, section: 5)
        let tableCell = tblview_mealTimings.cellForRow(at: indexPathOfCollection) as! EditMacroCounterTableCell
        
        if(currentNutritionCollectionCell != 0)
        {
            let indexPathForCollection = IndexPath(item: currentNutritionCollectionCell - 1, section: 0)
            tableCell.collection.scrollToItem(at: indexPathForCollection, at: .left, animated: true)
        }
    }
    
    
    @IBAction func onClickNextBtn(_ sender: UIButton) {
        let indexPathOfCollection = IndexPath(row: 0, section: 5)
        let tableCell = tblview_mealTimings.cellForRow(at: indexPathOfCollection) as! EditMacroCounterTableCell
        
        if(currentNutritionCollectionCell != 9)
        {
            let indexPathForCollection = IndexPath(item: currentNutritionCollectionCell + 1, section: 0)
            tableCell.collection.scrollToItem(at: indexPathForCollection, at: .left, animated: true)
        }

    }
}

extension EditWeeklyPlanContainerViewController : UITableViewDataSource, UITableViewDelegate
{

//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//            if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
//                if indexPath == lastVisibleIndexPath {
//                    self.constraintTblViewHT.constant = self.tblview_mealTimings.contentSize.height
//                }
//            }
//    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isTitleExpanded.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 5
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
                return 6
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
         {
            let headerViewCell = tableView.dequeueReusableCell(withIdentifier: editWeeklyInfoTableCell) as! EditWeeklyInfoTableCell
            
            if(isPDFUploaded == true)
            {
               headerViewCell.view_removePDF.isHidden = false
            }
            else
            {
               headerViewCell.view_removePDF.isHidden = true
            }
            
            return headerViewCell
         }
        else if(indexPath.section == 5)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: editMacroCounterTableCell) as! EditMacroCounterTableCell

                            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                            layout.itemSize = CGSize(width: cell.collection.frame.width, height: 120.0)
                            layout.scrollDirection = .horizontal
                            layout.minimumLineSpacing = 0
                            layout.minimumInteritemSpacing = 0
            
                            cell.collection.isPagingEnabled = true
                            cell.collection.collectionViewLayout = layout
                            cell.collection.register(UINib(nibName: "NutritionProgressCollectionCell", bundle: nil), forCellWithReuseIdentifier: "NutritionProgressCollectionCell")
                            cell.collection.showsVerticalScrollIndicator = false
                            cell.collection.backgroundColor = .white
                            cell.collection.dataSource = self
                            cell.collection.delegate = self
//                            cell.collection.reloadData()
            
                            return cell
        }
        else
        {
                let cell = tableView.dequeueReusableCell(withIdentifier: editRecipeTableCell) as! EditRecipeTableCell
                
                if indexPath.row == 3
                {
                    cell.lbl_bottomSeparator.isHidden = true
                }
                else
                {
                    cell.lbl_bottomSeparator.isHidden = false
                }
                return cell
//            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 5)
        {
            return 0.0
        }
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(section == 5)
        {
            return nil
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
        if(isTitleExpanded[section] == true && section != 5 && section != 0)
        {
            return 100.0
        }
        else
        {
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

            if(isTitleExpanded[section] == true && section != 5 && section != 0)
            {
                let footerViewCell = tableView.dequeueReusableCell(withIdentifier: editRecipeFooterTableCell) as! EditRecipeFooterTableCell
                
                return footerViewCell.contentView
            }
            else
            {
                return nil
            }
        
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
//            if indexPath == lastVisibleIndexPath {
//                self.constraintTblViewHT.constant = self.tblview_mealTimings.contentSize.height
//            }
//        }
//    }
    
}

extension EditWeeklyPlanContainerViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NutritionProgressCollectionCell", for: indexPath) as! NutritionProgressCollectionCell
        cell.viewProgress1.startProgress(to: 45.0, duration: 3)
        cell.viewProgress2.startProgress(to: 55.0, duration: 3)
        cell.viewProgress3.startProgress(to: 80.0, duration: 3)
        cell.viewProgress4.startProgress(to: 75.0, duration: 3)
        
        cell.viewProgress4.startProgress(to: 49, duration: 10.0) {
            print("Done animating!")
        }
        
        return cell
    }
    

}
