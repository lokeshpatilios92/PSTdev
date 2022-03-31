//
//  EditRecipeInfoViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 10/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.


import UIKit
import Tags

class EditRecipeInfoViewController: UIViewController {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var mainIngredientTextFiled: UITextField!
    @IBOutlet weak var dietTypeTextFiled: UITextField!
    @IBOutlet weak var courseTextFiled: UITextField!
    @IBOutlet weak var linkTextFiled: UITextField!
    @IBOutlet weak var tagViews: TagsView!
    
    
    var parentVC : EditCreatedRecipeViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.parentVC?.constraintSwipeViewHt.constant = self.scrollView.contentSize.height
        self.parentVC?.view.setNeedsLayout()
    }
}
