//
//  OneImageOneLabelAndOneButtonVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 27/01/20.
//  Copyright © 2020 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD0154

import UIKit

protocol OneImageOneLabelAndOneButtonVCDelegate {
    
    func onClickOkButton()
    
}


class OneImageOneLabelAndOneButtonVC: UIViewController {

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    var setDetailLabelMsg : String?
    var setButtonText : String?
    var setTopImage : UIImage?
    
    var customDelegate : OneImageOneLabelAndOneButtonVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialization()
        // Do any additional setup after loading the view.
    }
    
    func initialization()
    {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.okButton.layer.cornerRadius = okButton.frame.height/2
        backView.layer.cornerRadius = 3
        
        self.detailLabel.text = setDetailLabelMsg
        self.okButton.setTitle(setButtonText, for: .normal)
        self.topImage.image = setTopImage
           
        
        self.showAnimation()
    }
    

//    func setData(lbl_txt: String?,bottomBtnText: String?,topImage : UIImage?)
//    {
//        self.detailLabel.text = lbl_txt ?? ""
//        self.okButton.setTitle(bottomBtnText ?? "", for: .normal)
//        self.topImage.image = topImage ?? UIImage()
//    }
    
    
    @IBAction func onClickOkButton(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func onClickCloseButton(_ sender: UIButton) {
        self.removeAnimation()
    }
}
