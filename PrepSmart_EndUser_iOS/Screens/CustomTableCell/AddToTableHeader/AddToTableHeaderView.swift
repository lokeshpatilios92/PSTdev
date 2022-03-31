//
//  AddToTableHeaderView.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 16/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class AddToTableHeaderView : UITableViewHeaderFooterView {

    @IBOutlet var img_dropDown: UIImageView!
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var btn_info: UIButton!
    @IBOutlet var btn_dropDown: UIButton!
    @IBOutlet weak var checkBox: BEMCheckBox!
   
    override func awakeFromNib() {
        checkBox.boxType = .square
    }
}
