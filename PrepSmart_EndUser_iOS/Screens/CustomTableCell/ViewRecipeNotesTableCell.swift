//
//  ViewRecipeNotesTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 12/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ViewRecipeNotesTableCell: UITableViewCell {

    @IBOutlet var lbl_myNotes: UILabel!
    @IBOutlet var lbl_recipeNotes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
