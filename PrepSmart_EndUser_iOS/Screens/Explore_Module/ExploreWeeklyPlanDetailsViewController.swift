//
//  ExploreWeeklyPlanDetailsViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh Kulkarni on 31/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ExploreWeeklyPlanDetailsViewController: BaseViewController {
    
    @IBOutlet weak var view_container: UIView!
    @IBOutlet weak var btn_MON: UIButton!
    @IBOutlet weak var btn_TUE: UIButton!
    @IBOutlet weak var btn_WED: UIButton!
    @IBOutlet weak var btn_THU: UIButton!
    @IBOutlet weak var btn_FRI: UIButton!
    @IBOutlet weak var btn_SAT: UIButton!
    @IBOutlet weak var btn_SUN: UIButton!
    @IBOutlet weak var weekDatesLbl: UILabel!
    
    var weeksBGViewArray : [UIView] = []
    var weeksButtonArray : [UIButton] = []
    var recipyPlanId = 0
    var recipyChefId = 0
    var weeklyPlandata : GetWeeklyPlanTemplateDetailsStruct?
    var filteredMealList: [(meal: Day?, isExpandable: Bool)]?
    
    var global_Var = GlobalClass.sharedManager
    var weeklyPlanVC : WeeklyPlanContainerViewController! = nil
    var fromDate = Date()
    var toDate = Date()
    
    @IBAction func nextWeekAction(_ sender: Any) {
        fromDate = fromDate.next(.monday, considerToday: false)
        toDate = fromDate.next(.sunday, considerToday: false)
        weekDatesLbl.text = "\(DateToString(date: fromDate, formate: "MMM d")) - \( DateToString(date: toDate, formate: "MMM d"))"
    }
    @IBAction func priviousWeekAction(_ sender: Any) {
        fromDate = fromDate.previous(.monday, considerToday: false)
        toDate = fromDate.next(.sunday, considerToday: false)
        weekDatesLbl.text = "\(DateToString(date: fromDate, formate: "MMM d")) - \( DateToString(date: toDate, formate: "MMM d"))"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        getWeeklyPlanTemplateDetails()
    }
    
    func initialize()
    {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("View Weekly Plan")
        self.navigationItem.rightBarButtonItems = [editWeeklyPlanNavButton(),addWeeklyPlanNavButton()]
        
       // weeksBGViewArray = [view_MON, view_TUE, view_WED, view_THU, view_FRI, view_SAT, view_SUN]
        weeksButtonArray = [btn_MON, btn_TUE, btn_WED, btn_THU, btn_FRI, btn_SAT, btn_SUN]
        for (i, btn) in weeksButtonArray.enumerated()
        {
            btn.tag = i
        }
        weeklyPlanVC = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "WeeklyPlanContainerViewController") as? WeeklyPlanContainerViewController
        addChild(weeklyPlanVC!)
        weeklyPlanVC!.view.translatesAutoresizingMaskIntoConstraints = false
        view_container.addSubview(weeklyPlanVC!.view)
        
        NSLayoutConstraint.activate([
            weeklyPlanVC.view.leadingAnchor.constraint(equalTo: view_container.leadingAnchor, constant: 0),
            weeklyPlanVC.view.trailingAnchor.constraint(equalTo: view_container.trailingAnchor, constant: 10),
            weeklyPlanVC.view.topAnchor.constraint(equalTo: view_container.topAnchor, constant: 0),
            weeklyPlanVC.view.bottomAnchor.constraint(equalTo: view_container.bottomAnchor, constant: 0)
            ])
        
        weeklyPlanVC.didMove(toParent: self)
        weekDatesLbl.text = "\(DateToString(date: fromDate, formate: "MMM d")) - \( DateToString(date: toDate, formate: "MMM d"))"
        
        addFirstVC(senderTag: 0)
    }
    
    //    MARK: OnClick Func
    @IBAction func onClickChangeTab(_ sender: UIButton) {
        addFirstVC(senderTag: sender.tag)
    }
    
    func addFirstVC(senderTag:Int)
    {
        for btn in weeksButtonArray
        {
            btn.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
        }
        if senderTag == 0
        {
            btn_MON.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "MON"
        }
        else if senderTag == 1 {
            btn_TUE.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "TUE"
        }
        else if senderTag == 2 {
            btn_WED.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "WED"
        }
        else if senderTag == 3 {
            btn_THU.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "THU"
        }
        else if senderTag == 4 {
            btn_FRI.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "FRI"
        }
        else if senderTag == 5 {
            btn_SAT.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "SAT"
        }
        else if senderTag == 6 {
            btn_SUN.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "SUN"
        }

        weeklyPlanVC.tblview_mealTimings.reloadData()
    }
    
//    func fiterDataAccordingToDay(_ day: String) {
//        filteredMealList?.removeAll()
//        self.selectedDay = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?.first(where: { $0.dayName == day })
//        let mondayMealList = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?.first(where: { $0.dayName == day })?.mealList
//
//        self.filteredMealList = mondayMealList?.map({ (meal) -> (meal: MealListData?, isExpandable: Bool) in
//             (meal: meal, isExpandable: false)
//        })
//
//        self.tableView.reloadData()
//    }
}


extension ExploreWeeklyPlanDetailsViewController
{
    func getWeeklyPlanTemplateDetails()
     {
         let param:[String:Any] = ["weekly_plan_id": recipyPlanId,
                                          "user_id": recipyChefId]
                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getWeeklyPlanTemplateDetails, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                            Loader.sharedInstance.hideIndicator()
                         do {
                             self.weeklyPlandata = try JSONDecoder().decode(GetWeeklyPlanTemplateDetailsStruct.self, from: data)
                            // self.collectionView.reloadData()
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
}
