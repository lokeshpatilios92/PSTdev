//
//  RecipeInfoViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 10/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
// Screen ID :- PSTMOBSTD0138

import UIKit
import Popover
import DropDown

protocol RecipeInfoDelegate {
    func onClickNextButton()
}

class RecipeInfoViewController: BaseViewController {

    @IBOutlet weak var txtFld_recipeName: UITextField!
    @IBOutlet weak var txtFld_mainIngredients: UITextField!
    @IBOutlet weak var txtFld_tags: UITextField!
    @IBOutlet weak var txtFld_course: UITextField!
    @IBOutlet weak var lbl_dietType: UILabel!
    @IBOutlet weak var lbl_category: UILabel!
    @IBOutlet weak var lbl_season: UILabel!
    @IBOutlet weak var txtFld_servings: UITextField!
    @IBOutlet weak var txtFld_cookingTime: UITextField!
    @IBOutlet weak var lbl_pairItWith: UILabel!
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var scrollView_inner: UIScrollView!
    @IBOutlet weak var btn_tagsInfo: UIButton!
    @IBOutlet weak var btn_mainIngInfo: UIButton!
    @IBOutlet weak var mainIngredientsBtn: UIButton!
    @IBOutlet weak var tagsBtn: UIButton!
    @IBOutlet weak var dietTypesBtn: UIButton!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var seasonBtn: UIButton!
    @IBOutlet weak var pairItWithBtn: UIButton!
    
    
    var customDelegate : RecipeInfoDelegate!
    var arrTxtFld = [UITextField]()
    var parentVC : UIViewController?
    
    let mainIngredientsDropDown = DropDown()
    let dietTypeDropDown = DropDown()
    let categoryDropDown = DropDown()
    let seasonDropDown = DropDown()
    let pairWithItDropDown = DropDown()
    let tagsDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initialize()
    }

    func initialize()
    {
        arrTxtFld = [txtFld_recipeName, txtFld_mainIngredients, txtFld_tags, txtFld_course, txtFld_servings, txtFld_cookingTime]
        
        for txtFld in arrTxtFld
        {
            txtFld.setLeftPaddingPoints(8.0)
            txtFld.attributedPlaceholder = NSAttributedString(string: txtFld.placeholder ?? "",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        }
        
        btn_next.clipsToBounds = true
        btn_next.layer.cornerRadius = btn_next.frame.height/2
        btn_next.layer.borderWidth = 0.5
        btn_next.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
        
        if parentVC != nil
        {
            self.scrollView_inner.delegate = parentVC as? UIScrollViewDelegate
            self.scrollView_inner.isScrollEnabled = false
        }
        
        mainIngredientsDropDown.dataSource = ["Meal Plan A","Meal Plan B","Meal Plan C","Meal Plan D","Meal Plan E"]
        dietTypeDropDown.dataSource = ["Meal Plan A","Meal Plan B","Meal Plan C","Meal Plan D","Meal Plan E"]
        categoryDropDown.dataSource = ["Meal Plan A","Meal Plan B","Meal Plan C","Meal Plan D","Meal Plan E"]
        seasonDropDown.dataSource = ["Meal Plan A","Meal Plan B","Meal Plan C","Meal Plan D","Meal Plan E"]
        pairWithItDropDown.dataSource = ["Meal Plan A","Meal Plan B","Meal Plan C","Meal Plan D","Meal Plan E"]
        tagsDropDown.dataSource = ["Meal Plan A","Meal Plan B","Meal Plan C","Meal Plan D","Meal Plan E"]
        
        setupDropDown()
    }
    
    func setupDropDown(){
        mainIngredientsDropDown.anchorView = txtFld_mainIngredients
        dietTypeDropDown.anchorView = lbl_dietType
        categoryDropDown.anchorView = lbl_category
        seasonDropDown.anchorView = lbl_season
        pairWithItDropDown.anchorView = lbl_pairItWith
        pairWithItDropDown.anchorView = lbl_pairItWith
        tagsDropDown.anchorView = txtFld_tags
       // mealPlanDropDown.width = self.mealPlanTxtFIeld.frame.width
        DropDown.appearance().textColor = UIColor.darkText
        DropDown.appearance().selectedTextColor = UIColor.darkText
        DropDown.appearance().textFont = UIFont(name: "ENGCARNATION", size: 14.0)!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().cellHeight = 60
        DropDown.startListeningToKeyboard()
    }
    
    @IBAction func onClickMainIngredients(_ sender: Any) {
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: aView.frame.width - 40, height: 300))
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.font = UIFont.REGULAR_FONT_SMALLEST()
        infoLabel.textColor = .textColor()
        infoLabel.text = "For this field, enter one or two of the recipe's main ingredients. For example, enter 'Chicken' instead of 'Chicken Breast' or 'Pasta' instead of 'Penne Pasta'. The recipe's detailed ingredients will be entered on the next screen."
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
        popover.show(aView, fromView: btn_mainIngInfo)
    }
    
    @IBAction func onClickTags(_ sender: Any) {
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: aView.frame.width - 40, height: 300))
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.font = UIFont.REGULAR_FONT_SMALLEST()
        infoLabel.textColor = .textColor()
        infoLabel.text = "Tags help users find your recipes. Become a recipe tagging expert below to maximize recipe visibility and subscriptions."
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
        popover.show(aView, fromView: btn_tagsInfo)
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        if customDelegate != nil {
            self.customDelegate.onClickNextButton()
        }
    }
    
    @IBAction func onClickDescription(_ sender: Any) {
        let descVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "DescriptionViewController") as! DescriptionViewController
        self.navigationController?.pushViewController(descVC, animated: true)
    }
    
    @IBAction func onClickAudienceSetting(_ sender: Any) {
//        let audienceVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AudienceSettingsAndTypeViewController") as! AudienceSettingsAndTypeViewController
//        audienceVC.isSelectAudienceOnly = false
//        self.navigationController?.pushViewController(audienceVC, animated: true)
    }
    
    //    @IBAction func onClickInfoButton(_ sender: Any) {
