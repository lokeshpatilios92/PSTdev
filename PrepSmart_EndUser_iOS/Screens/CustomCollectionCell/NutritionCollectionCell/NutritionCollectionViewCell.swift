//
//  NutritionCollectionViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 19/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import UICircularProgressRing

class NutritionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var progressView: UICircularProgressRing!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_value: UILabel!
    @IBOutlet weak var imgView_recipe: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        progressView.innerRingColor = UIColor.init(red: 46.0/255.0, green: 161.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        progressView.innerRingWidth = 2.0
        progressView.outerRingColor = #colorLiteral(red: 0.9176470588, green: 0.9098039216, blue: 0.9137254902, alpha: 1)
        progressView.outerRingWidth = 2.0
        
        //progressView.valueKnobStyle = .init(size: 6.0, color: UIColor.init(red: 46.0/255.0, green: 161.0/255.0, blue: 49.0/255.0, alpha: 1.0))
        //Search for - 5 in UICircularProgressRing
        
        progressView.style = .ontop
        progressView.innerRingSpacing = 0.0
        progressView.isClockwise = false
        progressView.startAngle = 90.0
        progressView.shouldShowValueText = false
        
        imgView_recipe.isHidden = true
        imgView_recipe.layer.cornerRadius = imgView_recipe.frame.height / 2
        imgView_recipe.clipsToBounds = true
    }

}
