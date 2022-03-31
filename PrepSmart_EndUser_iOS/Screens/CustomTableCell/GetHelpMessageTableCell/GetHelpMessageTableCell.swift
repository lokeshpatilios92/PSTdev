//
//  GetHelpMessageTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 31/01/20.
//  Copyright © 2020 Exceptionaire.co. All rights reserved.
//

import UIKit

class GetHelpMessageTableCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var msgTextField: UITextField!
    @IBOutlet weak var sepratorLabel: UILabel!
    @IBOutlet weak var msgTxtCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
