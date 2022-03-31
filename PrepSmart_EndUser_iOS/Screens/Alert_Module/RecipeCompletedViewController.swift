//
//  RecipeCompletedViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sanket on 04/02/20.
//  Copyright © 2020 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD066

import UIKit
import Cosmos


protocol CustomRecipeCompletedViewControllerDelegate {
    func onClickOkButton(feedbackText : String?,rating : Double?)
}

class RecipeCompletedViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var rateThisRecipeLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nowThatYouHaveLabel: UILabel!
    
    var customDelegate : CustomRecipeCompletedViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
        // Do any additional setup after loading the view.
    }
    
    func initialization() {
        
        self.backView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.backButton.layer.cornerRadius = 20
        self.submitButton.layer.cornerRadius = 20
        self.showAnimation()
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        if customDelegate != nil {
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
}
