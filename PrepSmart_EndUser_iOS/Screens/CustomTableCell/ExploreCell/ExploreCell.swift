//
//  ExploreCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 26/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ExploreCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var popOverBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.addShadow(radius: 5.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
