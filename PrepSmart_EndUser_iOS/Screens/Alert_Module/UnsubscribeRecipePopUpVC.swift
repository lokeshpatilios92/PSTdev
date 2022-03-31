//
//  UnsubscribeRecipePopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 13/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen ID : PSTMOBSTD115-1 , PSTMOBSTD161 (LogOut PopUp), PSTMOBSTD093-1

import UIKit

protocol UnsubscribeRecipePopUpVCDelegate {
    func onClcikRightButton()
}

class UnsubscribeRecipePopUpVC: UIViewController {
    @IBOutlet var btnLeft: UIButton!
    @IBOutlet var btnRight: UIButton!
    @IBOutlet var lbl_text: UILabel!
    @IBOutlet var btn_close: UIButton!
    
    var isLogOut : Bool?
    
    var leftBtnTitle : String?
    var rightBtnTitle : String?
    var lblText : String?
    
    var customDelegate : UnsubscribeRecipePopUpVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnLeft.layer.cornerRadius = self.btnLeft.frame.height/2
        self.btnRight.layer.cornerRadius = self.btnLeft.frame.height/2
        self.setData(leftBtnTitle: leftBtnTitle ?? "", rightBtnTitle: rightBtnTitle ?? "", lblText: lblText ?? "", isLogOut: isLogOut)
    }

    func setData(leftBtnTitle: String, rightBtnTitle: String, lblText : String, isLogOut : Bool?) {
//        btnLeft.setTitle(leftBtnTitle, for: .normal)
//        btnLeft.setTitle(leftBtnTitle, for: .normal)
//        lbl_text.text = lblText
        
        self.leftBtnTitle = leftBtnTitle
        self.rightBtnTitle = rightBtnTitle
        self.lblText = lblText
//        self.isLogOut = isLogOut
        
        self.btnLeft.setTitle(self.leftBtnTitle, for: .normal)
        self.btnRight.setTitle(self.rightBtnTitle, for: .normal)
        self.lbl_text.text = self.lblText
        self.isLogOut = isLogOut
    }
    
//    MARK: OnClick Func
    @IBAction func onClickLeftBtn(_ sender: UIButton) {
        self.removeAnimation()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func onClickBtnClose(_ sender: UIButton) {
        self.removeAnimation()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickRightBtn(_ sender: UIButton) {
        
        if customDelegate != nil{
            customDelegate?.onClcikRightButton()
        }
        self.removeAnimation()
        self.dismiss(animated: true, completion: nil)
    }
}
