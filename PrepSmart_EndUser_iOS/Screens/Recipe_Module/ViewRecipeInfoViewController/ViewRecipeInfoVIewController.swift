//
//  ViewRecipeInfoVIewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 21/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Tags

class ViewRecipeInfoVIewController: BaseViewController {

    @IBOutlet weak var lbl_audience: UILabel!
    @IBOutlet weak var lbl_type: UILabel!
    @IBOutlet weak var lbl_mainIngredients: UILabel!
    @IBOutlet weak var lbl_dietType: UILabel!
    @IBOutlet weak var lbl_course: UILabel!
    @IBOutlet weak var lbl_link: UILabel!
    @IBOutlet weak var scrollView_inner: UIScrollView!
    @IBOutlet weak var tagsView: TagsView!
    
    var parentVC : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialize()
    }

    func initialize()
    {
        if parentVC != nil
        {
            self.scrollView_inner.delegate = parentVC as? UIScrollViewDelegate
            self.scrollView_inner.isScrollEnabled = false
        }
        
        tagsView.tagLayerRadius = 15.0
        tagsView.tagFont = UIFont.REGULAR_FONT_SMALL()
    }
}
