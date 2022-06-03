//
//  MembershipLevelViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh Kulkarni on 01/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class MembershipLevelViewController: BaseViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControlView: UIPageControl!
    
    var billedMonthlyClicked = 0  //0:Monthly 1:Yearly
    var planObj : Membership_Struct?
    var global_Var = GlobalClass.sharedManager
    let flowLayout = ZoomAndSnapFlowLayout()
    var subscribeStatus = AppRating_Struct()
    var planId:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initiolize()
        self.membershipPlanApi()
    }
    
    func initiolize() {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Membership Level")
        
        self.pageControlView.numberOfPages = 4
        collectionView.decelerationRate = .fast // uncomment if necessary
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(UINib(nibName: "MembershipViewCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MembershipViewCollectionCell")
        membershipPlanApi()
    }
    
    //    MARK: OnClick Func
    @objc func onClickBottomButton(_ sender: UIButton) {
        let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickBilledMonthlyButton(_ sender:UIButton) {
        self.billedMonthlyClicked = 0
        self.collectionView.reloadData()
    }
    
    @objc func onClickBilledYearlyButton(_ sender:UIButton) {
        self.billedMonthlyClicked = 1
        self.collectionView.reloadData()
    }
    
    @objc func onClickPaymetButton(_ sender:UIButton) {
        print(sender.tag)
        print(billedMonthlyClicked)
        var amount:Int = 0
        switch sender.tag {
        case 0:
          amount = billedMonthlyClicked == 0 ? self.planObj?.membership_list?.basic_plan?.monthly?.price ?? 0 : self.planObj?.membership_list?.basic_plan?.annually?.price ?? 0
            self.planId = self.planObj?.membership_list?.basic_plan?.annually?.id ?? 0
        case 1:
            amount = billedMonthlyClicked == 0 ? self.planObj?.membership_list?.pro?.monthly?.price ?? 0 : self.planObj?.membership_list?.pro?.annually?.price ?? 0
            self.planId = self.planObj?.membership_list?.pro?.annually?.id ?? 0
        case 2:
            amount = billedMonthlyClicked == 0 ? self.planObj?.membership_list?.pro_plus?.monthly?.price ?? 0 : self.planObj?.membership_list?.pro_plus?.annually?.price ?? 0
            self.planId = self.planObj?.membership_list?.pro_plus?.annually?.id ?? 0
        case 3:
            amount = billedMonthlyClicked == 0 ? self.planObj?.membership_list?.basic_plan_new?.monthly?.price ?? 0 : self.planObj?.membership_list?.basic_plan_new?.annually?.price ?? 0
            self.planId = self.planObj?.membership_list?.basic_plan_new?.annually?.id ?? 0
        default:
            print("")
        }

        let vc = UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        vc.amount = String(amount)
        vc.paymentType = 3
        vc.chefId = planId
        if billedMonthlyClicked == 0 {
            vc.duration = 1
        }
        else {
            vc.duration = 2
        }
        vc.delegete = self
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}

extension MembershipLevelViewController : paymentSucesscallBack {
    func paymentSuccess(TransectionID: String, Amount: String, Type: Int, id: Int, duration: Int) {
        membershipSubscribePayement(TransectionID: TransectionID,
                                    Duration: duration,
                                    id: id)
    }
}

extension MembershipLevelViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MembershipViewCollectionCell", for: indexPath) as! MembershipViewCollectionCell
        cell.tableView.register(UINib.init(nibName: "MembershipFeatureCell", bundle: nil), forCellReuseIdentifier: "MembershipFeatureCell")
        cell.membershipListObj = self.planObj?.membership_list
        cell.config(index: indexPath.row)
        
        cell.billedMonthlyBtn.tag = indexPath.row
        cell.billedAnnuallyBtn.tag = indexPath.row
        cell.btnPayment.tag = indexPath.row
        
        cell.btnBasicUser.addTarget(self, action: #selector(onClickBottomButton(_:)), for: .touchUpInside)
        cell.billedMonthlyBtn.addTarget(self, action: #selector(onClickBilledMonthlyButton(_:)), for: .touchUpInside)
        cell.billedAnnuallyBtn.addTarget(self, action: #selector(onClickBilledYearlyButton(_:)), for: .touchUpInside)
        cell.btnPayment.addTarget(self, action: #selector(onClickPaymetButton(_:)), for: .touchUpInside)

        if self.billedMonthlyClicked == 0 {
            cell.monthTag = 1
            cell.billedMonthlyBtn.backgroundColor = UIColor.appOrangeColor()
            cell.billedAnnuallyBtn.backgroundColor = UIColor.clear
            cell.config(index: indexPath.row)
        }else{
            cell.monthTag = 2
            cell.billedAnnuallyBtn.backgroundColor = UIColor.appOrangeColor()
            cell.billedMonthlyBtn.backgroundColor = UIColor.clear
            cell.config(index: indexPath.row)
        }
        
        cell.tableView.tag = indexPath.row
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width * 0.60
        let horizontalCenter = width / 2
        pageControlView.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
}

extension MembershipLevelViewController
{
    
   func membershipPlanApi()
    {

        let param:[String:String] = ["": ""]
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getMembershipData, params: param , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):

                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                Loader.sharedInstance.hideIndicator()
                        do {
                            self.planObj = try JSONDecoder().decode(Membership_Struct.self, from: data)
                            self.collectionView.reloadData()
                        }
                        catch
                        {
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                        }
                    }
                    else
                    {
                        Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: self.global_Var.get_status.message)
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: self.global_Var.get_status.message)
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
    
    func membershipSubscribePayement(TransectionID: String, Duration: Int, id: Int) {
        let param:[String:Any] = ["planId":id,
                                  "duration":Duration,
                                  "transactionId":TransectionID]
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.updateMembership, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.subscribeStatus = try JSONDecoder().decode(AppRating_Struct.self, from: data)
                            //Alert.show(vc: self, titleStr: Alert.kTitle, messageStr: self.subscribeStatus.message)
                            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "SubscriptionViewController") as! SubscriptionViewController
                            self.navigationController?.pushViewController(vc, animated: false)
                        }
                        catch
                        {
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                        }
                    }
                    else
                    {
                        Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: GlobalClass.sharedManager.get_status.message)
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: GlobalClass.sharedManager.get_status.message)
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
