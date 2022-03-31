//
//  CookListInstructionsTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 13/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Tags

class CookListInstructionsTableCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var leftCheckImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagView: TagsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
