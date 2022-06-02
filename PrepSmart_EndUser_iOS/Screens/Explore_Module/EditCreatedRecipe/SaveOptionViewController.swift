//
//  SaveOptionViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 12/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class SaveOptionViewController: BaseViewController {
    var parentVC: EditCreatedRecipeViewController?
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var btn_save: UIButton!
    @IBOutlet var btn_cancel: UIButton!
    
    var cancelTap: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
        // Do any additional setup after loading the view.
    }
    

    func initialize()
    {
        btn_save.layer.cornerRadius = btn_save.frame.height / 2
        btn_cancel.layer.cornerRadius = btn_cancel.frame.height / 2
        btn_cancel.layer.borderWidth = 1.0
        btn_cancel.layer.borderColor = UIColor.appOrangeColor().cgColor
    }
    
    
    @IBAction func btnCancelAction(_ sender: Any) {
        self.cancelTap!()
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
