//
//  MultiPickerController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Shubham Gupta on 21/05/22.
//  Copyright © 2022 Exceptionaire.co. All rights reserved.
//

import UIKit

protocol MultiPickerControllerDelegate {
    func didPickItems(_ items: [String])
}

class MultiPickerController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [String]()
    var selectedItems = [String]()
    
    var allItems: (([String]) -> Void)?


    var delegate: MultiPickerControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOKAction(_ sender: Any) {
        self.allItems!(self.selectedItems)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MultipickerTableCell") as! MultipickerTableCell
        let item = items[indexPath.row]
        cell.titleLabel.text = item
        if selectedItems.contains(item) {
            cell.checkboxIcon.image = UIImage(named: "check_mark_orange")!
        } else {
            cell.checkboxIcon.image = UIImage(named: "check_mark_orange_normal")!
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        if selectedItems.contains(item) {
            if let index = selectedItems.firstIndex(of: item) {
                selectedItems.remove(at: index)
            }
        } else {
            selectedItems.append(item)
        }
        self.tableView.reloadData()
    }

}

class MultipickerTableCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkboxIcon: UIImageView!
}
