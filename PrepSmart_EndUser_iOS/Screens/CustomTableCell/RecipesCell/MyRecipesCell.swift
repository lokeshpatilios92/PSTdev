//
//  MyRecipesCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 31/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class MyRecipesCell: UITableViewCell {

   
    @IBOutlet weak var lbl_count: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var imgView_ProfilePic: UIImageView!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView_ProfilePic.layer.cornerRadius = imgView_ProfilePic.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
