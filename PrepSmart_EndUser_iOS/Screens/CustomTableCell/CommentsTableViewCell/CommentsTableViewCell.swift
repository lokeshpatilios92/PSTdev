//
//  CommentsTableViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 17/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var dropDownImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    

    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentsView: UIView!
    
    @IBOutlet weak var sepraterView: UIView!
    @IBOutlet weak var bgViewLeadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
