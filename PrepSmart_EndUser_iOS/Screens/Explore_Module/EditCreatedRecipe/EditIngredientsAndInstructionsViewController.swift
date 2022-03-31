//
//  EditIngredientsAndInstructionsViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 11/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class EditIngredientsAndInstructionsViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var stepTableView: UITableView!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    @IBOutlet weak var surrevingTextFiled: UITextField!
    @IBOutlet weak var addStepsTextFileds: UITextField!
    @IBOutlet weak var ingredientsTextFiled: UITextField!
    @IBOutlet weak var cookingTimeTextFileds: UITextField!
    
    @IBOutlet weak var stepTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ingredientTableViewHeight: NSLayoutConstraint!
    var parentVC: EditCreatedRecipeViewController?
    
    var stepArray : [String] = []
    var ingredients : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //    MARK: OnClick Func
    @IBAction func onClickAddStepButton(_ sender: Any) {
        parentVC?.showAddNewInstructionPopUp(customDelegate: self)
//        parentVC?.
//        if self.addStepsTextFileds.text != "" {
//            self.stepArray.append(self.addStepsTextFileds.text!)
//            self.addStepsTextFileds.resignFirstResponder()
//            self.addStepsTextFileds.text = ""
//            stepTableView.reloadData()
//            stepTableViewHeight.constant = stepTableView.contentSize.height
//        }
    }
    
    @IBAction func onClickAddIngredientsButton(_ sender: Any) {
        
        parentVC?.showAddIngredientsPopUp(customDelegate: self)
        
//        self.ingredients.append(self.ingredientsTextFiled.text!)
//        self.ingredientsTextFiled.resignFirstResponder()
//        self.ingredientsTextFiled.text = ""
//
//        ingredientsTableView.reloadData()
//        ingredientTableViewHeight.constant = ingredientsTableView.contentSize.height
    }
    
    @objc func onClickDeleteStepButton(_ sender: UIButton) {
        self.stepArray.remove(at: sender.tag)
        self.stepTableView.reloadData()
    }
    
    @objc func onClickDeleteIngredientsButton(_ sender: UIButton) {
        self.ingredients.remove(at: sender.tag)
        ingredientsTableView.reloadData()
    }
}

extension EditIngredientsAndInstructionsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.stepTableView {
            return stepArray.count
        } else {
            return ingredients.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.stepTableView {
            let stepCell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath) as! StepCell
            
            stepCell.deleteButton.tag = indexPath.row
            stepCell.titleLabel.text = "Step \(indexPath.row + 1) : \(stepArray[indexPath.row])"
            
            return stepCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "instructionsCell", for: indexPath) as! InstructionsCell
            cell.deleteButton.tag = indexPath.row
            return cell
        }
    }
}


class StepCell : UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
}

class InstructionsCell : UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
}

extension EditIngredientsAndInstructionsViewController : CustomAddIngredientPopUpDelegate
{
    
}

extension EditIngredientsAndInstructionsViewController : CustomAddAddNewInstructionPopUpDelegate
{
    
}

