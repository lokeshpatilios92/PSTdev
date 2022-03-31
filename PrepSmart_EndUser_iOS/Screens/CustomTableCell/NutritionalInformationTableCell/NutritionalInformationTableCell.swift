//
//  NutritionalInformationTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 20/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class NutritionalInformationTableCell: UITableViewCell {

    @IBOutlet var btn_pairItNext: UIButton!
    @IBOutlet var btn_pairItPrevious: UIButton!
    @IBOutlet var view_pairIt: UIView!
    @IBOutlet var view_nutrition: UIView!
    @IBOutlet var btn_previous: UIButton!
    @IBOutlet var btn_next: UIButton!
    @IBOutlet var collection_recipe: UICollectionView!
    @IBOutlet var collection_nutritionalInfo: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        view_pairIt.layer.borderWidth = 0.3
        view_pairIt.layer.borderColor = UIColor.lightGray.cgColor
        view_pairIt.layer.cornerRadius = 3.0
        
        view_nutrition.layer.borderWidth = 0.3
        view_nutrition.layer.borderColor = UIColor.lightGray.cgColor
        view_nutrition.layer.cornerRadius = 3.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
