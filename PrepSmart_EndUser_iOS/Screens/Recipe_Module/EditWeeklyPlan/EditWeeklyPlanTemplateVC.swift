//
//  EditWeeklyPlanTemplateVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 10/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD134, PSTMOBSTD122, PSTMOBSTD136-1

import UIKit

class EditWeeklyPlanTemplateVC: BaseViewController {
    @IBOutlet weak var view_container: UIView!
    @IBOutlet weak var view_MON: UIView!
    @IBOutlet weak var view_TUE: UIView!
    @IBOutlet weak var view_WED: UIView!
    @IBOutlet weak var view_THU: UIView!
    @IBOutlet weak var view_FRI: UIView!
    @IBOutlet weak var view_SAT: UIView!
    @IBOutlet weak var view_SUN: UIView!
    
    @IBOutlet weak var btn_MON: UIButton!
    @IBOutlet weak var btn_TUE: UIButton!
    @IBOutlet weak var btn_WED: UIButton!
    @IBOutlet weak var btn_THU: UIButton!
    @IBOutlet weak var btn_FRI: UIButton!
    @IBOutlet weak var btn_SAT: UIButton!
    @IBOutlet weak var btn_SUN: UIButton!
    var isForAddWeeklyPlanTemplate = false
    
    var arrViews = [UIView]()
    var arrBtns = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialize()
    }
    
    func initialize()
    {
        if isForAddWeeklyPlanTemplate == true
        {
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Add Weekly Plan Template")
            self.navigationItem.rightBarButtonItems = [saveWeeklyPlanNavButton()]
        }
        else
        {
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Edit Weekly Plan Template")
            self.navigationItem.rightBarButtonItems = [deleteWeeklyPlanNavButton(),saveWeeklyPlanNavButton()]
        }
        
        
        
        arrViews = [view_MON, view_TUE, view_WED, view_THU, view_FRI, view_SAT, view_SUN]
        arrBtns = [btn_MON, btn_TUE, btn_WED, btn_THU, btn_FRI, btn_SAT, btn_SUN]
        
        for view in arrViews
        {
            view.layer.cornerRadius = 4.0
            view.clipsToBounds = true
        }
        
        addFirstVC()
    }
    
    func addFirstVC()
    {
        let weeklyPlanVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "EditWeeklyPlanContainerViewController") as! EditWeeklyPlanContainerViewController
        addChild(weeklyPlanVC)
        weeklyPlanVC.view.translatesAutoresizingMaskIntoConstraints = false
        weeklyPlanVC.weekDay = "MON"
        view_container.addSubview(weeklyPlanVC.view)
        NSLayoutConstraint.activate([
            weeklyPlanVC.view.leadingAnchor.constraint(equalTo: view_container.leadingAnchor, constant: 0),
            weeklyPlanVC.view.trailingAnchor.constraint(equalTo: view_container.trailingAnchor, constant: 0),
            weeklyPlanVC.view.topAnchor.constraint(equalTo: view_container.topAnchor, constant: 0),
            weeklyPlanVC.view.bottomAnchor.constraint(equalTo: view_container.bottomAnchor, constant: 0)
            ])
        
        weeklyPlanVC.didMove(toParent: self)
    }
    
    @IBAction func onClickBtnNextClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickPreviousBtnClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickBtnNextViewClicked(_ sender: UIButton) {
        
    }
    
    
    
    @IBAction func onClickChangeTab(_ sender: UIButton) {
        
        view_container.subviews.forEach({ $0.removeFromSuperview() })
        
        for view in arrViews
        {
            view.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
        }
        
        let weeklyPlanVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "EditWeeklyPlanContainerViewController") as! EditWeeklyPlanContainerViewController
        addChild(weeklyPlanVC)
        weeklyPlanVC.view.translatesAutoresizingMaskIntoConstraints = false
        view_container.addSubview(weeklyPlanVC.view)
        
        if sender == btn_MON
        {
            view_MON.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "MON"
        }
        else if sender == btn_TUE
        {
            view_TUE.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "TUE"
        }
        else if sender == btn_WED
        {
            view_WED.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "WED"
        }
        else if sender == btn_THU
        {
            view_THU.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "THU"
        }
        else if sender == btn_FRI
        {
            view_FRI.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "FRI"
        }
        else if sender == btn_SAT
        {
            view_SAT.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "SAT"
        }
        else if sender == btn_SUN
        {
            view_SUN.backgroundColor = UIColor.appOrangeColor()
            weeklyPlanVC.weekDay = "SUN"
        }
        
        NSLayoutConstraint.activate([
            weeklyPlanVC.view.leadingAnchor.constraint(equalTo: view_container.leadingAnchor, constant: 0),
            weeklyPlanVC.view.trailingAnchor.constraint(equalTo: view_container.trailingAnchor, constant: 0),
            weeklyPlanVC.view.topAnchor.constraint(equalTo: view_container.topAnchor, constant: 0),
            weeklyPlanVC.view.bottomAnchor.constraint(equalTo: view_container.bottomAnchor, constant: 0)
            ])
        
        weeklyPlanVC.didMove(toParent: self)
    }
}
