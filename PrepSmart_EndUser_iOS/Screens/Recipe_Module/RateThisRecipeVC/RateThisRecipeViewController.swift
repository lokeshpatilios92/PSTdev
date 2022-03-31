//
//  RateThisRecipeViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sanket on 03/02/20.
//  Copyright © 2020 Exceptionaire.co. All rights reserved.
//

import UIKit

class RateThisRecipeViewController: UIViewController {

    @IBOutlet var view_main: UIView!
    //    @IBOutlet var rateView: CosmosView!
    @IBOutlet var lbl_chefName: UILabel!
    @IBOutlet var btn_submit: UIButton!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var txtView_comment: UITextView!
    @IBOutlet var lbl_rateComment: UILabel!
    @IBOutlet weak var scrollView_inner: UIScrollView!
    
    var parentVC : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtView_comment.layer.borderWidth = 0.5
                txtView_comment.layer.borderColor = UIColor.lightGray.cgColor
                txtView_comment.layer.cornerRadius = 3.0
        //        txtView_comment.translatesAutoresizingMaskIntoConstraints = true
        //        txtView_comment.sizeToFit()
        //        txtView_comment.isScrollEnabled = false
                
                view_main.layer.borderWidth = 0.3
                view_main.layer.borderColor = UIColor.lightGray.cgColor
                view_main.layer.cornerRadius = 3.0
                
                imgView.layer.cornerRadius = imgView.frame.size.height / 2
                btn_submit.layer.cornerRadius = btn_submit.frame.size.height / 2
        
        
        if parentVC != nil
        {
            self.scrollView_inner.delegate = parentVC as? UIScrollViewDelegate
            self.scrollView_inner.isScrollEnabled = false
        }
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
