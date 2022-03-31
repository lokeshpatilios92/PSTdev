//
//  TopTagsPopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 31/01/20.
//  Copyright © 2020 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD047,PSTMOBSTD051

import UIKit
import Tags

protocol CustomTopTagsPopUpDelegate {
    
}
class TopTagsPopUpVC: UIViewController {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var tagView: TagsView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var topTagLabel: UILabel!
    
    var customDelegate : CustomTopTagsPopUpDelegate?
    
    var toptags = [Top_tags]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialization()
    }
    
    func initialization()
    {
        self.backView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.topLabel.underline()
        
        tagView.tagLayerRadius = 15.0
        tagView.tagFont = UIFont.REGULAR_FONT_SMALL()
        let array: [String] = toptags.map{String($0.tag_name ?? "") + " (" + String($0.count ?? 0) + ")"}
        let tags = array.joined(separator:" , ")
        tagView.tags = tags
        self.okButton.layer.cornerRadius = self.okButton.frame.height / 2
        
        self.showAnimation()
    }
    
    @IBAction func onClickCloseButton(_ sender: UIButton) {
        self.removeAnimation()
    }
    
    @IBAction func onClickOkButton(_ sender: UIButton) {
        self.removeAnimation()
    }
}
