//
//  AddToMealPopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 06/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

protocol CustomAddToMealPopUpVCDelegate{
    func onClickAddButton()
}


class AddToMealPopUpVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstraintOfTableView: NSLayoutConstraint!
    @IBOutlet weak var addBtn: UIButton!
    
    var customDelegate : CustomAddToMealPopUpVCDelegate!
    
    let mealPlanTemplateTableCell = "MealPlanTemplateTableCell"
    let weeklyPlanTableCell = "WeeklyPlanTableCell"
    let weeklyPlanTitleTableViewCell = "AddToTableHeaderView"
    
    
    let headerData = ["Meal Plan","Meal Plan Template"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.initialize()
        // Do any additional setup after loading the view.
    }
    
    func initialize() {
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        self.addBtn.layer.cornerRadius = addBtn.frame.height/2
        
        tableView.register(UINib.init(nibName: weeklyPlanTitleTableViewCell, bundle: nil), forHeaderFooterViewReuseIdentifier: weeklyPlanTitleTableViewCell)
        tableView.register(UINib.init(nibName: weeklyPlanTableCell, bundle: nil), forCellReuseIdentifier: weeklyPlanTableCell)
        tableView.register(UINib.init(nibName: mealPlanTemplateTableCell, bundle: nil), forCellReuseIdentifier: mealPlanTemplateTableCell)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        self.heightConstraintOfTableView.constant = tableView.contentSize.height
    }
    
    @IBAction func onClickCloseButton(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    
    @IBAction func onClickAddButton(_ sender: UIButton) {
        if customDelegate != nil {
            self.customDelegate.onClickAddButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    
}

extension AddToMealPopUpVC : UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AddToTableHeaderView") as? AddToTableHeaderView
        
        headerCell?.img_dropDown.isHidden = true
        headerCell?.btn_dropDown.isHidden = true
        headerCell?.btn_dropDown.tag = section
        headerCell?.btn_info.tag = section
        headerCell?.lbl_title.tag = section
        headerCell?.btn_info.isHidden = true
        
        headerCell?.lbl_title.text! = headerData[section]
        headerCell?.lbl_title.textColor = UIColor.white
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: weeklyPlanTableCell, for: indexPath) as! WeeklyPlanTableCell
            cell.servingSizeImageView.isHidden = true
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: mealPlanTemplateTableCell, for: indexPath) as! MealPlanTemplateTableCell
            cell.servingSizeImageView.isHidden = true
            return cell
        }
    }
    
}

