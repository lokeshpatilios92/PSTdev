//
//  EditRecipeInfoViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 10/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.


import UIKit
import Tags
import DropDown

class EditRecipeInfoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var mainIngredientTextFiled: UITextField!
    @IBOutlet weak var dietTypeTextFiled: UITextField!
    @IBOutlet weak var courseTextFiled: UITextField!
    @IBOutlet weak var linkTextFiled: UITextField!
    @IBOutlet weak var tagViews: TagsView!
    var mainIngredientDropDown = DropDown()
    var dietTypeDropDown = DropDown()
    var CourcesDropDown = DropDown()
    
    var recipeDtails = RecipeDetailsStruct()
    
    
    var parentVC : EditCreatedRecipeViewController?
    var mainIngredients: MainIngredientList?
    var cource: Cources?
    var dietType: DietTypes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainIngredientTextFiled.delegate = self
        self.dietTypeTextFiled.delegate = self
        self.courseTextFiled.delegate = self
        
        self.parentVC?.constraintSwipeViewHt.constant = self.scrollView.contentSize.height
        self.parentVC?.view.setNeedsLayout()
        getMainIngredients()
        getDietTypes()
        getCources()
        populateData()
    }
    
    
    func populateData() {
        self.descriptionTextView.text = recipeDtails.recipeInfo?.recipeDescription
        let mainIngredients = recipeDtails.recipeInfo?.mainIngredients?.map { $0.mainIngredientName } as! [String]
        self.mainIngredientTextFiled.text = mainIngredients.joined(separator: ",")
        let cources = recipeDtails.recipeInfo?.course?.map { $0.courseTypeName } as! [String]
        self.courseTextFiled.text = cources.joined(separator: ",")
        
        let dietType = recipeDtails.recipeInfo?.dietType?.map { $0.dietTypeName } as! [String]
        self.dietTypeTextFiled.text = dietType.joined(separator: ",")
        tagViews.removeAll()
        let tags = recipeDtails.recipeInfo?.recipeTags?.map { $0.name } as! [String]        
        tagViews.append(contentsOf: tags)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.mainIngredientTextFiled {
            let vc = self.storyboard?.instantiateViewController(identifier: "MultiPickerController") as! MultiPickerController
            let mainIngredients = recipeDtails.recipeInfo?.mainIngredients?.map { $0.mainIngredientName } as! [String]
            vc.items = mainIngredients
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
            self.mainIngredientTextFiled.resignFirstResponder()
        } else if textField == self.dietTypeTextFiled {
            dietTypeDropDown.anchorView = self.dietTypeTextFiled
            dietTypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.dietTypeTextFiled.text = item
                
            }
            
            dietTypeDropDown.show()
            self.dietTypeTextFiled.resignFirstResponder()
        } else if textField == self.courseTextFiled {
            CourcesDropDown.anchorView = self.courseTextFiled
            CourcesDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.courseTextFiled.text = item
                
            }
            
            CourcesDropDown.show()
            self.courseTextFiled.resignFirstResponder()
        }
    }
    
    func getMainIngredients() {
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getMainIngredients, params: nil , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.mainIngredients = try JSONDecoder().decode(MainIngredientList.self, from: data)
                            self.mainIngredientDropDown.dataSource = self.mainIngredients?.mainIngredientList?.map { $0.mainIngredientName } as! [String]
                        }
                        catch
                        {
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                        }
                    }
                    else
                    {
                        Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: "Unable to load data")
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: "Unable to load data")
                }
                Loader.sharedInstance.hideIndicator()
                break
                
            case .failer(let error):
                
                Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                Loader.sharedInstance.hideIndicator()
                break
            }
        }
    }
    
    
    func getDietTypes() {
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getDietTypes, params: nil , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.dietType = try JSONDecoder().decode(DietTypes.self, from: data)
                            self.dietTypeDropDown.dataSource = self.dietType?.dietTypeList?.map { $0.dietName } as! [String]
                        }
                        catch
                        {
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                        }
                    }
                    else
                    {
                        Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: "Unable to load data")
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: "Unable to load data")
                }
                Loader.sharedInstance.hideIndicator()
                break
                
            case .failer(let error):
                
                Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                Loader.sharedInstance.hideIndicator()
                break
            }
        }
    }
    
    
    func getCources() {
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getCourse, params: nil , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.cource = try JSONDecoder().decode(Cources.self, from: data)
                            self.CourcesDropDown.dataSource = self.cource?.courceList?.map { $0.name } as! [String]
                        }
                        catch
                        {
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                        }
                    }
                    else
                    {
                        Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: "Unable to load data")
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: "Unable to load data")
                }
                Loader.sharedInstance.hideIndicator()
                break
                
            case .failer(let error):
                
                Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                Loader.sharedInstance.hideIndicator()
                break
            }
        }
    }
    
}
