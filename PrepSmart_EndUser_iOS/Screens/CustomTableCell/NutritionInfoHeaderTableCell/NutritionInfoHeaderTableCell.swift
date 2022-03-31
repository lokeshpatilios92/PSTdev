//
//  NutritionInfoHeaderTableCell.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 19/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class NutritionInfoHeaderTableCell: UITableViewCell {
    @IBOutlet weak var leftBgView: UIView!
    @IBOutlet weak var rightBgView: UIView!
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var leftLabelLeadingSpace: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
