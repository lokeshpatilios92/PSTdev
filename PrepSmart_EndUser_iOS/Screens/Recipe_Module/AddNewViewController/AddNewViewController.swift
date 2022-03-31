//
//  AddNewViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 05/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class AddNewViewController: BaseViewController {

    let addNewCell = "AddNewTableViewCell"
    let arrTitles = ["Recipe", "Recipe Pack", "Weekly Plan Template"]
    var isRecipeSelected = false
    var isRecipePackSelected = false
    var isWeeklyPlanSelected = false
    
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var tblView_addNew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialize()
    }
    
    func initialize()
    {
        tblView_addNew.register(UINib.init(nibName: addNewCell, bundle: nil), forCellReuseIdentifier: addNewCell)
        
        btn_next.clipsToBounds = true
        btn_next.layer.cornerRadius = btn_next.frame.height / 2
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Add New")
    }

    @IBAction func onClickNextButton(_ sender: Any) {
        if isRecipeSelected
        {
            let addRecipeVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AddRecipeViewController") as! AddRecipeViewController
            self.navigationController?.pushViewController(addRecipeVC, animated: true)
        }
        else if isRecipePackSelected
        {
            let addRecipePackVC = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "AddRecipePackVC") as! AddRecipePackVC
            self.navigationController?.pushViewController(addRecipePackVC, animated: true)
        }
        else if isWeeklyPlanSelected
        {
            let addWeeklyPackVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AddNewWeeklyPlanViewController") as! AddNewWeeklyPlanViewController
            self.navigationController?.pushViewController(addWeeklyPackVC, animated: true)
        }
    }
    
    @objc func onClickInfoButton(_ sender: UIButton)
    {
        let popUp = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "RecipeInfoPopUpViewController") as! RecipeInfoPopUpViewController
        popUp.customDelegate = self
        
        if sender.tag == 0
        {
            popUp.titleText = "Recipe"
            popUp.mesgText = "Recipes can be a full meal, a single entree, a snack, a drink or any other recipe."
        }
        else if sender.tag == 1
        {
            popUp.titleText = "Recipe Pack"
            popUp.mesgText = "A Recipe Pack is a collection of recipes that fit a certain occasion or common theme. Think of it as a mini cookbook based on a topic of your choosing. Examples include: Summer Grilling Menu, The Perfect Thanksgiving, Family Picnic, and Top 20 Super food Smoothies."
        }
        else
        {
            popUp.titleText = "Weekly Plan"
            popUp.mesgText = "A collection of Recipes that creates a weekly plan for you to follow."
        }
        
        popUp.bottomImageName = #imageLiteral(resourceName: "img-2")
        
        popUp.view.frame = self.view.bounds;
        popUp.willMove(toParent: self)
        self.view.addSubview(popUp.view)
        self.addChild(popUp)
        popUp.didMove(toParent: self)
    }
}

extension AddNewViewController : RecipeInfoPopUpViewControllerDelegate
{
    func onClickLearnMoreButton() {
        
    }
}

extension AddNewViewController : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: addNewCell, for: indexPath) as! AddNewTableViewCell
        
        cell.lbl_title.text = arrTitles[indexPath.row]
        cell.btn_info.tag = indexPath.row
        cell.btn_info.addTarget(self, action: #selector(self.onClickInfoButton(_:)), for: .touchUpInside)
        cell.headerButton.isHidden = true
        
        if indexPath.row == 0
        {
//            cell.btn_info.isHidden = true
            if isRecipeSelected
            {
                cell.imgView_radio.image = #imageLiteral(resourceName: "radio_active")
            }
            else
            {
                cell.imgView_radio.image = #imageLiteral(resourceName: "radio_normal")
            }
        }
        else if indexPath.row == 1
        {
//            cell.btn_info.isHidden = false
            if isRecipePackSelected
            {
                cell.imgView_radio.image = #imageLiteral(resourceName: "radio_active")
            }
            else
            {
                cell.imgView_radio.image = #imageLiteral(resourceName: "radio_normal")
            }
        }
        else if indexPath.row == 2
        {
//            cell.btn_info.isHidden = false
            if isWeeklyPlanSelected
            {
                cell.imgView_radio.image = #imageLiteral(resourceName: "radio_active")
            }
            else
            {
                cell.imgView_radio.image = #imageLiteral(resourceName: "radio_normal")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        isRecipeSelected = false
        isRecipePackSelected = false
        isWeeklyPlanSelected = false
        
        if indexPath.row == 0
        {
            isRecipeSelected = true
        }
        else if indexPath.row == 1
        {
            isRecipePackSelected = true
        }
        else if indexPath.row == 2
        {
            isWeeklyPlanSelected = true
        }
        tblView_addNew.reloadData()
    }
}
