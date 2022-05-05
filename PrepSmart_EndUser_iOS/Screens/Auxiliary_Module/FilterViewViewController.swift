//
//  FilterViewViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 07/11/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  PSTMOBSTD030

import UIKit

protocol filterDelegate {
    func filterDelegateMethod(start_index:Int,type: Int,display_type:Int , record_count:Int, category_id:String, diet_type_ids:String, courses:String, tags:String, seasons:String, ingredient_ids:String)
}

class FilterViewViewController: BaseViewController {

    @IBOutlet var tableView_category: UITableView!
    @IBOutlet var tableView_subcategory: UITableView!
    @IBOutlet weak var btn_Apply            : UIButton!
    @IBOutlet weak var btn_ClearAll         : UIButton!
    var arr_title = ["Category","Tag","Recipe Type","Diet Type","Course","Season","Main  Ingredient"]
    var arr_subcategory = ["Lorem ipsum"]
    let shortListTableCell = "ShortListTableCell"
    var selectedCategoryIndex = IndexPath()
    var selectedSubCategoryIndex = IndexPath()
    var recepieFilterDataObj: RecipeFilterData_Struct?
    var global_Var = GlobalClass.sharedManager
    var myStuffObj : MyStuff_Struct?
    var delegate: filterDelegate? = nil
//    var categoryArr = [CategoryModel]()
//    var tagArr = [TagModel]()
//    var recipeTypeArr = [RecipeModel]()
//    var dietTypeArr = [DietTypeModel]()
//    var courseArr = [CourseModel]()
//    var seasonArr = [SeasonModel]()
//    var mainIngredientArr = [MainIngredientModel ]()
   
