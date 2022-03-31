//
//  BlogFilter.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 05/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class BlogFilter: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    
    @IBOutlet weak var toggelButton: UISegmentedControl!
    
    var categoryArray  = 10
    var tagArray  = 5
    
    var isCategorySelected : Bool = true
    
    override func awakeFromNib() {
        applyButton.layer.cornerRadius = applyButton.frame.height / 2
        
        clearButton.layer.cornerRadius = clearButton.frame.height / 2
        
        clearButton.layer.borderColor = UIColor.appOrangeColor().cgColor
        clearButton.layer.borderWidth = 0.50
        
        searchBar.layer.borderColor = UIColor.appGrayColor().cgColor
        searchBar.layer.borderWidth = 1.0
        
        self.toggelButton.setTitle("Category (\(categoryArray))", forSegmentAt: 0)
        self.toggelButton.setTitle("Tag (\(tagArray))", forSegmentAt: 1)
        
        filterTableView.delegate = self
        filterTableView.dataSource = self
    }
    
    //    MARK: UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCategorySelected {
            return categoryArray
        } else {
             return tagArray
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.popover.dismiss()
    }
    
    @IBAction func onClickToggleButton(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            isCategorySelected = true
            self.filterTableView.reloadData()
        case 1:
            isCategorySelected = false
            self.filterTableView.reloadData()
        default:
            break;
        }
    }
}
