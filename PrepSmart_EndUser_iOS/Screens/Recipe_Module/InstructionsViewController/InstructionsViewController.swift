//
//  InstructionsViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 10/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
// Screen ID :- PSTMOBSTD142

import UIKit

protocol InstructionsViewControllerDelegate {
    func onClickInstructionNextButton()
    func onClickInstructionBacktButton()
}

class InstructionsViewController: BaseViewController {

    @IBOutlet weak var tblView_instruction: UITableView!
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var cookingTimeBackView: UIView!
    @IBOutlet weak var cookingTimeTextField: UITextField!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    
    let instructionsTableViewCell = "InstructionsTableViewCell"
    let ingredientsTableViewCell = "IngredientsTableViewCell"
    let instructionsHeaderTableViewCell = "InstructionsHeaderTableViewCell"
    var isExpanded = [true,false,false]
    var customDelegate : InstructionsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initialize()
        
    }
    
    func initialize()
    {
        btn_next.clipsToBounds = true
        btn_next.layer.cornerRadius = btn_next.frame.height/2
        btn_next.layer.borderWidth = 0.5
        btn_next.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
        
        btn_back.clipsToBounds = true
        btn_back.layer.cornerRadius = btn_next.frame.height/2
        btn_back.layer.borderWidth = 0.5
        btn_back.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
        
        tblView_instruction.dataSource = self
        tblView_instruction.delegate = self
        
        tblView_instruction.register(UINib.init(nibName: instructionsTableViewCell, bundle: nil), forCellReuseIdentifier: instructionsTableViewCell)
        tblView_instruction.register(UINib.init(nibName: ingredientsTableViewCell, bundle: nil), forCellReuseIdentifier: ingredientsTableViewCell)
        tblView_instruction.register(UINib.init(nibName: instructionsHeaderTableViewCell, bundle: nil), forCellReuseIdentifier: instructionsHeaderTableViewCell)
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        if customDelegate != nil {
            self.customDelegate.onClickInstructionBacktButton()
        }
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        if customDelegate != nil {
            self.customDelegate.onClickInstructionNextButton()
        }
    }
    
    
    @objc func onClickExpandCollapse(_ sender : UIButton)
    {
        if sender.tag == 2{
         print("Nutrition Click")
        }else{
            isExpanded[sender.tag] = !isExpanded[sender.tag]
            tblView_instruction.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
        }
    }

    @objc func onClickAddNewInstructionOrIngredient(_ sender: UIButton)
    {
        if sender.tag == 0 //Instructions
        {
            let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AddNewInstructionPopUpViewController") as! AddNewInstructionPopUpViewController
            
            vc.customDelegate = self
            
            vc.view.frame = self.view.bounds;
            vc.willMove(toParent: self)
            self.view.addSubview(vc.view)
            self.addChild(vc)
            vc.didMove(toParent: self)
        }
        else if sender.tag == 1 //Ingredients
        {
            let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AddNewIngredientPopupViewController") as! AddNewIngredientPopupViewController
            
            vc.customDelegate = self
            
            vc.view.frame = self.view.bounds;
            vc.willMove(toParent: self)
            self.view.addSubview(vc.view)
            self.addChild(vc)
            vc.didMove(toParent: self)
        }
    }
    
}

extension InstructionsViewController : AddNewInstructionPopUpViewControllerDelegate
{
    func onClickSaveButton() {
        print("Instruction Save Clicked")
    }
    
    func onClickCancelButton() {
        print("Instruction Cancel Clicked")
    }
}

extension InstructionsViewController : AddNewIngredientPopupViewControllerDelegate
{
    func onClickIngredientSaveButton() {
        print("Ingredient Save Clicked")
    }
    
    func onClickIngredientCancelButton() {
        print("Ingredient Cancel Clicked")
    }
    
}

extension InstructionsViewController : UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return isExpanded.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isExpanded[section]
        {
            return 4
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: instructionsTableViewCell) as! InstructionsTableViewCell
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: ingredientsTableViewCell) as! IngredientsTableViewCell
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isExpanded[section]
        {
            return 115.0
        }
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewCell = tableView.dequeueReusableCell(withIdentifier: instructionsHeaderTableViewCell) as! InstructionsHeaderTableViewCell
        
        if section == 0
        {
            headerViewCell.lbl_title.text = "Instructions"
            headerViewCell.btn_add.setTitle("Add Instructions", for: .normal)
            
            if isExpanded[section]
            {
                headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "up_arrow_white"), for: .normal)
            }
            else
            {
                headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "drop_arrow_white"), for: .normal)
            }
        }
        else if section == 1
        {
            headerViewCell.lbl_title.text = "Ingredients"
            headerViewCell.btn_add.setTitle("Add Ingredients", for: .normal)
            
            if isExpanded[section]
            {
                headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "up_arrow_white"), for: .normal)
            }
            else
            {
                headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "drop_arrow_white"), for: .normal)
            }
        }else{
            
            headerViewCell.lbl_title.text = "Preview Nutrition Info"
            if isExpanded[section]
            {
                headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "white_forward_arrow"), for: .normal)
            }
            else
            {
                headerViewCell.btn_arrow.setImage(#imageLiteral(resourceName: "white_forward_arrow"), for: .normal)
            }
            
        }
        
        headerViewCell.btn_header.tag = section
        headerViewCell.btn_header.addTarget(self, action: #selector(onClickExpandCollapse(_:)), for: .touchUpInside)
        
        headerViewCell.btn_add.tag = section
        headerViewCell.btn_add.addTarget(self, action: #selector(onClickAddNewInstructionOrIngredient(_:)), for: .touchUpInside)
        
        return headerViewCell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if isExpanded[section]
        {
            return 20.0
        }
        return 0.000001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        return footerView
    }
}
