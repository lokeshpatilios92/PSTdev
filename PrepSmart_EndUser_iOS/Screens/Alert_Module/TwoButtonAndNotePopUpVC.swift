//
//  TwoButtonAndNotePopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 11/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

protocol TwoButtonAndNotePopUpDelegate {
    func onClcikDeleteButton()
}


class TwoButtonAndNotePopUpVC: UIViewController {

    @IBOutlet var bgView: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var noteLbl: UILabel!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var deleteAllBtn: UIButton!
    
    var titleText : String!
    var noteText : String!
    
    
    var customDelegate : TwoButtonAndNotePopUpDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         intialize()
       
    }
    
    func intialize() {
        self.bgView.layer.cornerRadius = 10
        self.titleLbl.text = titleText  //Uncomment this line when you are using this pop up
        self.noteLbl.text = noteText      //Uncomment this line when you are using this pop up
        self.deleteAllBtn.layer.cornerRadius = self.deleteAllBtn.frame.height / 2
        self.cancelBtn.layer.cornerRadius = self.cancelBtn.frame.height / 2
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimation()
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    
    @IBAction func deleteAllBtnTapped(_ sender: UIButton) {
        if customDelegate != nil {
            self.customDelegate.onClcikDeleteButton()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    

}
