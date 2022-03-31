//
//  IngredientsAndInstructionsCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 20/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class IngredientsAndInstructionsCell: UITableViewCell {
    
    @IBOutlet var lbl_cookingTime: UILabel!
    @IBOutlet var lbl_stepDescription: UILabel!
    @IBOutlet var lbl_stepNumber: UILabel!
    @IBOutlet var lbl_listElement: UILabel!
    @IBOutlet var view_main: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view_main.layer.borderWidth = 0.3
        view_main.layer.borderColor = UIColor.lightGray.cgColor
        view_main.layer.cornerRadius = 3.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func config(dictdata:RecipeInfo?){
        let dict = dictdata?.ingredientsList
        let dictInstruction = dictdata?.instructionList
        var listElement = ""
        var listSteps = ""
        var instructionsteps = ""
        
        for index in 0..<(dict?.count ?? 0) {
            let quantity = String(dict![index].quantity ?? "" )
            let usedunit = String(dict![index].unit ?? "" )
            let ingredient = String(dict![index].ingredientName?.capitalized ?? "")
            listElement = listElement + String(ingredient) + "\n"
            listSteps = listSteps + String(quantity + " " + usedunit  + " ") + "\n"
        }
        lbl_listElement.text = listElement
        lbl_stepNumber.text = listSteps
        
        for index in 0..<(dictInstruction?.count ?? 0) {
            let steps = String(dictInstruction![index].step ?? 0 )
            let istructions = String(dictInstruction![index].stepInstruction ?? "" )
            instructionsteps = "Step " + steps + " : " + String(istructions) + "\n"
        }
        lbl_stepDescription.text = instructionsteps
        lbl_cookingTime.text = String(dictdata?.cookingTime ?? 0) + " minutes"
    }
    
}
