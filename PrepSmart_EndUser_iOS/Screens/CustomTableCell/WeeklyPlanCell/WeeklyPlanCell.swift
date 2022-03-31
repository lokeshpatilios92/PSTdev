//
//  WeeklyPlanCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 09/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class WeeklyPlanCell: UITableViewCell {

    @IBOutlet var reorderRowBtn: UIButton!
    @IBOutlet var recipieImgView: UIImageView!
    @IBOutlet var recipeTitleLbl: UILabel!
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var subtractBtn: UIButton!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var vitaminLbl: UILabel!
    @IBOutlet var servingsCountLbl: UILabel!
    @IBOutlet var separatorView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       recipieImgView.layer.cornerRadius = recipieImgView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
