//
//  TodaysReceipesCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 06/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class TodaysReceipesCell: UITableViewCell {
    
    @IBOutlet var MainView: UIView!
    @IBOutlet var collection_receipes: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
