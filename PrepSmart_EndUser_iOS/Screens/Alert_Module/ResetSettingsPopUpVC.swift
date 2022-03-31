//
//  ResetSettingsPopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 08/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD022

import UIKit

protocol CustomResetSettingsPopUpDelegate {
    func onClcikProceedButton()
}


class ResetSettingsPopUpVC: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var proceedBtn: UIButton!
    var customDelegate : CustomResetSettingsPopUpDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        cancelBtn.layer.cornerRadius = cancelBtn.frame.height/2
        proceedBtn.layer.cornerRadius = proceedBtn.frame.height/2
        self.showAnimation()
    }
    
    @IBAction func crossBtnTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func proceedBtnTapped(_ sender: UIButton) {
        if customDelegate != nil {
            self.customDelegate.onClcikProceedButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    
}
