//
//  AddNewRecipePackViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 13/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen Id :- PSTMOBSTD0136

import UIKit

class AddNewRecipePackViewController: BaseViewController {

    @IBOutlet weak var txtFld_recipePackName: UITextField!
    @IBOutlet weak var txtFld_desc: UITextField!
    @IBOutlet weak var txtFld_tags: UITextField!
    @IBOutlet weak var lbl_category: UILabel!
    @IBOutlet weak var lbl_diet: UILabel!
    @IBOutlet weak var lbl_season: UILabel!
    @IBOutlet weak var btn_create: UIButton!
    
    var arrTxtFld = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialize()
    }

    func initialize()
    {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Add Recipe Pack")
        
        arrTxtFld = [txtFld_recipePackName, txtFld_desc, txtFld_tags]
        
        for txtFld in arrTxtFld
        {
            txtFld.setLeftPaddingPoints(8.0)
            txtFld.attributedPlaceholder = NSAttributedString(string: txtFld.placeholder ?? "",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        }
        
        btn_create.clipsToBounds = true
        btn_create.layer.cornerRadius = btn_create.frame.height/2
    }

    @IBAction func onClickAddRecipe(_ sender: Any) {
        
    }
    
    @IBAction func onClickSelectAudience(_ sender: Any) {
//        let audienceVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AudienceSettingsAndTypeViewController") as! AudienceSettingsAndTypeViewController
//        audienceVC.isSelectAudienceOnly = true
//        self.navigationController?.pushViewController(audienceVC, animated: true)
    }
}
