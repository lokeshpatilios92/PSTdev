//
//  AddRecipeTableViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 18/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class AddRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView_recipe: UIImageView!
    
    @IBOutlet weak var lbl_recipeName: UILabel!
    @IBOutlet weak var lbl_servings: UILabel!
    @IBOutlet weak var lbl_calories: UILabel!
    @IBOutlet weak var lbl_bottomSeparator: UILabel!
    @IBOutlet weak var itemCountLabel:UILabel!
    
    @IBOutlet weak var removeQutButton:UIButton!
    @IBOutlet weak var addQutButton:UIButton!
    
    var itemCount = 1
//    var itemCost = 0.0
//    var selectedArrayIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView_recipe.clipsToBounds = true
        imgView_recipe.layer.cornerRadius = imgView_recipe.frame.height / 2
        
        addQutButton.addTarget(self, action: #selector(onClickPlusMinus(_:)), for: .touchUpInside)
        removeQutButton.addTarget(self, action: #selector(onClickPlusMinus(_:)), for: .touchUpInside)
        
        self.itemCountLabel.text = "\(self.itemCount)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //    MARK :  OnClick Func
    @objc func onClickPlusMinus(_ sender: UIButton)
    {
//        selectedArrayIndex = sender.tag
//        var costAfterChange = self.itemCost
        if sender == addQutButton {
            
            if self.itemCount < 99 {
                self.itemCount = self.itemCount + 1
            }
        }
            
        else {
            if self.itemCount > 1 {
                self.itemCount  = self.itemCount  - 1
            }
        }
        
        self.itemCountLabel.text = "\(self.itemCount )"
    }
}
