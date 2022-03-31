//
//  RecipeInfoPopUpViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 11/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID:- PSTMOBSTD0107

import UIKit

protocol RecipeInfoPopUpViewControllerDelegate {
    func onClickLearnMoreButton()
}

class RecipeInfoPopUpViewController: UIViewController {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var rightBottomImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btn_learnMore: UIButton!
    @IBOutlet weak var rightBottomImageHeight: NSLayoutConstraint!
    
    var titleText : String!
    var mesgText : String!
    var bottomImageName : UIImage?
    var bottomImageHeight : Float!
    
    var customDelegate : RecipeInfoPopUpViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialize()
    }
    
    func intialize() {
        self.bgView.layer.cornerRadius = 10
        self.messageLabel.text = mesgText
        self.titleLabel.text = titleText
        
        if self.bottomImageName == nil {
            self.rightBottomImageHeight.constant = 0.001
        } else {
            self.rightBottomImage.image = bottomImageName
            self.rightBottomImageHeight.constant = 85
            self.rightBottomImage.layer.cornerRadius = 10
        }
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimation()
        
    }
    
    //    MARK: OnClick
    @IBAction func onClickCloseButton(_ sender: Any) {
        self.removeAnimation()
    }
    
    @IBAction func onClickLearnMoreButton(_ sender: Any) {
        if customDelegate != nil {
            self.customDelegate.onClickLearnMoreButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
        
    }
}
