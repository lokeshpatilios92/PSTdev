//
//  CustomOkCancelPopUpViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 04/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

protocol CustomOkCancelPopUpViewControllerDelegate {
    func onClickOkButton()
    func onClickCancelButton()
}

class CustomOkCancelPopUpViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftCornerImageView: UIImageView!
    @IBOutlet weak var leftCornerImageHeight: NSLayoutConstraint!
    
    var titleText : String!
    var msgText : String!
    var okButtonName : String! = ""
    var cancelButtonName : String! = ""
    var leftCornerImage : UIImage?
    
    var customDelegate : CustomOkCancelPopUpViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialize()
    }
    
    func intialize() {
        self.bgView.layer.cornerRadius = 10
        
        self.titleLabel.text = titleText
        self.messageLabel.text = msgText
        self.okButton.setTitle(okButtonName, for: .normal)
        self.cancelButton.setTitle(cancelButtonName, for: .normal)
        
        self.okButton.layer.cornerRadius = self.okButton.frame.height / 2
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.height / 2
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimation()
        
        if leftCornerImage != nil {
            leftCornerImageHeight.constant = 80
        } else {
            leftCornerImageHeight.constant = 0.00
        }
    }
    
    //    MARK: OnClick
    @IBAction func onClickCloseButton(_ sender: Any) {
        self.removeAnimation()
    }
    
    @IBAction func onClickCancelButton(_ sender: Any) {
        if customDelegate != nil {
            self.customDelegate.onClickCancelButton()
        }
        self.removeAnimation()
    }
    
    @IBAction func onClickOkButton(_ sender: Any) {
        if customDelegate != nil {
            self.customDelegate.onClickOkButton()
        }
        self.removeAnimation()
    }

}
