//
//  AddRecipesToRecipePackViewController.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 20/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit


protocol DataEnteredDelegate: class {
    func sendFlag(info: Int)
}

class AddRecipesToRecipePackViewController: BaseViewController {
    @IBOutlet var tableView : UITableView!
    @IBOutlet weak var btn_Done: UIButton!
    @IBOutlet weak var btn_Cancel: UIButton!
    
    weak var delegate: DataEnteredDelegate? = nil
    
    let addRecipesToRecipeTableCell = "AddRecipesToRecipeTableCell"
    let titleTableViewCell          = "TitleTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    func initialize() {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Add Recipes")
        
        tableView.register(UINib.init(nibName: addRecipesToRecipeTableCell, bundle: nil), forCellReuseIdentifier: addRecipesToRecipeTableCell)
        tableView.register(UINib.init(nibName: titleTableViewCell, bundle: nil), forCellReuseIdentifier: titleTableViewCell)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        self.btn_Done.layer.cornerRadius = self.btn_Done.frame.height / 2
        
        self.btn_Cancel.layer.cornerRadius = self.btn_Cancel.frame.height / 2
        self.btn_Cancel.layer.borderWidth = 0.8
        self.btn_Cancel.layer.borderColor = UIColor.appOrangeColor().cgColor
        
        self.btn_Done.addTarget(self, action: #selector(onClickDoneButton(sender:)), for: .touchUpInside)
        self.btn_Cancel.addTarget(self, action: #selector(onClickCancelButton(sender:)), for: .touchUpInside)
    }
    
    
    @objc func onClickDoneButton(sender : UIButton)
    {
        delegate?.sendFlag(info: 1)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickCancelButton(sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AddRecipesToRecipePackViewController : UITableViewDataSource, UITableViewDelegate {
    //    MARK:  UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: addRecipesToRecipeTableCell, for: indexPath) as! AddRecipesToRecipeTableCell
        
        cell.bgView.backgroundColor = .white
        
        if indexPath.section == 0 {
            cell.view_qty.isHidden = false
            cell.lbl_servings.text = "Servings"
            cell.btn_addORdelete.setImage(#imageLiteral(resourceName: "add-image"), for: .normal)
        }
        else
        {
            cell.view_qty.isHidden = true
            cell.lbl_servings.text = "2 Servings"
            cell.btn_addORdelete.setImage(#imageLiteral(resourceName: "delete_red"), for: .normal)
        }
        cell.contentView.backgroundColor = .groupTableViewBackground
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return self.viewForHeaderInSection(section: section)
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .groupTableViewBackground
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20.0
        }
        else if section == 1 {
            return 50
        }
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if section == 0 {
            return 20.0
//        }
//        return 0.001
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func viewForHeaderInSection(section:Int) -> UIView {
        if section == 0 {
            let footerView = UIView()
            footerView.backgroundColor = .groupTableViewBackground
            return footerView
        }
        else {//if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: titleTableViewCell) as! TitleTableViewCell
            cell.lbl_title.text = "Selected 4 Recipes"
            cell.lbl_title.textAlignment = .center
            cell.contentView.backgroundColor = .white
            return cell.contentView
        }
    }
}
