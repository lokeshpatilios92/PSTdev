//
//  AlertLoadPlanTempletVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 12/11/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class AlertLoadPlanTempletVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btn_Load: UIButton!
    @IBOutlet weak var btn_Template: UIButton!
    
    var completionHandler: ((Bool) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)

        // Do any additional setup after loading the view.
        searchBar.backgroundColor = .white
        searchBar.isTranslucent = true
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 0.50
        searchBar.layer.cornerRadius = searchBar.frame.height / 2
        //        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.backgroundImage = UIImage()
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: UISearchBar.Icon.search, state: .normal)
        
        self.showAnimation()
    }
    
    //    MARK : OnClick Func
    @IBAction func onClickButton(_ sender: UIButton) {
        
        if sender == btn_Load {
            
//            completionHandler(true)
            
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "WeekPlannerVC") as! WeekPlannerVC
            self.removeAnimation()
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
        else if sender == btn_Template {
        }
        
        else {
            self.removeAnimation()
        }
    }
}
