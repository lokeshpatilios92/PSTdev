//
//  DeleteAndChangeRecipePopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 16/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD167



import UIKit

protocol DeleteAndChangeRecipePopUpDelegate {
    func onClickRightButton()
}


class DeleteAndChangeRecipePopUpVC: UIViewController {
    
    @IBOutlet var btn_confirm: UIButton!
    @IBOutlet var btn_cancel: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var titleLabelText: String?
    var btn_confirmText: String?
    var btn_cancelText: String?
    var customDelegate : DeleteAndChangeRecipePopUpDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    func initialize()
    {
        btn_confirm.layer.cornerRadius = btn_confirm.frame.size.height / 2
        btn_cancel.layer.cornerRadius = btn_cancel.frame.size.height / 2
        btn_cancel.layer.borderWidth = 1.0
        btn_cancel.layer.borderColor = UIColor.appOrangeColor().cgColor
        self.setData(titleLabelText: titleLabelText, leftBtnText: btn_confirmText, rightBtnText: btn_cancelText)
    }
    
    
    func setData(titleLabelText : String?,leftBtnText : String?,rightBtnText : String?)
    {
        self.titleLabel.text = titleLabelText ?? ""
        self.btn_cancel.setTitle(leftBtnText, for: .normal)
        self.btn_confirm.setTitle(rightBtnText, for: .normal)
    }
    
    @IBAction func onClickBtnClose(_ sender: UIButton) {
        //Left Button
//        self.dismiss(animated: true, completion: nil)
        self.removeAnimation()
    }
    
    
    @IBAction func onClickRightButton(_ sender: UIButton)
    {
//        if customDelegate != nil
//        {
//            customDelegate?.onClickRightButton()
//        }
        self.removeAnimation()
    }
    
}
