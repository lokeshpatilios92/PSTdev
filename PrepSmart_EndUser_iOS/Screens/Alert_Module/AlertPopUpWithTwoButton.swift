//
//  AlertPopUpWithTwoButton.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 11/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

protocol AlertPopUpWithTwoButtonDelegate {
    func onClcikOkButton()
}

class AlertPopUpWithTwoButton: UIViewController {

    @IBOutlet var bgView: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var msgLbl: UILabel!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var okBtn: UIButton!
    
     var titleText : String!
     var mesgText : String!
    
    
    var customDelegate : AlertPopUpWithTwoButtonDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialize()
    }
    
    func intialize() {
        self.bgView.layer.cornerRadius = 10
        //self.titleLbl.text = titleText  //Uncomment this line when you are using this pop up
        //self.msgLbl.text = mesgText      //Uncomment this line when you are using this pop up
        self.okBtn.layer.cornerRadius = self.okBtn.frame.height / 2
        self.cancelBtn.layer.cornerRadius = self.cancelBtn.frame.height / 2
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimation()
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    
    @IBAction func okBtnTapped(_ sender: UIButton) {
        if customDelegate != nil {
            self.customDelegate.onClcikOkButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    
}
