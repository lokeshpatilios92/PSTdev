//
//  AddRecipeAdvanceUserBtnCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 11/11/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class AddRecipeAdvanceUserBtnCell: UITableViewCell {

    @IBOutlet weak var view_LHSBG: UIView!
    @IBOutlet weak var view_AddRecipesBG: UIView!
    
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_SubTitle: UILabel!
    
    @IBOutlet weak var btn_AddRecipes: UIButton!
    @IBOutlet weak var btn_showNutritionDetails: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.view_LHSBG.layer.cornerRadius = 5
        self.view_LHSBG.layer.borderWidth = 0.8
        self.view_LHSBG.layer.borderColor = UIColor.darkGray.cgColor
        
        self.view_AddRecipesBG.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
