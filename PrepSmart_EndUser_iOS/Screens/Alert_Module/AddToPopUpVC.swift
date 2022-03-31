//
//  AddToPopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 16/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD126, PSTMOBSTD117, PSTMOBSTD109, PSTMOBSTD033

import UIKit

protocol CustomAddToPopUpVCDelegate{
    func onClickAddButton()
}

class AddToPopUpVC: UIViewController {
    
    @IBOutlet var tbl_recipePlan: UITableView!
    var arr_headerTitle = [String]()
    var isDropDownBtnClicked = [Bool]()
    var customDelegate : CustomAddToPopUpVCDelegate!
    @IBOutlet var btn_cancel: UIButton!
    @IBOutlet var btn_add: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    func initialize()
    {
        arr_headerTitle = ["Weekly Plan","Weekly Plan Template","Recipe Pack"]
        
        for i in arr_headerTitle
        {
            print(i)
            isDropDownBtnClicked.append(false)
        }
        
        tbl_recipePlan.register(UINib.init(nibName: "AddToTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "AddToTableHeaderView")
        
         tbl_recipePlan.register(UINib.init(nibName: "WeeklyPlanTableCell", bundle: nil), forCellReuseIdentifier: "weeklyPlan")
        
        tbl_recipePlan.register(UINib.init(nibName: "WeeklyPlanTemplateTableCell", bundle: nil), forCellReuseIdentifier: "WeeklyPlanTemplate")
        
        tbl_recipePlan.register(UINib.init(nibName: "RecipePackTableCell", bundle: nil), forCellReuseIdentifier: "RecipePack")
        
        tbl_recipePlan.delegate = self
        tbl_recipePlan.dataSource = self
        
        self.tbl_recipePlan.estimatedRowHeight = 100.0
        self.tbl_recipePlan.rowHeight = UITableView.automaticDimension
        
        btn_add.layer.cornerRadius = btn_add.frame.size.height / 2
        btn_cancel.layer.cornerRadius = btn_cancel.frame.size.height / 2
        btn_cancel.layer.borderColor = UIColor.appOrangeColor().cgColor
        btn_cancel.layer.borderWidth = 0.5
        
        self.tbl_recipePlan.reloadData()
    }
    
    //MARK:Button Actions
    @IBAction func onClickBtnClose(_ sender: UIButton) {
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
    
    @IBAction func onClickBtnCancel(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    
    @IBAction func onClickBtnDropDown(_ sender: UIButton) {
        
        if(isDropDownBtnClicked[sender.tag] == false)
        {
            isDropDownBtnClicked[sender.tag] = true
        }
        else
        {
            isDropDownBtnClicked[sender.tag] = false
        }
        
         self.tbl_recipePlan.reloadData()
    }
    
    @objc func onClickInfoButton(_ sender: UIButton)
       {
           let popUp = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "RecipeInfoPopUpViewController") as! RecipeInfoPopUpViewController
           popUp.customDelegate = self
           
           if sender.tag == 0
           {
               popUp.titleText = "Weekly Plan"
               popUp.mesgText = "A week's worth of recipes organized into a meal plan assigned to a specific calendar week."
           }
           else if sender.tag == 1
           {
               popUp.titleText = "Weekly Plan Template"
               popUp.mesgText = "A week's worth of recipes saved as a template that can be used again and again."
           }
           else
           {
               popUp.titleText = "Recipe Pack"
               popUp.mesgText = "A Recipe Pack is a collection of recipes that fit a certain occasion or common theme. Think of it as a mini cookbook. Examples include: Summer Grilling Menu, The Perfect Thanksgiving, Family Picnic, and Top 20 Super food Smoothies."
           }
           
           popUp.bottomImageName = #imageLiteral(resourceName: "img-2")
           
           popUp.view.frame = self.view.bounds;
           popUp.willMove(toParent: self)
           self.view.addSubview(popUp.view)
           self.addChild(popUp)
           popUp.didMove(toParent: self)
       }
}

extension AddToPopUpVC : RecipeInfoPopUpViewControllerDelegate
{
    func onClickLearnMoreButton() {
        
    }
}

extension AddToPopUpVC : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AddToTableHeaderView") as? AddToTableHeaderView
        
        headerCell?.img_dropDown.isHidden = true
        headerCell?.btn_dropDown.isHidden = true
        headerCell?.btn_dropDown.tag = section
        headerCell?.btn_info.tag = section
        headerCell?.lbl_title.tag = section
        headerCell?.btn_info.layer.cornerRadius = (headerCell?.btn_info.frame.size.height)! / 2
        headerCell?.btn_info.addTarget(self, action: #selector(onClickInfoButton(_:)), for: .touchUpInside)
        
        headerCell?.lbl_title.text! = arr_headerTitle[section]
        headerCell?.lbl_title.textColor = UIColor.white
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arr_headerTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isDropDownBtnClicked[section] == true)
        {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "weeklyPlan", for: indexPath) as! WeeklyPlanTableCell
            
            cell.selectWeekButton.tag = indexPath.row
            cell.selectWeekButton.addTarget(self, action: #selector(onClickSelectWeekBtn(_sender:)), for: .touchUpInside)
            
            return cell
        }
        else if(indexPath.section == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyPlanTemplate", for: indexPath) as! WeeklyPlanTemplateTableCell
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipePack", for: indexPath) as! RecipePackTableCell
            
            return cell
        }
    }
    
    
    
    
    @objc func onClickSelectWeekBtn(_sender : UIButton)
    {
        self.dismiss(animated: true) {
            self.showCalendarViewController(setTopLabel: "Select the week you would like to assign this template to:", customDelegate: self)
        }
        
        
    }
}



extension AddToPopUpVC : CustomCalendarViewController//CustomSelectDateRangeVCDelegate
{
    func onClickAddButton() {
        let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "AddVC") as! AddVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func onClickSelectButtonAction()
//    {
//        let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "AddVC") as! AddVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }

}
