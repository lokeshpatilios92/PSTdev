//
//  LoadPlanTemplatePopUpVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 12/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//
//Screen ID :- PSTMOBSTD0102

import UIKit

protocol CustomLoadPlanTemplatePopUpDelegate {
    func onClickLoadButton()
    func onClickManagePlanTemplate()
}

class LoadPlanTemplatePopUpVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var loadPlanTemplateLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var managePlanTemplateLabel: UILabel!
    @IBOutlet weak var managePlanTemplateButton: UIButton!
    
    var customDelegate : CustomLoadPlanTemplatePopUpDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
        // Do any additional setup after loading the view.
    }
    
    
    func initialization() {
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.loadButton.layer.cornerRadius = loadButton.frame.height/2
        
        backView.layer.cornerRadius = 3
        
        managePlanTemplateLabel.setTextUnderline(#colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1), string: "Manage Plan Template")
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
//        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.placeholder = " Select"
        searchBar.sizeToFit()
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: .search, state: .normal)
        searchBar.layer.cornerRadius = 0
        searchBar.backgroundImage = UIImage()
        searchBar.clipsToBounds = true
        let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor.white
        searchBar.backgroundColor = UIColor.white
        
        searchBar.layer.borderColor = UIColor.black.cgColor
        searchBar.layer.borderWidth = 0.3
        searchBar.layer.cornerRadius = searchBar.frame.height/2
    }

    @IBAction func onClickCloseButtonAction(_ sender: UIButton) {
        self.removeAnimation()
    }
    @IBAction func onClickLoadButtonAction(_ sender: UIButton) {
        if customDelegate != nil {
            customDelegate.onClickLoadButton()
            self.removeAnimation()
        }else{
            self.removeAnimation()
        }
    }
    @IBAction func onClickManagePlanTemplateButtonAction(_ sender: UIButton) {
        if customDelegate != nil {
            customDelegate.onClickManagePlanTemplate()
            self.removeAnimation()
        }else{
            self.removeAnimation()
        }

    }
}
