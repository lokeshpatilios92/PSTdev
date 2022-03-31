//
//  SubscriptionsTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 08/11/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class SubscriptionsTableCell: UITableViewCell {
    
    @IBOutlet weak var view_Bg      : UIView!
    @IBOutlet weak var view_Cost    : UIView!
    @IBOutlet weak var img_Profile  : UIImageView!
    @IBOutlet weak var lbl_Title    : UILabel!
    @IBOutlet weak var lbl_SubTitle : UILabel!
    @IBOutlet weak var lbl_Cost     : UILabel!
    @IBOutlet weak var btn_PlanInfo : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view_Bg.layer.cornerRadius  = 5
        view_Bg.layer.borderColor   = UIColor.appGrayColor().cgColor
        view_Bg.layer.borderWidth   = 0.5
        
        view_Cost.layer.cornerRadius = 5
        view_Cost.layer.borderColor  = UIColor.appGrayColor().cgColor
        view_Cost.layer.borderWidth  = 0.5
        
        btn_PlanInfo.layer.cornerRadius  = btn_PlanInfo.frame.height / 2 
    }
}
