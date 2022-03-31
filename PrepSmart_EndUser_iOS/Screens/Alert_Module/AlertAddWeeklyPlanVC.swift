//
//  AlertAddWeeklyPlanVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 12/11/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class AlertAddWeeklyPlanVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var btn_AddRecipe: UIButton!
    @IBOutlet weak var btn_WeeklyPlan: UIButton!
    @IBOutlet weak var btn_Close: UIButton!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_SubTitle: UILabel!
    
    
    var completionHandler: ((Bool) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialization()
    }
    
    func initialization() {
        self.backView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.btn_AddRecipe.layer.cornerRadius = btn_AddRecipe.frame.height/2
        self.btn_WeeklyPlan.layer.cornerRadius = btn_WeeklyPlan.frame.height/2

//        self.showAnimation()
    }
    
//    MARK : OnClick Func
    @IBAction func onClickButton(_ sender: UIButton) {
        if sender == btn_AddRecipe {
            let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AddNewViewController") as! AddNewViewController
            self.removeAnimation()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if sender == btn_WeeklyPlan {
//            self.removeAnimation()
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                // your code here
                self.showAlertLoadPlanTempletVC()
//            }
//
//            completionHandler(true)
            
        }
        else {
            self.removeAnimation()
        }
        
    }
}
