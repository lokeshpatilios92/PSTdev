//
//  OneLabelAndTwoButtonPopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 20/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit


protocol CustomOneLabelAndTwoButtonPopUpDelegate {
    func onClickRightButton()
}

class OneLabelAndTwoButtonPopUpVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var customDelegate : CustomOneLabelAndTwoButtonPopUpDelegate!
    
    var setTitleLabelText : String?
    var isHiddenLeftButton : Bool?
    var setLeftButtonTitle : String?
    var setRightButtonTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
        // Do any additional setup after loading the view.
    }

    func initialization() {
        
        self.backView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.leftButton.layer.cornerRadius = self.leftButton.frame.height/2
        self.rightButton.layer.cornerRadius = self.rightButton.frame.height/2
        
        if isHiddenLeftButton == true{
            leftButton.isHidden = true
        }else{
            leftButton.isHidden = false
        }
        
        if setLeftButtonTitle != nil{
            leftButton.setTitle(setLeftButtonTitle, for: .normal)
        }else{
            leftButton.setTitle("Cancel", for: .normal)
        }
        
        if setRightButtonTitle != nil {
            rightButton.setTitle(setRightButtonTitle, for: .normal)
        }else{
            rightButton.setTitle("Archive Anyway", for: .normal)
        }
        
        if setTitleLabelText != nil {
            titleLabel.text = setTitleLabelText
        }else{
            titleLabel.text = "Are you sure you want to delete this recipe?"
        }
        
        self.showAnimation()
    }
    
    
    @IBAction func leftButtonAction(_ sender: UIButton) {
        //Cancel Button
         self.removeAnimation()
    }
    
    @IBAction func rightButtonAction(_ sender: UIButton) {
        //Archieve Anyway Button
        if customDelegate != nil {
            self.customDelegate.onClickRightButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
         self.removeAnimation()
    }
}
