//
//  CustomPopUpViewController.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 27/05/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD013
    
import UIKit

protocol CustomPopUpViewControllerDelegate {
    func onClcikOkButton()
}

class CustomPopUpViewController: UIViewController {
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var rightBottomImage: UIImageView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var okBurron: UIButton!
    
    @IBOutlet weak var rifgtBottomImageHeight: NSLayoutConstraint!
    
    var topImageName : UIImage?
    var mesgText : String!
    var bottomImageName : UIImage?
    var bottomImageHeight : Float!

    var customDelegate : CustomPopUpViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialize()
    }
    
    func intialize() {
        self.bgView.layer.cornerRadius = 10
        self.messageLabel.text = mesgText
        self.topImage.image = topImageName
 
        if self.bottomImageName == nil {
            self.rifgtBottomImageHeight.constant = 0.001
        } else {
            self.rightBottomImage.image = bottomImageName
            self.rifgtBottomImageHeight.constant = 85
            self.rightBottomImage.layer.cornerRadius = 10
        }
        
        
        self.okBurron.layer.cornerRadius = self.okBurron.frame.height / 2
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimation()
    }
    
    //    MARK: OnClick
    @IBAction func onClickCloseButton(_ sender: Any) {
        self.removeAnimation()
    }
    
    @IBAction func onClickOkButton(_ sender: Any) {
        if customDelegate != nil {
            self.customDelegate.onClcikOkButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
        
    }
}
