//
//  BlogFilter.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 05/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class BlogFilter: UIView {
    
    @IBOutlet weak var filterTableView: UITableView!
    
    override func awakeFromNib() {
        filterTableView.register(UINib(nibName: "MenuTableCell", bundle: .none), forCellReuseIdentifier: "MenuTableCell")
    }
    
    class func instanceFromBlogFilterNib() -> BlogFilter {
        return UINib(nibName: "BlogFilter", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! BlogFilter
    }
}
