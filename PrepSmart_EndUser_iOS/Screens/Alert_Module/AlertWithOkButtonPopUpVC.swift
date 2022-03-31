//
//  AlertWithOkButtonPopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 17/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD078

import UIKit

protocol CustomAlertWithOkButtonPopUpDelegate {
    func onClickOkButtonAction()
}

class AlertWithOkButtonPopUpVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!

    var customDelegate : CustomAlertWithOkButtonPopUpDelegate!
    
    var setTitle : String?
    var setMessage : String?
    var setButtonTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
        // Do any additional setup after loading the view.
    }
    
    func initialization() {
        self.backView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.okButton.layer.cornerRadius = okButton.frame.height/2
        
        titileLabel.text = setTitle
        messageLabel.text = setMessage
        okButton.setTitle(setButtonTitle, for: .normal)
        self.showAnimation()
    }
    
   
    @IBAction func onClickOkButton(_ sender: UIButton) {
        if customDelegate != nil {
            self.customDelegate.onClickOkButtonAction()
            self.removeAnimation()
        }else{
            self.removeAnimation()
        }
    }
    
    
    @IBAction func onClickCloseButton(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    
}
