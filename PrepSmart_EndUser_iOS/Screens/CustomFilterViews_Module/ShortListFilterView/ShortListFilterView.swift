//
//  ShortListFilterView.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 05/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ShortListFilterView: UIView, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var shortListTableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    
    var sortListArray  = ["Newest First","Older First","Popularity","A - Z", "Z - A"]
    
    override func awakeFromNib() {
        applyButton.layer.cornerRadius = applyButton.frame.height / 2
        shortListTableView.delegate = self
        shortListTableView.dataSource = self
    }
    
    //    MARK: UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = sortListArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        self.popover.dismiss()
    }

}
