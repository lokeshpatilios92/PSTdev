//
//  DietTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh Kulkarni on 25/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class DietTableCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var rightImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