    var selectedCatIdArr = [String]()
    var selectedCatId = "0"
    var selectedTagArr = [String]()
    var selectedTagId = "0"
    var selectedRecipetypeArr = [String]()
    var selectedRecipetypeId = "0"
    var selectedDietTypeArr = [String]()
    var selectedDietTypeId = "0"
    var selectedCourseArr = [String]()
    var selectedCourseId = "0"
    var selectedSeasonArr = [String]()
    var selectedSeasonId = "0"
    var selectedMainIngredientArr = [String]()
    var selectedMainIngredientId = "0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedCategoryIndex = [0,0]
        // Do any additional setup after loading the view.
        self.initiolize()
    }
    
    func initiolize() {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Filter")
        
        self.tableView_category.register(UINib(nibName: shortListTableCell, bundle: nil), forCellReuseIdentifier: shortListTableCell)
        self.tableView_subcategory.register(UINib(nibName: shortListTableCell, bundle: nil), forCellReuseIdentifier: shortListTableCell)
       
        self.tableView_category.delegate = self
        self.tableView_category.dataSource = self
        self.tableView_subcategory.delegate = self
        self.tableView_subcategory.dataSource = self
        
        self.btn_Apply.layer.cornerRadius = self.btn_Apply.frame.height / 2
        self.btn_ClearAll.layer.cornerRadius = self.btn_ClearAll.frame.height / 2
        
        self.btn_ClearAll.layer.borderWidth = 0.50
        self.btn_ClearAll.layer.borderColor = UIColor.appOrangeColor().cgColor
        self.btn_Apply.addTarget(self, action: #selector(applyMethdo(sender:)), for: .touchUpInside)
        self.btn_ClearAll.addTarget(self, action: #selector(clearAllMethod(sender:)), for: .touchUpInside)
        self.recepirFilterDataApi()
    }
    
//    MARK: OnClick Action
    @IBAction func onClickFilterOptionButton(_ sender: UIButton) {
        
       
    
        
        var selectedMainIngredientArr = [String]()
        var selectedMainIngredientId = "0"
    }
    @objc func clearAllMethod(sender: UIButton)
    {
        for index in 0..<Int(recepieFilterDataObj?.category_list!.count ?? 0){
        self.recepieFilterDataObj?.category_list?[index].isSelected = false
        selectedCatIdArr.removeAll()
        self.selectedCatId = "0"
        }
        for index in 0..<Int(recepieFilterDataObj?.tag_list!.count ?? 0){
        self.recepieFilterDataObj?.tag_list?[index].isSelected = false
        selectedTagArr.removeAll()
        self.selectedTagId = "0"
        }
        for index in 0..<Int(recepieFilterDataObj?.recipe_type!.count ?? 0){
        self.recepieFilterDataObj?.recipe_type?[index].isSelected = false
        selectedRecipetypeArr.removeAll()
        self.selectedRecipetypeId = "0"
        }
        for index in 0..<Int(recepieFilterDataObj?.diet_type!.count ?? 0){
        self.recepieFilterDataObj?.diet_type?[index].isSelected = false
        selectedDietTypeArr.removeAll()
        self.selectedDietTypeId = "0"
        }
        for index in 0..<Int(recepieFilterDataObj?.courses!.count ?? 0){
        self.recepieFilterDataObj?.courses?[index].isSelected = false
        selectedCourseArr.removeAll()
        self.selectedCourseId = "0"
        }
        for index in 0..<Int(recepieFilterDataObj?.seasons!.count ?? 0){
        self.recepieFilterDataObj?.seasons?[index].isSelected = false
        selectedSeasonArr.removeAll()
        self.selectedSeasonId = "0"
        }
        for index in 0..<Int(recepieFilterDataObj?.main_ingredient!.count ?? 0){
        self.recepieFilterDataObj?.main_ingredient?[index].isSelected = false
            selectedMainIngredientArr.removeAll()
        self.selectedMainIngredientId = "0"
        }
        tableView_subcategory.reloadData()
        self.navigationController?.popViewController(animated: true)

    }
    
    @objc func applyMethdo(sender: UIButton)
    {
        delegate?.filterDelegateMethod(start_index: 0,
                                       type: 5,
                                       display_type: 1,
                                       record_count: 10,
                                       category_id: selectedCatId,
                                       diet_type_ids: selectedDietTypeId,
                                       courses: selectedCourseId,
                                       tags: selectedTagId,
                                       seasons: selectedSeasonId,
                                       ingredient_ids: selectedMainIngredientId)
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView_category
        {
            return arr_title.count
        }
        else
        {
            if self.selectedCategoryIndex == [0,0]
            {
                return self.recepieFilterDataObj?.category_list?.count ?? 0
            }
            else if selectedCategoryIndex == [0,1]
            {
                return self.recepieFilterDataObj?.tag_list?.count ?? 0
            }
            else if selectedCategoryIndex == [0,2]
            {
                return self.recepieFilterDataObj?.recipe_type?.count ?? 0
            }
            else if selectedCategoryIndex == [0,3]
            {
                return self.recepieFilterDataObj?.diet_type?.count ?? 0
            }
            else if selectedCategoryIndex == [0,4]
            {
                return self.recepieFilterDataObj?.courses?.count ?? 0
            }
            else if selectedCategoryIndex == [0,5]
            {
                return self.recepieFilterDataObj?.seasons?.count ?? 0
            }
            else if selectedCategoryIndex == [0,6]
            {
                return self.recepieFilterDataObj?.main_ingredient?.count ?? 0
            }
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableView_category
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: shortListTableCell, for: indexPath) as! ShortListTableCell
            
            cell.lbl_itemTitle.text = arr_title[indexPath.row]
            cell.sideImageView.image = UIImage(named: "")
            cell.lbl_border.isHidden = true
            if selectedCategoryIndex == indexPath
            {
                cell.view_main.backgroundColor = UIColor.appOrangeColor()
                cell.lbl_itemTitle.textColor = UIColor.white
            }
            else
            {
                cell.view_main.backgroundColor = UIColor.white
                cell.lbl_itemTitle.textColor = UIColor.appOrangeColor()
            }
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: shortListTableCell, for: indexPath) as! ShortListTableCell
            
            if self.selectedCategoryIndex.row == 0
            {
                let dic = self.recepieFilterDataObj?.category_list?[indexPath.row]
                cell.lbl_border.isHidden = false
                cell.lbl_itemTitle.text = dic?.cat_name
                if dic?.isSelected == true
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange")
                }
                else
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange_normal")
                }
            }
            else if selectedCategoryIndex.row == 1
            {
                let dic = self.recepieFilterDataObj?.tag_list?[indexPath.row]
                cell.lbl_border.isHidden = false
                cell.lbl_itemTitle.text = dic?.tag
                if dic?.isSelected == true
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange")
                }
                else
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange_normal")
                }
            }
            else if selectedCategoryIndex.row == 2
            {
                let dic = self.recepieFilterDataObj?.recipe_type?[indexPath.row]
                cell.lbl_border.isHidden = false
                cell.lbl_itemTitle.text = dic?.type
                if dic?.isSelected == true
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange")
                }
                else
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange_normal")
                }
            }
            else if selectedCategoryIndex.row == 3
            {
                let dic = self.recepieFilterDataObj?.diet_type?[indexPath.row]
                cell.lbl_border.isHidden = false
                cell.lbl_itemTitle.text = dic?.diet_type_name
                if dic?.isSelected == true
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange")
                }
                else
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange_normal")
                }
            }
            else if selectedCategoryIndex.row == 4
            {
                let dic = self.recepieFilterDataObj?.courses?[indexPath.row]
                cell.lbl_border.isHidden = false
                cell.lbl_itemTitle.text = dic?.course_type_name
                if dic?.isSelected == true
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange")
                }
                else
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange_normal")
                }
            }
            else if selectedCategoryIndex.row == 5
            {
                let dic = self.recepieFilterDataObj?.seasons?[indexPath.row]
                cell.lbl_border.isHidden = false
                cell.lbl_itemTitle.text = dic?.name
                if dic?.isSelected == true
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange")
                }
                else
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange_normal")
                }
            }
            else if selectedCategoryIndex.row == 6
            {
                let dic = self.recepieFilterDataObj?.main_ingredient?[indexPath.row]
                cell.lbl_border.isHidden = false
                cell.lbl_itemTitle.text = dic?.name
                if dic?.isSelected == true
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange")
                }
                else
                {
                    cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange_normal")
                }
            }
