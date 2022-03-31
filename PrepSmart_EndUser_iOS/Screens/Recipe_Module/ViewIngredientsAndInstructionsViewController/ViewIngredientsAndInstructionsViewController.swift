//
//  ViewIngredientsAndInstructionsViewController.swift
//  PrepSmart_ETPL
//
//  Created by Lalit Kandi on 20/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Tags

class ViewIngredientsAndInstructionsViewController: BaseViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView_inner: UIScrollView!
    @IBOutlet weak var constraintTblViewHT: NSLayoutConstraint!
    
    var parentVC : UIViewController?
    
    let viewIngredientsTableCell = "ViewIngredientsTableCell"
    let viewInstructionsTabelCell = "ViewInstructionsTabelCell"
    let viewInstructionSectionTableCell = "ViewInstructionSectionTableCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
        // Do any additional setup after loading the view.
    }

    func initialize() {
       
        if parentVC != nil
        {
            self.scrollView_inner.delegate = parentVC as? UIScrollViewDelegate
            self.scrollView_inner.isScrollEnabled = false
        }
        //backView.layer.cornerRadius = 5
        tableView.register(UINib.init(nibName: viewIngredientsTableCell, bundle: nil), forCellReuseIdentifier: viewIngredientsTableCell)
        tableView.register(UINib.init(nibName: viewInstructionsTabelCell, bundle: nil), forCellReuseIdentifier: viewInstructionsTabelCell)
        tableView.register(UINib.init(nibName: viewInstructionSectionTableCell, bundle: nil), forCellReuseIdentifier: viewInstructionSectionTableCell)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
 
    
    override func viewWillLayoutSubviews() {
        DispatchQueue.main.async {
            self.constraintTblViewHT.constant = self.tableView.contentSize.height
        }
    }
}

extension ViewIngredientsAndInstructionsViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            return 1
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell_1 = tableView.dequeueReusableCell(withIdentifier: viewIngredientsTableCell, for: indexPath) as! ViewIngredientsTableCell
            
            cell_1.rightLabel.textColor = .black
            cell_1.leftLabel.textColor = .black
            cell_1.rightLabel.font = cell_1.rightLabel.font.withSize(12)
            cell_1.leftLabel.font = cell_1.leftLabel.font.withSize(12)
            
            if indexPath.row == 0{
                cell_1.leftLabel.text = "100 ml - Milk"
                cell_1.rightLabel.text = "Step 1"
                
            }
            else if indexPath.row == 1{
                cell_1.leftLabel.text = "100 gm - Flour"
                cell_1.rightLabel.text = "Step 2"
            }
            else{
                cell_1.leftLabel.text = "250 gm- Sugar Free Sweetner"
                cell_1.rightLabel.text = "Step 3"

            }
            
            return cell_1
            
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: viewInstructionsTabelCell, for: indexPath) as! ViewInstructionsTabelCell
            cell.titleLabel.textColor = .black
            cell.titleLabel.font = cell.titleLabel.font.withSize(12)
            cell.titleLabel.text = "Step : Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sede"
            cell.tagView.tags = "tag1,tag2,tag3,tag4"

            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: viewInstructionsTabelCell, for: indexPath) as! ViewInstructionsTabelCell
 
            cell.tagView.isHidden = true
            cell.titleLabel.textColor = .black
            cell.titleLabel.font = cell.titleLabel.font.withSize(12)
            cell.titleLabel.text = "30 Min"
            return cell
        }
      
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if section == 0{
            
            let cell_1 = tableView.dequeueReusableCell(withIdentifier: viewIngredientsTableCell) as! ViewIngredientsTableCell
            cell_1.leftLabel.text = "Ingredients(Scaled to 1 serving) :"
            cell_1.rightLabel.text = "Steps"
            cell_1.rightLabel.textColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
            cell_1.leftLabel.textColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
            cell_1.rightLabel.font = cell_1.rightLabel.font.withSize(16)
            cell_1.leftLabel.font = cell_1.leftLabel.font.withSize(16)
            cell_1.rightBottomView.isHidden = false
            cell_1.leftBottomView.isHidden = false
            return cell_1.contentView
            
        }
        else if section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: viewInstructionSectionTableCell) as! ViewInstructionSectionTableCell
            cell.titleLabel.text = "Instructions (Based on original recipe -8 servings)"
            return cell.contentView
            
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: viewInstructionSectionTableCell) as! ViewInstructionSectionTableCell
            cell.titleLabel.text = "Cooking Time:"
            return cell.contentView
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 75
        }else if section == 1{
            return 40
        } else {
            return 50
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
}
