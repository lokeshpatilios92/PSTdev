//
//  MembershipViewCollectionCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh Kulkarni on 02/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
// Screen Id : PSTMOBSTD006-1,PSTMOBSTD006-2,PSTMOBSTD006-3

import UIKit
class MembershipViewCollectionCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var cellContentView  : UIView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var bgView           : UIView!
    @IBOutlet weak var titleBGView      : UIView!
    @IBOutlet weak var monthlyPlanView  : UIView!
    @IBOutlet weak var featuresView0    : UIView!
    @IBOutlet weak var titleLabel       : UILabel!
    @IBOutlet weak var subTitleLabel    : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var fearturesLabel   : UILabel!
    @IBOutlet weak var featuresLabel0   : UILabel!
    @IBOutlet weak var monthlyPlanLabel : UILabel!
    @IBOutlet weak var seeMoreLabel     : UILabel!
    
    @IBOutlet weak var billedMonthlyBtn : UIButton!
    @IBOutlet weak var billedAnnuallyBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnBasicUser: UIButton!
    @IBOutlet weak var btnPayment: UIButton!

    var membershipListObj: Membership_list?
    var monthTag = 1
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleBGView.layer.cornerRadius = 5
        bgView.layer.cornerRadius = 5
        billedMonthlyBtn.layer.cornerRadius = 5
        billedMonthlyBtn.layer.borderColor = UIColor.white.cgColor
        billedMonthlyBtn.layer.borderWidth = 0.5
        
        billedAnnuallyBtn.layer.cornerRadius = 5
        billedAnnuallyBtn.layer.borderColor = UIColor.white.cgColor
        billedAnnuallyBtn.layer.borderWidth = 0.5
        
        monthlyPlanView.layer.borderColor = UIColor.white.cgColor
        monthlyPlanView.layer.borderWidth = 0.5
        monthlyPlanView.layer.cornerRadius = 5
        
        seeMoreLabel.setTextUnderline(.appOrangeColor(), string: "Show More")
        seeMoreLabel.setTextColor(.appOrangeColor(), string: "Show More")
        
    }
    
    // Configure
    func config(index:Int){
        switch index{
        case 0:
            let dic = membershipListObj?.basic_plan
            titleLabel.text = dic?.monthly?.name
            let price = monthTag == 1 ? String(dic?.monthly?.price ?? 0) : String(dic?.annually?.price ?? 0)
            let disc = monthTag == 1 ? dic?.monthly?.description  : dic?.annually?.description
            subTitleLabel.text = "$" + price + "/month"
            descriptionLabel.text = disc
            monthlyPlanView.isHidden = true
            
            btnBasicUser.backgroundColor = UIColor.appOrangeColor()
            btnBasicUser.setTitle("Continue for free as a Basic user", for: .normal)
            btnBasicUser.layer.cornerRadius = 15
        
        case 1:
            let dic = membershipListObj?.pro
            titleLabel.text = dic?.monthly?.name
            let price = monthTag == 1 ? String(dic?.monthly?.price ?? 0) : String(dic?.annually?.price ?? 0)
            let disc = monthTag == 1 ? dic?.monthly?.description  : dic?.annually?.description
            subTitleLabel.text = "$" + price + "/month"
            descriptionLabel.text = disc
            
            monthlyPlanView.isHidden = false
            monthlyPlanLabel.text = "Start Free \(monthTag == 1 ? dic?.monthly?.duration ?? 0 : dic?.annually?.duration ?? 0) days Pro Plus Trial - Monthly Plan $ \(monthTag == 1 ? dic?.monthly?.price ?? 0  : dic?.annually?.price ?? 0)"
            
            btnBasicUser.backgroundColor = .clear
            btnBasicUser.setTitle("No thanks, continue as a basic user", for: .normal)
            btnBasicUser.layer.borderColor = UIColor.white.cgColor
            btnBasicUser.layer.borderWidth = 0.5
            btnBasicUser.layer.cornerRadius = btnBasicUser.frame.height / 2
            tableView.reloadData()
        case 2:
            let dic = membershipListObj?.pro_plus
            titleLabel.text = dic?.monthly?.name
            let price = monthTag == 1 ? String(dic?.monthly?.price ?? 0) : String(dic?.annually?.price ?? 0)
            let disc = monthTag == 1 ? dic?.monthly?.description  : dic?.annually?.description
            subTitleLabel.text = "$" + price + "/month"
            descriptionLabel.text = disc
            tableView.reloadData()
            monthlyPlanView.isHidden = false
            monthlyPlanLabel.text = "Start Free \(monthTag == 1 ? dic?.monthly?.duration ?? 0 : dic?.annually?.duration ?? 0) days Pro Plus Trial - Monthly Plan $ \(monthTag == 1 ? dic?.monthly?.price ?? 0  : dic?.annually?.price ?? 0)"
            
            btnBasicUser.backgroundColor = .clear
            btnBasicUser.setTitle("No thanks, continue as a basic user", for: .normal)
            btnBasicUser.layer.borderColor = UIColor.white.cgColor
            btnBasicUser.layer.borderWidth = 0.5
            btnBasicUser.layer.cornerRadius = btnBasicUser.frame.height / 2
        case 3:
            let dic = membershipListObj?.basic_plan_new
            titleLabel.text = dic?.monthly?.name
            let price = monthTag == 1 ? String(dic?.monthly?.price ?? 0) : String(dic?.annually?.price ?? 0)
            let disc = monthTag == 1 ? dic?.monthly?.description  : dic?.annually?.description
            subTitleLabel.text = "$" + price + "/month"
            descriptionLabel.text = disc
            monthlyPlanView.isHidden = false
            monthlyPlanLabel.text = "Start Free \(monthTag == 1 ? dic?.monthly?.duration ?? 0 : dic?.annually?.duration ?? 0) days Pro Plus Trial - Monthly Plan $ \(monthTag == 1 ? dic?.monthly?.price ?? 0  : dic?.annually?.price ?? 0)"
            
            btnBasicUser.backgroundColor = .clear
            btnBasicUser.setTitle("No thanks, continue as a basic user", for: .normal)
            btnBasicUser.layer.borderColor = UIColor.white.cgColor
            btnBasicUser.layer.borderWidth = 0.5
            btnBasicUser.layer.cornerRadius = btnBasicUser.frame.height / 2
            
            tableView.reloadData()
        default:
            print("dummy")
        }
    }
    //    MARK: OnClick Func
    @IBAction func onClickShowMoreButton(_ sender: UIButton) {
    }
    
    @IBAction func onClickAnualPlanButton(_ sender: UIButton) {
        self.monthTag = 2
        self.tableView.reloadData()
        
    }
    
    @IBAction func onClickMonthlyPlanButton(_ sender: UIButton) {
        self.monthTag = 1
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if tableView.tag == 0
            {
                if self.monthTag == 1
                {
                    return self.membershipListObj?.basic_plan?.monthly?.features?.count ?? 0
                }
                else
                {
                    return self.membershipListObj?.basic_plan?.annually?.features?.count ?? 0
                }
                
            }
            else if tableView.tag == 1
            {
                if self.monthTag == 1
                {
                    return self.membershipListObj?.basic_plan_new?.monthly?.features?.count ?? 0
                }
                else
                {
                    return self.membershipListObj?.basic_plan_new?.annually?.features?.count ?? 0
                }
                
            }
            else if tableView.tag == 2
            {
                if self.monthTag == 1
                {
                    return self.membershipListObj?.pro?.monthly?.features?.count ?? 0
                }
                else
                {
                    return self.membershipListObj?.pro?.annually?.features?.count ?? 0
                }
                
            }
            else if tableView.tag == 3
            {
                if self.monthTag == 1
                {
                    return self.membershipListObj?.pro_plus?.monthly?.features?.count ?? 0
                }
                else
                {
                    return self.membershipListObj?.pro_plus?.annually?.features?.count ?? 0
                }
                
            }
            else
            {
               return 0
            }
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "MembershipFeatureCell",for: indexPath)as! MembershipFeatureCell
            
            if tableView.tag == 0
            {
                cell.titleLabel.text = self.membershipListObj?.basic_plan?.monthly?.features?[indexPath.row].name ?? ""
            }
            else if tableView.tag == 1
            {
                cell.titleLabel.text = self.membershipListObj?.basic_plan_new?.monthly?.features?[indexPath.row].name ?? ""
            }
            else if tableView.tag == 2
            {
                cell.titleLabel.text = self.membershipListObj?.pro?.monthly?.features?[indexPath.row].name ?? ""
            }
            else if tableView.tag == 3
            {
                cell.titleLabel.text = self.membershipListObj?.pro_plus?.monthly?.features?[indexPath.row].name ?? ""
            }

            return cell
        }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
    }
}

class MembershipFeatureCell: UITableViewCell
{
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
