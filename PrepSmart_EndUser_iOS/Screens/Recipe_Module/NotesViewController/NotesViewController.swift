//
//  NotesViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 21/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Popover

class NotesViewController: UIViewController {

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var textView_notes: UITextView!
    @IBOutlet weak var btn_info: UIButton!
    @IBOutlet weak var scrollView_inner: UIScrollView!
    
    var parentVC : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func initialize()
    {
        if parentVC != nil
        {
            self.scrollView_inner.delegate = parentVC as? UIScrollViewDelegate
            self.scrollView_inner.isScrollEnabled = false
        }
    }
    
    @IBAction func onClickInfoButton(_ sender: Any) {
        
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: aView.frame.width - 40, height: 300))
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.font = UIFont.REGULAR_FONT_SMALLEST()
        infoLabel.textColor = .textColor()
        infoLabel.text = "Add notes, instructions, tips & tricks, and any other additional information you would like users to see."
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
