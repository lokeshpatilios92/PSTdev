//
//  CookListViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 12/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID:-  PSTMOBSTD061, PSTMOBSTD060 , PSTMOBSTD064

import UIKit
import Popover

class CookListViewController : BaseViewController,CustomCookScreenPopUpDelegate {
    
    @IBOutlet weak var weekDateColletionView: UICollectionView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    var cookListObj: CookList_Struct?
    var global_Var = GlobalClass.sharedManager
    
    let weeklyPlanTitleTableViewCell = "WeeklyPlanTitleTableViewCell"
    let cookingListTableCell = "CookingListTableCell"
    let weekDateColletionCell = "WeekDateCollectionViewCell"
    
    var isExpandable : [Bool] = [false,false,false,false,false]
    
    let sectionImageArray = [#imageLiteral(resourceName: "breakfast_white"),#imageLiteral(resourceName: "lunch_white"),#imageLiteral(resourceName: "snacks_white"),#imageLiteral(resourceName: "dinner_white"),#imageLiteral(resourceName: "snacks_white")]
    
    let sectionTitleArray = ["Breakfast (1 of 2 complete)","Lunch (0 of 2 complete)","Snacks (3 of 5 complete)","Dinner (3 of 5 complete)","Other (3 of 5 complete)"]
    
    var startDateStr = ""
    var endDateStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func initialize(){
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "info"), style: .done, target: self, action: #selector(infoButtonMethod(sender:)))
        self.showCookScreenPopUpVC(customDelegate: self)
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Cook List")
        self.navigationController?.navigationItem.rightBarButtonItems = [addInfoButton()]
        tableView.register(UINib.init(nibName: cookingListTableCell, bundle: nil), forCellReuseIdentifier: cookingListTableCell)
        tableView.register(UINib.init(nibName: weeklyPlanTitleTableViewCell, bundle: nil), forCellReuseIdentifier: weeklyPlanTitleTableViewCell)
        weekDateColletionView.register(UINib(nibName: weekDateColletionCell, bundle: nil), forCellWithReuseIdentifier: weekDateColletionCell)
        self.currentWeekDatesMethod()
        self.getCookListApi(startDate: self.startDateStr, endDate: self.endDateStr)
        
       
        
    }
    
    @objc func infoButtonMethod(sender: UIButton)
    {

        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: aView.frame.width - 40, height: 300))
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.font = UIFont.REGULAR_FONT_SMALLEST()
        infoLabel.textColor = .textColor()
        infoLabel.text = "Info is displayed once updated by client Learn More"
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
        popover.show(aView, fromView: infoButton)
        
    }    
