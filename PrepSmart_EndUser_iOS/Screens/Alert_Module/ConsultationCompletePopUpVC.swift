//
//  ConsultationCompletePopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 13/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen ID : PSTMOBSTD149-1, PSTMOBSTD077 (Single label and single button)

import UIKit

protocol ConsultationCompletePopUpDelegate {
    
}

class ConsultationCompletePopUpVC: UIViewController {

    @IBOutlet var lbl_text: UILabel!
    @IBOutlet var btn_finalize: UIButton!
    
    var customDelegate : ConsultationCompletePopUpDelegate?
    var textLbl: String?
    var btnTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btn_finalize.layer.cornerRadius = self.btn_finalize.frame.height / 2
        self.setData(lbl_text: textLbl, bottomButton: btnTitle)
        // Do any additional setup after loading the view.
    }
    
    
    func setData(lbl_text: String?,bottomButton: String?)
    {
        self.lbl_text.text = lbl_text
        self.btn_finalize.setTitle(bottomButton, for: .normal)
    }
    
    @IBAction func onClickBtnFinalize(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func onClickBtnClose(_ sender: UIButton) {
        self.removeAnimation()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
