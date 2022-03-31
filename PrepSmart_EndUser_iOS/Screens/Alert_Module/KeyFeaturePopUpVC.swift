//
//  KeyFeaturePopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 01/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//PSTMOBSTD020

import UIKit

protocol CustomKeyFeaturePopUpDelegate {
    func onClcikUpgradeButton()
    func onClcikCancelButton()
}

class KeyFeaturePopUpVC: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var heightConstraintOfTableView: NSLayoutConstraint!
    
    var customDelegate : CustomKeyFeaturePopUpDelegate!
    var homeData = HomeStruct()
    
    var sectionHeaderTableCell =  "SectionHeaderTableCell"
    var keyFeaturesTableCell = "KeyFeaturesTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize ()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
        heightConstraintOfTableView.constant = tableView.contentSize.height
        
    }
    
    func initialize () {
        
        self.backView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        leftButton.layer.cornerRadius = leftButton.frame.height/2
        rightButton.layer.cornerRadius = rightButton.frame.height/2
        leftButton.layer.borderColor = UIColor.appOrangeColor().cgColor
        leftButton.layer.borderWidth = 1
        tableView.register(UINib.init(nibName: sectionHeaderTableCell, bundle: nil), forCellReuseIdentifier: sectionHeaderTableCell)
        tableView.register(UINib.init(nibName: keyFeaturesTableCell, bundle: nil), forCellReuseIdentifier: keyFeaturesTableCell)
        self.showAnimation()
    }
    
    
    @IBAction func onClickLeftButton(_ sender: UIButton) {
        self.customDelegate.onClcikCancelButton()
        self.removeAnimation()
    }
    
    @IBAction func onClickRightButton(_ sender: UIButton) {
        if customDelegate != nil {
            self.customDelegate.onClcikUpgradeButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    
    @IBAction func onClickCloseButton(_ sender: UIButton) {
        self.customDelegate.onClcikCancelButton()
        self.removeAnimation()
    }
}

extension KeyFeaturePopUpVC : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableCell(withIdentifier: sectionHeaderTableCell) as! SectionHeaderTableCell
        
        if section == 0{
            headerView.titleLabel.text = "Key Features:"
        }else{
            headerView.titleLabel.text = "Other Features:"
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return homeData.dashbaordData?.keyFeatures?.count ?? 0
        }else {
            return homeData.dashbaordData?.otherFeature?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: keyFeaturesTableCell, for: indexPath) as! KeyFeaturesTableCell
            let dict = homeData.dashbaordData?.keyFeatures?[indexPath.row]
            cell.titleLabel.text = dict?.feature
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: keyFeaturesTableCell, for: indexPath) as! KeyFeaturesTableCell
            let dict = homeData.dashbaordData?.otherFeature?[indexPath.row]
            cell.titleLabel.text = dict?.feature
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
