//
//  ProgressViewCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 09/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

import UIKit
import UICircularProgressRing

class ProgressViewCell: UICollectionViewCell {
    
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
        
        viewProgress4.startProgress(to: 49, duration: 2.0) {
            print("Done animating!")
        }
        
        viewProgress4.style = .ontop
        
    }
    
}
