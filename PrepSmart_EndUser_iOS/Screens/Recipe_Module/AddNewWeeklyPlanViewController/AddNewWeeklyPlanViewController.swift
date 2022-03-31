//
//  AddNewWeeklyPlanViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 14/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Popover

class AddNewWeeklyPlanViewController: UIViewController {

    @IBOutlet weak var txtFld_weeklyPlanName: UITextField!
    @IBOutlet weak var txtFld_desc: UITextField!
    @IBOutlet weak var txtFld_tags: UITextField!
    @IBOutlet weak var lbl_category: UILabel!
    @IBOutlet weak var lbl_diet: UILabel!
    @IBOutlet weak var txtFld_notes: UITextField!
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var btn_info: UIButton!
    
    var arrTxtFld = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialize()
    }
    
    func initialize()
    {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Add Weekly Plan")
        
        arrTxtFld = [txtFld_weeklyPlanName, txtFld_desc, txtFld_tags, txtFld_notes]
        
        for txtFld in arrTxtFld
        {
            txtFld.setLeftPaddingPoints(8.0)
            txtFld.attributedPlaceholder = NSAttributedString(string: txtFld.placeholder ?? "",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        }
        
        btn_next.clipsToBounds = true
        btn_next.layer.cornerRadius = btn_next.frame.height/2
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        
    }
    
    @IBAction func onClickWeeklyPlanInfo(_ sender: Any) {
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: aView.frame.width - 40, height: 300))
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.font = UIFont.REGULAR_FONT_SMALLEST()
        infoLabel.textColor = .textColor()
        infoLabel.text = "Add notes, instructions, tups & tricks, and any other additional information you would like users to see."
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
        popover.show(aView, fromView: btn_info)
    }
}