//            cell.lbl_border.isHidden = false
//            cell.lbl_itemTitle.text = "Lorem ipsum"
//            if selectedSubCategoryIndex == indexPath
//            {
//                cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange")
//            }
//            else
//            {
//                cell.sideImageView.image = #imageLiteral(resourceName: "check_mark_orange_normal")
//            }

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableView_category
        {
            selectedCategoryIndex = indexPath
            tableView_category.reloadData()
            tableView_subcategory.reloadData()
        }
        else
        {
            if selectedCategoryIndex.row == 0
            {
                
                if self.recepieFilterDataObj?.category_list?[indexPath.row].isSelected == true
                {
                    self.recepieFilterDataObj?.category_list?[indexPath.row].isSelected = false
                    selectedCatIdArr.remove(at: indexPath.row)
                    self.selectedCatId = selectedCatIdArr.joined(separator: ",")
                    
                }
                else
                {
                    self.recepieFilterDataObj?.category_list?[indexPath.row].isSelected = true
                    selectedCatIdArr.append(String(self.recepieFilterDataObj?.category_list?[indexPath.row].cat_id ?? 0))
                    self.selectedCatId = selectedCatIdArr.joined(separator: ",")
                    
                }
               
            }
            else if selectedCategoryIndex.row == 1
            {
                
                if self.recepieFilterDataObj?.tag_list?[indexPath.row].isSelected == true
                {
                    self.recepieFilterDataObj?.tag_list?[indexPath.row].isSelected = false
                    selectedTagArr.remove(at: indexPath.row)
                    self.selectedTagId = selectedTagArr.joined(separator: ",")
                }
                else
                {
                    self.recepieFilterDataObj?.tag_list?[indexPath.row].isSelected = true
                    selectedTagArr.append(String(self.recepieFilterDataObj?.category_list?[indexPath.row].cat_id ?? 0))
                    self.selectedTagId = selectedTagArr.joined(separator: ",")
                }
                
            }
            else if selectedCategoryIndex.row == 2
            {
                
                if self.recepieFilterDataObj?.recipe_type?[indexPath.row].isSelected == true
                {
                    self.recepieFilterDataObj?.recipe_type?[indexPath.row].isSelected = false
                    selectedRecipetypeArr.remove(at: indexPath.row)
                    self.selectedRecipetypeId = selectedRecipetypeArr.joined(separator: ",")
                }
                else
                {
                    self.recepieFilterDataObj?.recipe_type?[indexPath.row].isSelected = true
                    selectedRecipetypeArr.append(String(self.recepieFilterDataObj?.category_list?[indexPath.row].cat_id ?? 0))
                    self.selectedRecipetypeId = selectedRecipetypeArr.joined(separator: ",")
                }
                
            }
            else if selectedCategoryIndex.row == 3
            {
                
                if self.recepieFilterDataObj?.diet_type?[indexPath.row].isSelected == true
                {
                    self.recepieFilterDataObj?.diet_type?[indexPath.row].isSelected = false
                    selectedDietTypeArr.remove(at: indexPath.row)
                    self.selectedDietTypeId = selectedDietTypeArr.joined(separator: ",")
                }
                else
                {
                    self.recepieFilterDataObj?.diet_type?[indexPath.row].isSelected = true
                    selectedDietTypeArr.append(String(self.recepieFilterDataObj?.category_list?[indexPath.row].cat_id ?? 0))
                    self.selectedDietTypeId = selectedDietTypeArr.joined(separator: ",")
                }
                
            }
            else if selectedCategoryIndex.row == 4
            {
                
                if self.recepieFilterDataObj?.courses?[indexPath.row].isSelected == true
                {
                    self.recepieFilterDataObj?.courses?[indexPath.row].isSelected = false
                    selectedCourseArr.remove(at: indexPath.row)
                    self.selectedCourseId = selectedCourseArr.joined(separator: ",")
                }
                else
                {
                    self.recepieFilterDataObj?.courses?[indexPath.row].isSelected = true
                    selectedCourseArr.append(String(self.recepieFilterDataObj?.category_list?[indexPath.row].cat_id ?? 0))
                    self.selectedCourseId = selectedCourseArr.joined(separator: ",")
                }
                
            }
            else if selectedCategoryIndex.row == 5
            {
                
                if self.recepieFilterDataObj?.seasons?[indexPath.row].isSelected == true
                {
                    self.recepieFilterDataObj?.seasons?[indexPath.row].isSelected = false
                    selectedSeasonArr.remove(at: indexPath.row)
                    self.selectedSeasonId = selectedSeasonArr.joined(separator: ",")
                }
                else
                {
                    self.recepieFilterDataObj?.seasons?[indexPath.row].isSelected = true
                    selectedSeasonArr.append(String(self.recepieFilterDataObj?.category_list?[indexPath.row].cat_id ?? 0))
                    self.selectedSeasonId = selectedSeasonArr.joined(separator: ",")
                }
                
            }
            else if selectedCategoryIndex.row == 6
            {
                
                if self.recepieFilterDataObj?.main_ingredient?[indexPath.row].isSelected == true
                {
                    self.recepieFilterDataObj?.main_ingredient?[indexPath.row].isSelected = false
                    selectedMainIngredientArr.remove(at: indexPath.row)
                    self.selectedMainIngredientId = selectedMainIngredientArr.joined(separator: ",")
                }
                else
                {
                    self.recepieFilterDataObj?.main_ingredient?[indexPath.row].isSelected = true
                    selectedMainIngredientArr.append(String(self.recepieFilterDataObj?.category_list?[indexPath.row].cat_id ?? 0))
                    self.selectedMainIngredientId = selectedMainIngredientArr.joined(separator: ",")
                }
                
            }
            
            selectedSubCategoryIndex = indexPath
            tableView_subcategory.reloadData()
        }
    }
 
}
 
extension FilterViewViewController
{
    func recepirFilterDataApi()
     {
         let param:[String:Any] = ["type": "1"]
                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.recipeFilterData, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.recepieFilterDataObj = try JSONDecoder().decode(RecipeFilterData_Struct.self, from: data)
                             self.tableView_category.reloadData()
                             self.tableView_subcategory.reloadData()
                           
                         }
                         catch
                         {
                             Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                         }
                     }
                     else
                     {
                         Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: self.global_Var.get_status.message)
                     }
                 }
                 else
                 {
                     Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: self.global_Var.get_status.message)
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
