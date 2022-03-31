//
//  KitchenCollectionCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 09/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class KitchenCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var stepDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stepCompleteButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    let kitchenTableCell = "KitchenTableCell"
    
    let sample_left_test = ["2","3 ml","2","250gm","5"]
    let sample_right_test = ["eggs","Milk","Chicken Breasts","Lettuce","Cherry tomatoes"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        topButton.layer.cornerRadius = topButton.frame.height / 2
        bottomButton.layer.cornerRadius = bottomButton.frame.height / 2
        stepCompleteButton.setTextUnderline(UIColor.appOrangeColor(), string: stepCompleteButton.currentTitle!)
        stepCompleteButton.setTextColor(UIColor.appOrangeColor(), string: stepCompleteButton.currentTitle!)
        tableView.register(UINib.init(nibName: kitchenTableCell, bundle: nil), forCellReuseIdentifier: kitchenTableCell)
    }

}

extension KitchenCollectionCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kitchenTableCell, for: indexPath) as! KitchenTableCell
        cell.leftLabel.text = sample_left_test[indexPath.row]
        cell.rightLabel.text = sample_right_test[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
