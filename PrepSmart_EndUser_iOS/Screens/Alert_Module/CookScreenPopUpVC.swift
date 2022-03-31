//
//  CookScreenPopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 13/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID:- PSTMOBSTD060

import UIKit

protocol CustomCookScreenPopUpDelegate {
    func onClickOkButton()
}


class CookScreenPopUpVC: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var welcomeTextLabel: UILabel!
    @IBOutlet weak var letsGetStartedLabel: UILabel!
    @IBOutlet weak var middleStepLabel: UILabel!
    @IBOutlet weak var needChangeYourCookList: UILabel!
    @IBOutlet weak var prepSmartTipLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    var customDelegate : CustomCookScreenPopUpDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
        // Do any additional setup after loading the view.
    }
    
    func initialization() {
        
        self.backView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.okButton.layer.cornerRadius = 25
        self.showAnimation()
    }
    
    @IBAction func okButtonTapped(_ sender: UIButton) {
        
        if customDelegate != nil {
            self.customDelegate.onClickOkButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    @IBAction func onClickCloseButton(_ sender: UIButton) {
        self.removeAnimation()
    }
}
