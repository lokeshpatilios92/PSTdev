//
//  SepretorTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 16/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class SepretorTableCell: UITableViewCell {
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var sepreatorLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
