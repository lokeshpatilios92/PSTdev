//
//  NotificationCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 09/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var dateAndTimeLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        backView.layer.cornerRadius = 5
        backView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
