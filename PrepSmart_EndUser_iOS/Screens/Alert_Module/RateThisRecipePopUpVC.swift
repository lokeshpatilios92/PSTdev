//
//  RateThisRecipePopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 13/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD170

import UIKit
import Cosmos


protocol CustomRateThisRecipePopUpDelegate {
    func onClickOkButton(feedbackText : String?,rating : Double?)
}

class RateThisRecipePopUpVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var rateThisRecipeLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nowThatYouHaveLabel: UILabel!
    @IBOutlet weak var nowThatYouHaveTextView: UITextView!
    @IBOutlet weak var ratingView: CosmosView!
    
    var customDelegate : CustomRateThisRecipePopUpDelegate!
    
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
        
        self.nowThatYouHaveTextView.layer.cornerRadius = 2
        self.nowThatYouHaveTextView.layer.borderWidth = 0.5
        self.nowThatYouHaveTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.nowThatYouHaveLabel.isHidden = false
        
        self.showAnimation()
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        if customDelegate != nil {
            self.customDelegate.onClickOkButton(feedbackText: nowThatYouHaveTextView.text, rating: ratingView.rating)
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
}

extension RateThisRecipePopUpVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.nowThatYouHaveLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if nowThatYouHaveTextView.text == "" {
            self.nowThatYouHaveLabel.isHidden = false
        }else{
            self.nowThatYouHaveLabel.isHidden = true
        }
        
    }
    
}