//    override func viewWillAppear(_ animated: Bool) {
//        showCookScreenPopUpVC(customDelegate : self)
//    }
//
    @IBAction func openKitchenBtn(_ sender: UIButton) {
        let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "KitchenViewController") as! KitchenViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK:- Delegate Function
    func onClickOkButton() {
        //perform action on ok button
//        self.removeAnimation()
    }
    
    //MARK: OnClick Func
    @objc func onClickToggleButton(sender:UIButton) {
        isExpandable[sender.tag] = !isExpandable[sender.tag]
        tableView.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
//        self.constraintTblViewHT.constant = self.tblview_mealTimings.contentSize.height
    }
    
    @IBAction func onClickCalendarButton(_ sender: UIButton)
    {
        self.showSelectDateRangeVC(btn_text: "Select", customDelegate: self)
    }
    
    @IBAction func onClickExpandButton(_ sender: UIButton)
    {
        if sender.tag == 0
        {
            expandButton.setImage(#imageLiteral(resourceName: "shaort_one"), for: .normal)
            for n in 0...4
            {
                isExpandable[n] = true
            }
            tableView.reloadData()
            sender.tag = 1
        }
        else
        {
            expandButton.setImage(#imageLiteral(resourceName: "shaort_close"), for: .normal)
            for  n in 0...4
            {
                isExpandable[n] = false
            }
            tableView.reloadData()
            sender.tag = 0
        }
       
    }
}

extension CookListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isExpandable.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if isExpandable[section]{
                return self.cookListObj?.cooklist_details?.days?[self.weekDateColletionView.tag].meal_list?[section].recipe_list?.count ?? 0
            }
        case 1:
            if isExpandable[section]{
                return self.cookListObj?.cooklist_details?.days?[self.weekDateColletionView.tag].meal_list?[section].recipe_list?.count ?? 0
            }
        case 2:
            if isExpandable[section]{
                return self.cookListObj?.cooklist_details?.days?[self.weekDateColletionView.tag].meal_list?[section].recipe_list?.count ?? 0
            }
        case 3:
            if isExpandable[section] {
                return self.cookListObj?.cooklist_details?.days?[self.weekDateColletionView.tag].meal_list?[section].recipe_list?.count ?? 0
            }
        case 4:
            if isExpandable[section] {
                return self.cookListObj?.cooklist_details?.days?[self.weekDateColletionView.tag].meal_list?[section].recipe_list?.count ?? 0
            }
        default:
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cookingListTableCell, for: indexPath) as! CookingListTableCell
        
        print("indexPath.section = \(indexPath.section)")
        print("indexPath.row = \(indexPath.row)")
        print("collectionTag = \(self.weekDateColletionView.tag)")
        
            if let dic = self.cookListObj?.cooklist_details?.days?[self.weekDateColletionView.tag].meal_list?[indexPath.section].recipe_list?[indexPath.row]
            {
                cell.recipeImage.sd_setImage(with: URL(string: dic.recipe_img ?? ""), placeholderImage: UIImage(named: "dinner"))
                cell.titleLabel.text = dic.recipe_name
                cell.servingSizeLabel.text = "Srtving Size : \(String(describing: dic.total_servings ?? ""))"
                let cookTime = String(dic.cooking_time ?? 0)
                cell.cookingTimeLabel.text = "Cooking Time : \(cookTime)"
            }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: weeklyPlanTitleTableViewCell) as! WeeklyPlanTitleTableViewCell
        let dic = self.cookListObj?.cooklist_details?.days?[self.weekDateColletionView.tag].meal_list?[section]
        cell.contentView.backgroundColor = .groupTableViewBackground
        cell.btn_header.tag = section
        cell.arraowImageView.image = #imageLiteral(resourceName: "drop_arrow_white")
        cell.lbl_title.text = "\(dic?.meal_name ?? "") (\(dic?.recipe_list?.count ?? 0))"
        cell.imgView_mealTime.image = sectionImageArray[section]
        cell.btn_header.addTarget(self, action: #selector(self.onClickToggleButton(sender:)), for: .touchUpInside)
        
        
        if isExpandable[section]
        {
            cell.arraowImageView.image = #imageLiteral(resourceName: "up_arrow_white")
        }
        else
        {
            cell.arraowImageView.image = #imageLiteral(resourceName: "drop_arrow_white")
        }
        
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .groupTableViewBackground
        return view
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "CookListIngredients_InstructionVC") as! CookListIngredients_InstructionVC
        vc.recipeListObj = self.cookListObj?.cooklist_details?.days?[self.weekDateColletionView.tag].meal_list?[indexPath.section].recipe_list?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CookListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weekDateColletionCell, for: indexPath)as! WeekDateCollectionViewCell
        let dic = self.cookListObj?.cooklist_details?.days?[indexPath.row]
        cell.dayLabel.text = dic?.day_name
        cell.dateLabel.text = dic?.day_date

//        if indexPath.row == 0{
//            cell.backView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
//        }
//        else
//        {
//            cell.backView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.30)
//        }
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80.0 , height: 50.0)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! WeekDateCollectionViewCell
        
        cell.backView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
        self.weekDateColletionView.tag = indexPath.row
        self.tableView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! WeekDateCollectionViewCell
        cell.backView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.30)
    }
}

extension CookListViewController
{
    func getCookListApi(startDate: String?, endDate: String?)
     {
         
         let param:[String:Any] = ["start_date":startDate ?? "", "end_date":endDate ?? ""]
         //let param:[String:Any] = ["start_date":"24-01-2022", "end_date":"30-01-2022"]

                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getCookList, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                                         Loader.sharedInstance.hideIndicator()
                         do {
                             self.cookListObj = try JSONDecoder().decode(CookList_Struct.self, from: data)
                            
                             self.weekDateColletionView.reloadData()
                             self.tableView.reloadData()
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
extension CookListViewController :  CustomSelectDateRangeVCDelegate {
    func onClickSelectButtonAction(startDate: String?, endDate: String?, startDay: String?, endDay: String?) {
        print ("start date = \(startDate)")
        print("end date = \(endDate)")
       
            getCookListApi(startDate: startDate, endDate: endDate)
        
    }
    
   
    
    
    
    
}
extension CookListViewController
{
    func currentWeekDatesMethod()
    {
        let now = convertDateToLocalTime(Date())

        let startWeek = convertDateToLocalTime(now.startOfWeek!)
        let endWeek = convertDateToLocalTime(now.endOfWeek!)

        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
    
        self.startDateStr = formatter.string(from: startWeek)
        self.endDateStr = formatter.string(from: endWeek)
        
        print("Local time is: \(now)")
        print("Start of week is: \(self.startDateStr)")
        print("End of week is: \(self.endDateStr)")
        
        
    }
    
    func convertDateToLocalTime(_ date: Date) -> Date {
            let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: date))
            return Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: date)!
    }

}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .indian)
        guard let startDay = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: startDay)
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .indian)
            guard let startDay = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
           return gregorian.date(byAdding: .day, value: 7, to: startDay)
       }
}


