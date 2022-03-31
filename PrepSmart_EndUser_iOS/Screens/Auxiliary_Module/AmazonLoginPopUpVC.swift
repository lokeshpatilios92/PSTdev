//
//  AmazonLoginPopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 12/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//
// Screen ID:- PSTMOBSTD081

import UIKit

protocol CustomAmazonLoginPopUpDelegate {
    func onClickLoginWithAmazon()
    func onClickCreateAmazonAccount()
}

class AmazonLoginPopUpVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var loginWithAmazonButton: UIButton!
    @IBOutlet weak var createAmazonAccountButton: UIButton!
    @IBOutlet weak var loginButtonView: UIView!
    @IBOutlet weak var loginButtonLabel: UILabel!
    
    
    var customDelegate : CustomAmazonLoginPopUpDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
        // Do any additional setup after loading the view.
    }
    

    func initialization() {
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.loginButtonView.layer.cornerRadius = loginButtonView.frame.height/2
        backView.layer.cornerRadius = 3
    }
    
    
    @IBAction func onClickCloseButton(_ sender: UIButton) {
        self.removeAnimation()
    }
    @IBAction func onClickLoginWithAmazonButton(_ sender: UIButton) {
        
        if customDelegate != nil {
            customDelegate.onClickLoginWithAmazon()
            self.removeAnimation()
        }else{
            self.removeAnimation()
        }
    }
    @IBAction func onClickCreateAmazonAccountButton(_ sender: UIButton) {
        if customDelegate != nil {
            customDelegate.onClickCreateAmazonAccount()
            self.removeAnimation()
        }else{
            self.removeAnimation()
        }
    }
}
