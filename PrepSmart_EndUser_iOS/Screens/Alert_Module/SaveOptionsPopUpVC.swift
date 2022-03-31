//
//  SaveOptionsPopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 12/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD0105,PSTMOBSTD0105-1

import UIKit
import DropDown
import Popover

protocol SaveOptionsPopUpVCDelegate {
    func onClcikSubmitBtn()
}


class SaveOptionsPopUpVC: UIViewController {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var newWeeklyPlanBtn: UIButton!
    @IBOutlet var existingPlanBtn: UIButton!
    @IBOutlet var createAWeeklyPlanTxtField: KKNEWTextFiled!
    @IBOutlet var mealPlanTxtFIeld: KKNEWTextFiled!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var popBtn: UIButton!
    
    
    let mealPlanDropDown = DropDown()
    var weeklyPlanArr : [String]?
    var customDelegate : SaveOptionsPopUpVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialize()
    }
    
    func intialize(){
        self.bgView.layer.cornerRadius = 10
        self.saveBtn.layer.cornerRadius = self.saveBtn.frame.height / 2
        self.saveBtn.clipsToBounds = true
        self.cancelBtn.clipsToBounds = true
        self.cancelBtn.layer.cornerRadius = self.cancelBtn.frame.height / 2
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        mealPlanTxtFIeld.isUserInteractionEnabled = false
        existingPlanBtn.setImage(#imageLiteral(resourceName: "radio_normal"), for: .normal)
        mealPlanDropDown.dataSource = self.weeklyPlanArr ?? []
        setupDropDown()
        self.showAnimation()
    }
    
    func setupDropDown(){
        mealPlanDropDown.anchorView = mealPlanTxtFIeld
       // mealPlanDropDown.width = self.mealPlanTxtFIeld.frame.width
        DropDown.appearance().textColor = UIColor.darkText
        DropDown.appearance().selectedTextColor = UIColor.darkText
        DropDown.appearance().textFont = UIFont(name: "ENGCARNATION", size: 14.0)!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().cellHeight = 60
        DropDown.startListeningToKeyboard()
    }
    
    @IBAction func popUpBtnTapped(_ sender: UIButton) {
        popUp()
    }
    
    
    @IBAction func radioBtnTapped(_ sender: UIButton) {
        if sender == newWeeklyPlanBtn{
            createAWeeklyPlanTxtField.isUserInteractionEnabled = true
            newWeeklyPlanBtn.setImage(#imageLiteral(resourceName: "radio_active"), for: .normal)
            mealPlanTxtFIeld.isUserInteractionEnabled = false
            existingPlanBtn.setImage(#imageLiteral(resourceName: "radio_normal"), for: .normal)
            
        }else if sender == existingPlanBtn{
            createAWeeklyPlanTxtField.isUserInteractionEnabled = false
            newWeeklyPlanBtn.setImage(#imageLiteral(resourceName: "radio_normal"), for: .normal)
            mealPlanTxtFIeld.isUserInteractionEnabled = true
            existingPlanBtn.setImage(#imageLiteral(resourceName: "radio_active"), for: .normal)
        }
    }
    
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        if customDelegate != nil {
            self.customDelegate.onClcikSubmitBtn()
            self.removeAnimation()
        } else {
            self.removeAnimation()
        }
    }
    
    func popUp(){
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: aView.frame.width - 40, height: 300))
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.font = UIFont.REGULAR_FONT_SMALLEST()
        infoLabel.textColor = .textColor()
        infoLabel.text = "Save the recipes for the selected week as a new Meal Plan Template that can be used again and again."
        infoLabel.sizeToFit()
        infoLabel.frame = CGRect(x: infoLabel.frame.origin.x, y: infoLabel.frame.origin.y, width: infoLabel.frame.width, height: infoLabel.frame.height)
        
        let y = infoLabel.frame.height
        
        aView.addSubview(infoLabel)
        aView.frame = CGRect(x: aView.frame.origin.x, y: aView.frame.origin.y, width: aView.frame.width, height: y + 20)
        
        let popoverOptions: [PopoverOption] = [
            .type(.auto),
            .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
        ]
        let popover = Popover(options: popoverOptions)
        popover.show(aView, fromView: popBtn)
    }
    
    @IBAction func mealPlanPopUpClicked(_ sender: UIButton) {
        mealPlanDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.mealPlanTxtFIeld.text = item
        }
        self.mealPlanDropDown.show()
    }
    
    
}

