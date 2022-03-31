//
//  AddDayWiseWeeklyPlanViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 14/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class AddDayWiseWeeklyPlanViewController: UIViewController {

    @IBOutlet weak var tblview_weekdays: UITableView!
    @IBOutlet weak var btn_done: UIButton!
    
    var instructionsTableViewCell = "InstructionsTableViewCell"
    var ingredientsTableViewCell = "IngredientsTableViewCell"
    var weeklyPackHeaderTableViewCell = "WeeklyPackHeaderTableViewCell"
    var weeklyPackSubHeaderTableViewCell = "WeeklyPackSubHeaderTableViewCell"
    var weeklyPlanTitleTableViewCell = "WeeklyPlanTitleTableViewCell"
    
    var isTitleExpanded = [true,false,false,false,false,false,false]
    var arrTitleData = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var isSubTitleExpanded = [false,false,false,false]
    var arrSubTitleData = ["Breakfast", "Lunch", "Snacks", "Dinner"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialize()
    }
    
    func initialize()
    {
        btn_done.clipsToBounds = true
        btn_done.layer.cornerRadius = btn_done.frame.height/2
        
        tblview_weekdays.dataSource = self
        tblview_weekdays.delegate = self
        
        tblview_weekdays.register(UINib.init(nibName: weeklyPackHeaderTableViewCell, bundle: nil), forCellReuseIdentifier: weeklyPackHeaderTableViewCell)
        tblview_weekdays.register(UINib.init(nibName: weeklyPackSubHeaderTableViewCell, bundle: nil), forCellReuseIdentifier: weeklyPackSubHeaderTableViewCell)
    }

    @IBAction func onClickDone(_ sender: Any) {
        
    }
    
    @objc func onClickExpandCollapse(_ sender : UIButton)
    {
        isTitleExpanded[sender.tag] = !isTitleExpanded[sender.tag]
        tblview_weekdays.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
    }
    
    @objc func onClickSubTitleExpandCollapse(_ sender : CustomButton)
    {
        isSubTitleExpanded[sender.tag] = !isSubTitleExpanded[sender.tag]
        //tblview_weekdays.reloadData()
        //tblview_weekdays.reloadSections(IndexSet.init(integer: sender.tblView!.tag), with: .automatic)
        
        tblview_weekdays.reloadRows(at: [IndexPath.init(row: 0, section: sender.tblView!.tag)], with: .automatic)
        sender.tblView?.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
        
//        tblview_weekdays.reloadRows(at: [IndexPath.init(row: 0, section: sender.tblView!.tag)], with: .automatic)
    }
}

extension AddDayWiseWeeklyPlanViewController : UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tblview_weekdays
        {
            return isTitleExpanded.count
        }
        else
        {
            return isSubTitleExpanded.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblview_weekdays
        {
            if isTitleExpanded[section]
            {
                return 1
            }
            return 0
        }
        else
        {
            if isSubTitleExpanded[section]
            {
                return 4
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblview_weekdays
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: weeklyPackSubHeaderTableViewCell) as! WeeklyPackSubHeaderTableViewCell
            
            cell.tblView_mealTimings.dataSource = self
            cell.tblView_mealTimings.delegate = self
            
            cell.tblView_mealTimings.tag = indexPath.row
            
            cell.tblView_mealTimings.register(UINib.init(nibName: weeklyPlanTitleTableViewCell, bundle: nil), forCellReuseIdentifier: weeklyPlanTitleTableViewCell)
            cell.tblView_mealTimings.register(UINib.init(nibName: instructionsTableViewCell, bundle: nil), forCellReuseIdentifier: instructionsTableViewCell)
            
            //cell.tblView_mealTimings.reloadData()
            
//            DispatchQueue.main.async {
//                let frame = CGRect.init(x: 0.0, y: 0.0, width: cell.tblView_mealTimings.frame.width, height: cell.tblView_mealTimings.contentSize.height)
//                cell.tblView_mealTimings.frame = frame
//            }
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: instructionsTableViewCell) as! InstructionsTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblview_weekdays
        {
            if isTitleExpanded[indexPath.section]
            {
                var height = isTitleExpanded.count * 60
                for value in isSubTitleExpanded
                {
                    if value
                    {
                        height = height + 240
                    }
                }
                return CGFloat(height)
            }
            else
            {
                return 0
            }
        }
        return UITableView.automaticDimension
//        DispatchQueue.main.async {
//            let frame = CGRect.init(x: 0.0, y: 0.0, width: cell.tblView_mealTimings.frame.width, height: cell.tblView_mealTimings.contentSize.height)
//            cell.tblView_mealTimings.frame = frame
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tblview_weekdays
        {
            let headerViewCell = tableView.dequeueReusableCell(withIdentifier: weeklyPackHeaderTableViewCell) as! WeeklyPackHeaderTableViewCell
            
            headerViewCell.lbl_title.text = arrTitleData[section]
            
            headerViewCell.btn_header.tag = section
            headerViewCell.btn_header.addTarget(self, action: #selector(onClickExpandCollapse(_:)), for: .touchUpInside)
            
            return headerViewCell.contentView
        }
        else
        {
            let headerViewCell = tableView.dequeueReusableCell(withIdentifier: weeklyPlanTitleTableViewCell) as! WeeklyPlanTitleTableViewCell
            
            headerViewCell.lbl_title.text = arrSubTitleData[section]
            //headerViewCell.delegate = self
            headerViewCell.btn_header.tag = section
            headerViewCell.btn_header.tblView = tableView
            headerViewCell.btn_header.addTarget(self, action: #selector(onClickSubTitleExpandCollapse(_:)), for: .touchUpInside)
            
            return headerViewCell.contentView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
}
