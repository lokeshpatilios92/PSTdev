//
//  SettingsCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 06/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

   
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var learnMoreBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imageContainerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       imageContainerView.layer.cornerRadius = imageContainerView.frame.height/2
        learnMoreBtn.setTextUnderline(UIColor.appOrangeColor(), string: learnMoreBtn.currentTitle!)
        learnMoreBtn.setTextColor(UIColor.appOrangeColor(), string: learnMoreBtn.currentTitle!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
