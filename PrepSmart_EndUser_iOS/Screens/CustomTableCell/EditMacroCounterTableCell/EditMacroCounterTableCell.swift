//
//  EditMacroCounterTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 10/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class EditMacroCounterTableCell: UITableViewCell {

    @IBOutlet var btn_next: UIButton!
    @IBOutlet var btn_previous: UIButton!
    @IBOutlet var btn_nextView: UIButton!
    @IBOutlet var collection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        btn_nextView.layer.cornerRadius = btn_nextView.frame.size.height / 2
        // Configure the view for the selected state
    }
    
}
