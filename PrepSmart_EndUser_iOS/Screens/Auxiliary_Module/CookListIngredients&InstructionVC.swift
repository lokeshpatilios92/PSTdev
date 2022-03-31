//
//  CookListIngredients&InstructionVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 13/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//
// Screen ID :- PSTMOBSTD062,PSTMOBSTD064

import UIKit

class CookListIngredients_InstructionVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var servingSizeLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    let sectionHeaderTableCell = "SectionHeaderTableCell"
    let cookListIngredientsTableCell = "CookListIngredientsTableCell"
    let cookListInstructionsTableCell = "CookListInstructionsTableCell"
    let sepretorTableCell = "SepretorTableCell"
    
    var ingredientsArray : [String] = []
    var selectedIngredientsArray : [String] = []
    var instructionArray : [String] = []
    var selectedInstructionArray : [String] = []
    
    var recipeListObj : Recipe_list1?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
        // Do any additional setup after loading the view.
    }
 
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func initialization() {
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Cook List")
        
        tableView.register(UINib.init(nibName: sectionHeaderTableCell, bundle: nil), forCellReuseIdentifier: sectionHeaderTableCell)
        tableView.register(UINib.init(nibName: cookListIngredientsTableCell, bundle: nil), forCellReuseIdentifier: cookListIngredientsTableCell)
        tableView.register(UINib.init(nibName: cookListInstructionsTableCell, bundle: nil), forCellReuseIdentifier: cookListInstructionsTableCell)
        tableView.register(UINib.init(nibName: sepretorTableCell, bundle: nil), forCellReuseIdentifier: sepretorTableCell)
        
        ingredientsArray = []
        instructionArray = []
        if ingredientsArray == []
        {
            for i in recipeListObj?.ingredients_list ?? []
            {
                ingredientsArray.append(i.ingredientName ?? "")
            }
        }
        if instructionArray == []
        {
            for i in recipeListObj?.instruction ?? []
            {
                instructionArray.append(i.step_instruction ?? "")
            }
        }
        
        servingSizeLabel.text = "Srtving Size : \(String(describing: recipeListObj?.total_servings ?? ""))"
        let cookTime = String(recipeListObj?.cooking_time ?? 0)
        cookingTimeLabel.text = "Cooking Time : \(cookTime)"
    }
}

extension CookListIngredients_InstructionVC : UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 10
        }else{
            return self.viewForHeaderInSection(section: section).frame.height
        }
    }
    
    
    func viewForHeaderInSection(section : Int) -> UIView {
        
        let headerView = tableView.dequeueReusableCell(withIdentifier: sectionHeaderTableCell) as! SectionHeaderTableCell
        
        if section == 0{
            headerView.titleLabel.text = "Ingredients"
        }else if section == 2{
            headerView.titleLabel.text = "Instruction"
        }else if section == 3{
           // headerView.titleLabel.text = "\(selectedInstructionArray.count) Completed items)"
            headerView.titleLabel.text = ""
        }
        return headerView.contentView
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return ingredientsArray.count + 1
        }else if section == 1{
            if selectedIngredientsArray.count != 0{
                return selectedIngredientsArray.count + 1
            }else{
                return selectedIngredientsArray.count
            }
        }else if section == 2{
            return instructionArray.count + 1
        }else{
            return selectedInstructionArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row  == ingredientsArray.count {
                
                let cell_seprator = tableView.dequeueReusableCell(withIdentifier: sepretorTableCell, for: indexPath) as! SepretorTableCell
                return cell_seprator
                
            }else{
                let cell_Ingredients = tableView.dequeueReusableCell(withIdentifier: cookListIngredientsTableCell, for: indexPath) as! CookListIngredientsTableCell
                
                cell_Ingredients.titleLabel.text = ingredientsArray[indexPath.row]
                cell_Ingredients.leftCheckImage.image = #imageLiteral(resourceName: "check_mark_orange_normal")
                
                if indexPath.row % 2 == 0{
                    cell_Ingredients.backView.backgroundColor = .white
                }else{
                    cell_Ingredients.backView.backgroundColor = .groupTableViewBackground
                }
                
                return cell_Ingredients
            }

        }
        else if indexPath.section == 1{
            
            if indexPath.row  == selectedIngredientsArray.count {
                
                let cell_seprator = tableView.dequeueReusableCell(withIdentifier: sepretorTableCell, for: indexPath) as! SepretorTableCell
                return cell_seprator
                
            }else{
            let cell_Ingredients = tableView.dequeueReusableCell(withIdentifier: cookListIngredientsTableCell, for: indexPath) as! CookListIngredientsTableCell
            
            cell_Ingredients.titleLabel.text = selectedIngredientsArray[indexPath.row]
            cell_Ingredients.leftCheckImage.image = #imageLiteral(resourceName: "check_mark_orange")
            cell_Ingredients.backView.backgroundColor = .groupTableViewBackground
            return cell_Ingredients
            }
        }
        else if indexPath.section == 2{
            
            if indexPath.row == instructionArray.count{
                
                let cell_seprator = tableView.dequeueReusableCell(withIdentifier: sepretorTableCell, for: indexPath) as! SepretorTableCell
                return cell_seprator
            }else{
                let cell_Instructions = tableView.dequeueReusableCell(withIdentifier: cookListInstructionsTableCell, for: indexPath) as! CookListInstructionsTableCell
                
                cell_Instructions.titleLabel.text = instructionArray[indexPath.row]
                cell_Instructions.leftCheckImage.image = #imageLiteral(resourceName: "check_mark_orange_normal")
                cell_Instructions.tagView.isHidden = true
//                cell_Instructions.tagView.isHidden = false
//                cell_Instructions.tagView.tags = "Item 1 , Item 2 , Item 3 , Item 4"
//                cell_Instructions.tagView.tagLayerRadius = cell_Instructions.tagView.height/2
                return cell_Instructions
            }
          
        }
        else if indexPath.section == 3{
            let cell_Instructions = tableView.dequeueReusableCell(withIdentifier: cookListInstructionsTableCell, for: indexPath) as! CookListInstructionsTableCell
            
            cell_Instructions.titleLabel.text = selectedInstructionArray[indexPath.row]
            cell_Instructions.tagView.isHidden = true
            cell_Instructions.leftCheckImage.image = #imageLiteral(resourceName: "check_mark_orange")
            return cell_Instructions
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0{
            selectedIngredientsArray.append(ingredientsArray[indexPath.row])
            ingredientsArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
        else if indexPath.section == 1{
            ingredientsArray.append(selectedIngredientsArray[indexPath.row])
            selectedIngredientsArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
        else if indexPath.section == 2{
            selectedInstructionArray.append(instructionArray[indexPath.row])
            instructionArray.remove(at: indexPath.row)
            tableView.reloadData()
        }else{
            instructionArray.append(selectedInstructionArray[indexPath.row])
            selectedInstructionArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        if ingredientsArray.isEmpty && instructionArray.isEmpty
        {
            self.showRecipeCompletedVC(customDelegate: self)
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3{
            let footerView = UIView()
            footerView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
            return footerView
        }else{
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         if section == 3{
            return 10
         }else{
            return 0
        }
    }
    
}

extension CookListIngredients_InstructionVC: CustomRecipeCompletedViewControllerDelegate
{
    func onClickOkButton(feedbackText: String?, rating: Double?) {
        
    }
}

