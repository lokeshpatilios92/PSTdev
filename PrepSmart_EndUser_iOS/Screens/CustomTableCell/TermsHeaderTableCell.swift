//
//  TermsHeaderTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 06/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class TermsHeaderTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sideImageView: UIImageView!
    
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var sideImageWidthConstrain: NSLayoutConstraint!
    @IBOutlet weak var sideImageHeightConstrain: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(setHeader : String?, sideImageWidth : CGFloat, sideImageHeight : CGFloat, sideImage:UIImage?) {
        
        titleLabel.text = setHeader
        sideImageWidthConstrain.constant = sideImageWidth
        sideImageHeightConstrain.constant = sideImageHeight
        sideImageView.image = sideImage
        
    }
    
}
