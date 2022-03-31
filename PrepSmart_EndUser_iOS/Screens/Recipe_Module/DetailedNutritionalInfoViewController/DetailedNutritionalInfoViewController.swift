//
//  DetailedNutritionalInfoViewController.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 19/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class DetailedNutritionalInfoViewController: BaseViewController {
    @IBOutlet var tableView : UITableView!
    
    let nutritionInfoHeaderTableCell = "NutritionInfoHeaderTableCell"
    var sectionArray = ["Calories 140","Cholesterol","Total Carbohydrate 43.0g","Protein 8.0g"]
    var recipeID = ""
    let global_Var = GlobalClass.sharedManager
    
    var NutritionDetailsData = NutritionDetailsStruct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NutritionalDetailApi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.dismissKeyboardOnTap()
        addKeyboardNotificationObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotificationObserver()
    }
    func initialize() {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Nutrition")
        tableView.register(UINib.init(nibName: nutritionInfoHeaderTableCell, bundle: nil), forCellReuseIdentifier: nutritionInfoHeaderTableCell)
    }
}
extension DetailedNutritionalInfoViewController : UITableViewDelegate, UITableViewDataSource {
    //    MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        if section == 1 {
            return 2
        }
        if section == 2 {
            return 2
        }
        if section == 3 {
            return 4
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: nutritionInfoHeaderTableCell, for: indexPath) as! NutritionInfoHeaderTableCell
        
        cell.leftBgView.backgroundColor = UIColor.white
        cell.rightBgView.backgroundColor = UIColor.init(red: 244.0/255.0, green: 241.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        
        cell.leftLabel.textColor = UIColor.textColor()
        cell.rightLabel.textColor = UIColor.textColor()
        
        cell.leftLabel.font = UIFont.REGULAR_FONT_SMALL()
        cell.rightLabel.font = UIFont.REGULAR_FONT_SMALL()
        
        cell.leftLabelLeadingSpace.constant = 30
        let dict = NutritionDetailsData.recipeNutritionixInfo
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.leftLabel.text = ""
                cell.rightLabel.text = "% Daily Value"
                return cell
            }
            if indexPath.row == 1 {
                cell.leftLabelLeadingSpace.constant = 10
                cell.leftLabel.textColor = UIColor.appOrangeColor()
                cell.leftLabel.text = "Total Fat 25.0g"
                cell.rightLabel.text = dict?.nfTotalFat
                return cell
            }
            if indexPath.row == 2 {
                cell.leftLabel.text = "Saturated Fat 3.0g"
                cell.rightLabel.text = dict?.nfSaturatedFat
                return cell
            }
            if indexPath.row == 3 {
                cell.leftLabel.text = "Trans Fat"
                cell.rightLabel.text = ""
                return cell
            }
        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.leftLabel.text = "Sodium 320.0mg"
                cell.rightLabel.text = dict?.nfSodium
                return cell
            }
            if indexPath.row == 1 {
                cell.leftLabel.text = "Potassium 900.0mg"
                cell.rightLabel.text = dict?.nfPotassium
                return cell
            }
        }
        else if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell.leftLabel.text = "Dietary Fiber 12.0g"
                cell.rightLabel.text = dict?.nfDietaryFiber
                return cell
            }
            if indexPath.row == 1 {
                cell.leftLabel.text = "Sugars 3.0g"
                cell.rightLabel.text = dict?.nfSugars
                return cell
            }
        }
        else if indexPath.section == 3 {
            if indexPath.row == 0 {
                cell.leftLabel.text = "Vitamin A"
                cell.rightLabel.text = ""
                return cell
            }
            if indexPath.row == 1 {
                cell.leftLabel.text = "Vitamin C"
                cell.rightLabel.text = ""
                return cell
            }
            if indexPath.row == 2 {
                cell.leftLabel.text = "Calcium"
                cell.rightLabel.text = ""
                return cell
            }
            if indexPath.row == 3 {
                cell.leftLabel.text = "Iron"
                cell.rightLabel.text = ""
                return cell
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50//self.viewForHeaderInSection(section: section).frame.height + 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func viewForHeaderInSection(section:Int) -> UIView {
        let cell = tableView.dequeueReusableCell(withIdentifier: nutritionInfoHeaderTableCell) as! NutritionInfoHeaderTableCell
        
        cell.leftLabel.text = sectionArray[section]
        
        if section == 0 {
            cell.rightLabel.text = "Calories from Fat 230"
        }
        if section == 1 {
            cell.rightLabel.text = NutritionDetailsData.recipeNutritionixInfo?.nfCholesterol
            cell.rightLabel.textColor = .gray
        }

        if section == 2 {
            cell.rightLabel.text  = NutritionDetailsData.recipeNutritionixInfo?.nfTotalCarbohydrate
            cell.rightLabel.textColor = .gray
        }
        
        cell.leftLabelLeadingSpace.constant = 10
        
        return cell.contentView
    }
}


extension DetailedNutritionalInfoViewController {
    
    func NutritionalDetailApi()
    {
        let param:[String:Any] = ["recipe_id":recipeID]
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getRecipeNutritionixDetails, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.NutritionDetailsData = try JSONDecoder().decode(NutritionDetailsStruct.self, from: data)
                            self.tableView.reloadData()
                        }
                        catch
                        {
                            Alert.show(vc: self, titleStr: Alert.kTitle, messageStr: error.localizedDescription)
                        }
                    }
                    else
                    {
                        Alert.show(vc: self, titleStr: Alert.kTitle, messageStr: self.global_Var.get_status.message)
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: Alert.kTitle, messageStr: self.global_Var.get_status.message)
                }
                Loader.sharedInstance.hideIndicator()
                break
                
            case .failer(let error):
                
                Alert.show(vc: self, titleStr: Alert.kTitle, messageStr: error.localizedDescription)
                Loader.sharedInstance.hideIndicator()
                break
            }
        }
    }
}
