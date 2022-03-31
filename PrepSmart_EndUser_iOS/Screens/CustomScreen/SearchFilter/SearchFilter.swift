//
//  SearchFilter.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 11/11/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class SearchFilter: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var shortListTableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    let shortListTableCell = "ShortListTableCell"
    
    var sortListArray  = ["Newest First","Older First","Popularity","Newest First","Older First","Popularity","Newest First","Older First","Popularity"]
    
    override func awakeFromNib() {
        applyButton.layer.cornerRadius = applyButton.frame.height / 2
        
        clearButton.layer.cornerRadius = clearButton.frame.height / 2
        clearButton.layer.borderWidth = 0.5
        clearButton.layer.borderColor = UIColor.appOrangeColor().cgColor
        
        shortListTableView.delegate = self
        shortListTableView.dataSource = self
        
        shortListTableView.register(UINib(nibName: shortListTableCell, bundle: nil), forCellReuseIdentifier: shortListTableCell)
    }
    
    //    MARK: UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shortListTableCell, for: indexPath) as! ShortListTableCell
        
        cell.sideImageView.image = UIImage(named: "check_mark_orange_normal")
        cell.lbl_itemTitle.text = sortListArray[indexPath.row]
        //        cell.textLabel?.text = sortListArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        self.popover.dismiss()
        let cell = tableView.cellForRow(at: indexPath) as! ShortListTableCell
        
        if cell.sideImageView.image == UIImage(named: "check_mark_orange_normal") {
            cell.sideImageView.image = UIImage(named: "check_mark_orange")
        } else {
            cell.sideImageView.image = UIImage(named: "check_mark_orange_normal")
        }
    }
}
