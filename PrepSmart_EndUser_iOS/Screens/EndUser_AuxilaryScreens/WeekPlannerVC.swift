//
//  WeekPlannerVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 13/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD0101

import UIKit

class WeekPlannerVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var keeptRadioBtn: UIButton!
    @IBOutlet weak var discardRadioBtn: UIButton!
    @IBOutlet weak var manageMealPlansBtn: UIButton!
    @IBOutlet weak var radioButtonBackView: UIView!
    @IBOutlet weak var keeptRadioImageVIew: UIImageView!
    @IBOutlet weak var discardRadioImageView: UIImageView!
    
    let feedCell = "FeedCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
    }
    
    func initializer(){
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Week Planner")
        self.navigationItem.rightBarButtonItems = [addSaveNavButton(),addDownloadNavButton(),addBlogsNavButton()]
        tableView.register(UINib(nibName: feedCell, bundle: .none), forCellReuseIdentifier: feedCell)
        okBtn.layer.cornerRadius = okBtn.frame.height/2
        manageMealPlansBtn.setTextUnderline(UIColor.appOrangeColor(), string: manageMealPlansBtn.currentTitle!)
        manageMealPlansBtn.setTextColor(UIColor.appOrangeColor(), string: manageMealPlansBtn.currentTitle!)
        self.radioButtonBackView.layer.cornerRadius = 5
    }
    
    @IBAction func manageMealPlansBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func okBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func radioBtnTapped(_ sender: UIButton)
    {
        if sender == keeptRadioBtn
        {
            self.keeptRadioImageVIew.image = #imageLiteral(resourceName: "radio_active")
            self.discardRadioImageView.image = #imageLiteral(resourceName: "radio_normal")
        }
        else{
            self.keeptRadioImageVIew.image = #imageLiteral(resourceName: "radio_normal")
            self.discardRadioImageView.image = #imageLiteral(resourceName: "radio_active")
        }
    }

}

extension WeekPlannerVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
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
