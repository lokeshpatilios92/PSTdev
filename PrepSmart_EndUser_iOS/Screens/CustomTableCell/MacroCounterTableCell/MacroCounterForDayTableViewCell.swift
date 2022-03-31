//
//  MacroCounterForDayTableViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 19/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class MacroCounterForDayTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var colView_nutrition: UICollectionView!
    @IBOutlet weak var view_main: ConsultationTableViewCell!
    @IBOutlet weak var lbl_separator: UILabel!
    @IBOutlet weak var btn_info: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_main.clipsToBounds = true
        view_main.layer.cornerRadius = 3.0
        view_main.layer.borderColor = UIColor.lightGray.cgColor
        view_main.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
