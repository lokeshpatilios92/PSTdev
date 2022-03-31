//
//  ViewRecipeReviewsAndCommentsTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 12/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ViewRecipeReviewsAndCommentsTableCell: UITableViewCell {
    
    @IBOutlet var height_innerTableView: NSLayoutConstraint!
    @IBOutlet var view_main: UIView!
    @IBOutlet var tbl_ratingsAndComments: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
