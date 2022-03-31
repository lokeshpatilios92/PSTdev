//
//  ReplyOnCommentsTableViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 17/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ReplyOnCommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var commentTextView: IQTextView!
    
    @IBOutlet weak var sendButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        commentTextView.layer.cornerRadius = commentTextView.frame.height / 2
        
        commentTextView.layer.borderColor = UIColor.textColor().cgColor
        commentTextView.layer.borderWidth = 0.50
        
    }
}
