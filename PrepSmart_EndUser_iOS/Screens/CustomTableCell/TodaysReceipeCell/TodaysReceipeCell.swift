//
//  TodaysReceipeCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 06/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class TodaysReceipeCell: UITableViewCell {
    
    @IBOutlet var view_main: UIView!
    @IBOutlet var view_orange: UIView!
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var view_shadow: UIView!
    @IBOutlet var img_icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view_orange.layer.cornerRadius = view_orange.frame.size.height / 2
        view_main.layer.cornerRadius = 3.0
        view_shadow.layer.cornerRadius = view_shadow.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
}
