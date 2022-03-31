//
//  RateRecipePopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 30/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Cosmos

protocol CustomRateRecipePopUpDelegate {
    func onClickNextButton()
}


class RateRecipePopUpVC: UIViewController {
    
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var ratingView: CosmosView!
    
    var customDelegate : CustomRateRecipePopUpDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializer()
    }
    
    func initializer(){
        self.backView.layer.cornerRadius = 10
        self.okBtn.layer.cornerRadius = self.okBtn.frame.height / 2
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimation()
    }
    
    @IBAction func okBtnTapped(_ sender: UIButton) {
        if customDelegate != nil {
            self.customDelegate.onClickNextButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    @IBAction func camcelTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
}
