//
//  CookingListTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 12/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class CookingListTableCell: UITableViewCell {

    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var servingSizeLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.checkBox.boxType = .square
        self.checkBox.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
