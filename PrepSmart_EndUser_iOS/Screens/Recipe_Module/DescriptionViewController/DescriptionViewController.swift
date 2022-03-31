//
//  DescriptionViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 12/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD0144

import UIKit

class DescriptionViewController: BaseViewController {

    @IBOutlet weak var txtView_desc: UITextView!
    @IBOutlet weak var btn_done: UIButton!
    @IBOutlet weak var charecterCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialize()
    }
    
    func initialize()
    {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Description")
        
        btn_done.clipsToBounds = true
        btn_done.layer.cornerRadius = btn_done.frame.height/2
        txtView_desc.delegate = self
    }
    
}

extension DescriptionViewController : UITextViewDelegate{
    
    //Mark :- Limit Character Count
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        charecterCountLabel.text = "\(currentText.count)/300"
        
        return changedText.count <= 300
    }
    
}

