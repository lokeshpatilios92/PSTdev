//
//  MenuTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh Kulkarni on 26/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class MenuTableCell: UITableViewCell {

    @IBOutlet weak var itemImageView : UIImageView!
    @IBOutlet weak var dotView : UIImageView!
    @IBOutlet weak var itemNameLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dotView.layer.cornerRadius = dotView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