//
//        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
//
//        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: aView.frame.width - 40, height: 300))
//        infoLabel.numberOfLines = 0
//        infoLabel.lineBreakMode = .byWordWrapping
//        infoLabel.font = UIFont.REGULAR_FONT_SMALLEST()
//        infoLabel.textColor = .textColor()
//        infoLabel.text = "System reminder are importent notifications that remind you to post the content needed to maximize earning and keep your followers engaged"
//        infoLabel.sizeToFit()
//        infoLabel.frame = CGRect(x: infoLabel.frame.origin.x, y: infoLabel.frame.origin.y, width: infoLabel.frame.width, height: infoLabel.frame.height)
//
//        let y = infoLabel.frame.height
//
//        aView.addSubview(infoLabel)
//        aView.frame = CGRect(x: aView.frame.origin.x, y: aView.frame.origin.y, width: aView.frame.width, height: y + 20)
//
//        let popoverOptions: [PopoverOption] = [
//            .type(.auto),
//            .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
//        ]
//
//        let popover = Popover(options: popoverOptions)
//        popover.show(aView, fromView: infoButton)
//
//    }
    
    
    
    @IBAction func onClickDropDownBtn(_ sender: UIButton) {
        
        if sender == mainIngredientsBtn
        {
            mainIngredientsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.txtFld_mainIngredients.text = item
            }
            self.mainIngredientsDropDown.show()
        }
         else if sender == tagsBtn
        {
            tagsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.txtFld_tags.text = item
            }
            self.tagsDropDown.show()
        }
        else if sender == dietTypesBtn
        {
            dietTypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.lbl_dietType.text = item
            }
            self.dietTypeDropDown.show()
        }
        else if sender == categoryBtn
        {
            categoryDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.lbl_category.text = item
            }
            self.categoryDropDown.show()
        }
        else if sender == seasonBtn
        {
            seasonDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.lbl_season.text = item
            }
            self.seasonDropDown.show()
        }
        else if sender == pairItWithBtn
        {
            pairWithItDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.lbl_pairItWith.text = item
            }
            self.pairWithItDropDown.show()
        }
    }
    
    
    
    
}
