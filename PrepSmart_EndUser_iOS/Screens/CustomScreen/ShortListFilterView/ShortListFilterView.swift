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
    @IBOutlet weak var cancelButton: UIButton!
    
    let shortListTableCell = "ShortListTableCell"
    
    var sortListArray  = ["Top Rated","Price High to Low","Price Low to High","Latest", "Oldest", "Best Selling"]
    var selectedOption = [true,false,false,false,false,false]
    
    override func awakeFromNib() {
        cancelButton.layer.cornerRadius = applyButton.frame.height / 2
        cancelButton.layer.borderWidth = 0.5
        cancelButton.layer.borderColor = UIColor.appOrangeColor().cgColor
        
        applyButton.layer.cornerRadius = applyButton.frame.height / 2
        shortListTableView.delegate = self
        shortListTableView.dataSource = self
        
        shortListTableView.register(UINib(nibName: shortListTableCell, bundle: nil), forCellReuseIdentifier: shortListTableCell)
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        print("cancle")
    }
    
    @IBAction func onClickApply(_ sender: Any) {
        print("apply")
    }
    
    //    MARK: UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shortListTableCell, for: indexPath) as! ShortListTableCell
        
        cell.lbl_itemTitle.text = sortListArray[indexPath.row]
//        cell.textLabel?.text = sortListArray[indexPath.row]
        
        if selectedOption[indexPath.row]
        {
            cell.sideImageView.image = #imageLiteral(resourceName: "radio_active")
        }
        else
        {
            cell.sideImageView.image = #imageLiteral(resourceName: "radio_normal")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        self.popover.dismiss()
        
        selectedOption = [false,false,false,false,false,false]
        selectedOption[indexPath.row] = !selectedOption[indexPath.row]
        tableView.reloadData()
    }

}

