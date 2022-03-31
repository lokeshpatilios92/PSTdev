//
//  EditWeeklyInfoTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 10/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class EditWeeklyInfoTableCell: UITableViewCell {

    @IBOutlet var lbl_fileName: UILabel!
    @IBOutlet var btn_remove: UIButton!
    @IBOutlet var btn_upload: UIButton!
    @IBOutlet var txt_notes: KKNEWTextFiled!
    @IBOutlet var txt_tags: KKNEWTextFiled!
    @IBOutlet var txt_dietType: KKNEWTextFiled!
    @IBOutlet var txt_category: KKNEWTextFiled!
    @IBOutlet var txt_description: KKNEWTextFiled!
    @IBOutlet var txt_name: KKNEWTextFiled!
    @IBOutlet var stackView_uploadFile: UIStackView!
    @IBOutlet var view_removePDF: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
