//
//  TransactionCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 08/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var transactionIdLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var recipeNameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
