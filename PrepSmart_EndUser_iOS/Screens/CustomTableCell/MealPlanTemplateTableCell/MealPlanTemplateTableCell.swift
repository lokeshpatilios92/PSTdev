//
//  MealPlanTemplateTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 06/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class MealPlanTemplateTableCell: UITableViewCell {

    @IBOutlet var view_main: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var selectTemplateView: UIView!
    @IBOutlet weak var selectDayView: UIView!
    @IBOutlet weak var selectMealView: UIView!
    @IBOutlet weak var servingSize: UIView!
    @IBOutlet weak var selectTemplateLabel: UILabel!
    @IBOutlet weak var selectTemplateTextField: KKNEWTextFiled!
    @IBOutlet weak var selectTemplateImageView: UIImageView!
    @IBOutlet weak var selectDayLabel: UILabel!
    @IBOutlet weak var selectDayTextField: KKNEWTextFiled!
    @IBOutlet weak var selectMealLabel: UILabel!
    @IBOutlet weak var selectMealTextField: KKNEWTextFiled!
    @IBOutlet weak var servingSizeLabel: UILabel!
    @IBOutlet weak var servingSizeTextField: KKNEWTextFiled!
    @IBOutlet weak var servingSizeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_main.layer.borderWidth = 1.0
        view_main.layer.borderColor = UIColor.appGrayColor().cgColor
        view_main.layer.cornerRadius = 3.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
