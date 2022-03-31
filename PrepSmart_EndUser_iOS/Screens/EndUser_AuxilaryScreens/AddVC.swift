//
//  AddVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 09/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD036

import UIKit

class AddVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var keeptRadioBtn: UIButton!
    @IBOutlet weak var discardRadioBtn: UIButton!
    @IBOutlet weak var heightConstraintOfTableView: NSLayoutConstraint!
    @IBOutlet weak var keepExistingImageView: UIImageView!
    @IBOutlet weak var discardExistingImageView: UIImageView!
    
    
    
    let feedCell = "FeedCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

       initializer()
    }
    
    
    override func viewDidLayoutSubviews() {
        self.heightConstraintOfTableView.constant = self.tableView.contentSize.height
    }
    
    
    func initializer(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Add")
        tableView.register(UINib(nibName: feedCell, bundle: .none), forCellReuseIdentifier: feedCell)
        okBtn.layer.cornerRadius = okBtn.frame.height/2
    }
    
    @IBAction func okBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func radioBtnTapped(_ sender: UIButton) {
        if sender == keeptRadioBtn
        {
            self.keepExistingImageView.image = #imageLiteral(resourceName: "radio_active")
            self.discardExistingImageView.image = #imageLiteral(resourceName: "radio_normal")
        }
        else
        {
            self.discardExistingImageView.image = #imageLiteral(resourceName: "radio_active")
            self.keepExistingImageView.image = #imageLiteral(resourceName: "radio_normal")
        }
    }
    
}


extension AddVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: feedCell, for: indexPath) as! FeedCell
        cell.commentsImageView.isHidden = true
        cell.cosmosView.isHidden = true
        cell.commentsCountLbl.isHidden = true
        cell.chefNameLbl.text = "330 cals, 15P, 30C, 3F"
        cell.forwardArrow.isHidden = true
        return cell
    }
    
    
}
