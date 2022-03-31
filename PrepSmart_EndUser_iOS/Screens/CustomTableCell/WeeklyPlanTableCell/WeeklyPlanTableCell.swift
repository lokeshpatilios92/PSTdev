//
//  WeeklyPlanTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 16/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class WeeklyPlanTableCell: UITableViewCell {
    
    @IBOutlet var view_main: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var selectWeekView: UIView!
    @IBOutlet weak var selectDayView: UIView!
    @IBOutlet weak var selectMealView: UIView!
    @IBOutlet weak var servingSize: UIView!
    @IBOutlet weak var selectWeekLabel: UILabel!
    @IBOutlet weak var selectWeekTextField: KKNEWTextFiled!
    @IBOutlet weak var selectWeekImageView: UIImageView!
    @IBOutlet weak var selectDayLabel: UILabel!
    @IBOutlet weak var selectDayTextField: KKNEWTextFiled!
    @IBOutlet weak var selectDayImageView: UIImageView!
    @IBOutlet weak var selectMealLabel: UILabel!
    @IBOutlet weak var selectMealTextField: KKNEWTextFiled!
    @IBOutlet weak var servingSizeLabel: UILabel!
    @IBOutlet weak var servingSizeTextField: KKNEWTextFiled!
    @IBOutlet weak var selectMealImageView: UIImageView!
    @IBOutlet weak var servingSizeImageView: UIImageView!
    @IBOutlet weak var selectWeekButton: UIButton!
    @IBOutlet weak var selectDayButton: UIButton!
    @IBOutlet weak var selectMealButton: UIButton!
    @IBOutlet weak var servingSizeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view_main.layer.borderWidth = 1.0
        view_main.layer.borderColor = UIColor.appGrayColor().cgColor
        view_main.layer.cornerRadius = 3.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
