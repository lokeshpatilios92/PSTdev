//
//  BlogsCollectionCell.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 30/05/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class BlogsCollectionCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
