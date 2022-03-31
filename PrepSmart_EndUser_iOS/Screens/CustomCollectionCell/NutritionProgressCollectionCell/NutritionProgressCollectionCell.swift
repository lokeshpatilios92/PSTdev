//
//  NutritionProgressCollectionCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 21/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import UICircularProgressRing

class NutritionProgressCollectionCell: UICollectionViewCell {
    
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var viewProgress1: UICircularProgressRing!
    @IBOutlet var backView1: UIView!
    
    @IBOutlet var viewProgress2: UICircularProgressRing!
    @IBOutlet var backView2: UIView!
    
    @IBOutlet var viewProgress3: UICircularProgressRing!
    @IBOutlet var backView3: UIView!
    
    @IBOutlet var viewProgress4: UICircularProgressRing!
    @IBOutlet var backView4: UIView!
    
//  @IBOutlet var viewProgress4: UICircularProgressRing!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
//        viewProgress1.layer.cornerRadius = viewProgress1.frame.height / 2
//
//        viewProgress2.layer.cornerRadius = viewProgress2.frame.height / 2
//
//        viewProgress3.layer.cornerRadius = viewProgress3.frame.height / 2
//
//        viewProgress4.layer.cornerRadius = viewProgress4.frame.height / 2
        
        viewProgress4.startProgress(to: 49, duration: 2.0) {
            print("Done animating!")
        }
        
        viewProgress4.style = .ontop
        
    }

}
