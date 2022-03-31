//
//  NotesTableViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 20/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var txtView_notes: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
