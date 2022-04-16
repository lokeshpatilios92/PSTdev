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
    func didDataAddedToList(at indexPath: IndexPath?, receipes: [Recipes])
}

class AddRecipesToRecipePackViewController: BaseViewController {
    @IBOutlet var tableView : UITableView!
    @IBOutlet weak var btn_Done: UIButton!
    @IBOutlet weak var btn_Cancel: UIButton!
    
    weak var delegate: DataEnteredDelegate? = nil
    
    private var recepies = [Recipes]()
    private var selectedReceipes = [Recipes]()
    var indexPath: IndexPath?
    
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
        self.getReceipeList()
    }
    
    
    @objc func onClickDoneButton(sender : UIButton)
    {
        delegate?.sendFlag(info: 1)
        delegate?.didDataAddedToList(at: indexPath, receipes: selectedReceipes)
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
            return self.recepies.count
        } else {
            return self.selectedReceipes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: addRecipesToRecipeTableCell, for: indexPath) as! AddRecipesToRecipeTableCell
        
        cell.bgView.backgroundColor = .white
        
        if indexPath.section == 0 {
            let recipe = self.recepies[indexPath.row]
            cell.view_qty.isHidden = false
            cell.lbl_servings.text = ""
            cell.btn_addORdelete.setImage(#imageLiteral(resourceName: "add-image"), for: .normal)
            
            cell.itemTitleLabel.text = recipe.recipe_name
            cell.itemInfoLable.text = "\(recipe.protein ?? 0))P. \(recipe.carbohydrates ?? 0)C"
            
            cell.lbl_quantity.text = "\(recipe.totalQuantity ?? 0)"
            cell.btn_addORdelete.addTarget(self, action: #selector(btnAddOrDeleteAction(_:)), for: .touchUpInside)
        }
        else
        {
            cell.view_qty.isHidden = true
            cell.lbl_servings.text = ""
            cell.btn_addORdelete.setImage(#imageLiteral(resourceName: "delete_red"), for: .normal)
            let recipe = self.selectedReceipes[indexPath.row]
            
            cell.itemTitleLabel.text = recipe.recipe_name
            cell.itemInfoLable.text = "\(recipe.protein ?? 0))P. \(recipe.carbohydrates ?? 0)C"
            
            cell.lbl_quantity.text = "\(recipe.totalQuantity ?? 0)"
        }
        cell.contentView.backgroundColor = .groupTableViewBackground
        
        cell.btn_plus.addTarget(self, action: #selector(btnPlusAction(_:)), for: .touchUpInside)
        cell.btn_minus.addTarget(self, action: #selector(btnMinusAction(_:)), for: .touchUpInside)
       
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
    
    @objc func btnPlusAction(_ sender: UIButton) {
        guard let cell = sender.superview?.superview?.superview?.superview?.superview as? AddRecipesToRecipeTableCell,
              let indexPath = tableView.indexPath(for: cell) else { return }
        
        if indexPath.section == 0 {
            var totlQuantity = recepies[indexPath.row].totalQuantity ?? 0
            totlQuantity = totlQuantity + 1
            recepies[indexPath.row].totalQuantity = totlQuantity
            self.tableView.reloadData()
        }
    }
    
    @objc func btnMinusAction(_ sender: UIButton) {
        guard let cell = sender.superview?.superview?.superview?.superview?.superview as? AddRecipesToRecipeTableCell,
              let indexPath = tableView.indexPath(for: cell) else { return }
        if indexPath.section == 0 {
            var totlQuntity = recepies[indexPath.row].totalQuantity ?? 0
            if totlQuntity > 0 {
                totlQuntity = totlQuntity - 1
                recepies[indexPath.row].totalQuantity = totlQuntity
            }
            self.tableView.reloadData()
        }
    }
    
    @objc func btnAddOrDeleteAction(_ sender: UIButton) {
        guard let cell = sender.superview?.superview?.superview as? AddRecipesToRecipeTableCell,
              let indexPath = tableView.indexPath(for: cell) else { return }
        
        if indexPath.section == 0 {
            let recipe = recepies[indexPath.row]
            if let index = self.selectedReceipes.firstIndex(where: { $0.recipe_id == recipe.recipe_id }) {
                self.selectedReceipes.remove(at: index)
            }
            self.selectedReceipes.append(recipe)
        } else {
            self.selectedReceipes.remove(at: indexPath.row)
        }
        
        self.tableView.reloadData()
       
    }
    
    
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
    
    
    func getReceipeList() {
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getRecipeList, params: nil , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            if let receipeList = dict["recipe_list"] as? [[String: Any]], let data = try? JSONSerialization.data(withJSONObject: receipeList, options: [.prettyPrinted]) {
                                self.recepies = try JSONDecoder().decode([Recipes].self, from: data)
                                self.tableView.reloadData()
                            }

                        }
                        catch (let error){
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                        }
                    }
                    else
                    {
                        Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: "")
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: "")
                }
                Loader.sharedInstance.hideIndicator()
                break
                
            case .failer(let error):
                
                Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                Loader.sharedInstance.hideIndicator()
                break
            }
        }
    }
}
