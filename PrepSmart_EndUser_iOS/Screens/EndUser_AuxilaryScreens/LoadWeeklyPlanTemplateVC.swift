//
//  LoadWeeklyPlanTemplateVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 10/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class LoadWeeklyPlanTemplateVC: BaseViewController,DataEnteredDelegate{
    
    var global_Var = GlobalClass.sharedManager
    var downloadWeeklyPlanObj = GetWeeklyPlan_Struct()
    var updateOrCreateWeeklyPlanObj = Get_Status()
    var dateWiseWeeklyPlanObj : DateWiseWeeklyPlan_Struct?
    var myStuffObj : MyStuff_Struct?
    var weeklyPlanArr = [""]
    
    var filteredMealList: [(meal: MealListData?, isExpandable: Bool)]?
    private var selectedDay: Daydata?
    
    var isExpandable : [Bool] = [false,false,false,false,false]
    
    @IBOutlet var okBtn: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var clearAllBtn: UIButton!
    @IBOutlet var doneBtn: UIButton!
    @IBOutlet var loadWeeklyPlanTemplateBtn: UIButton!
    @IBOutlet weak var dateBackView: NSLayoutConstraint!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var toDateLabel: UILabel!
    
    @IBOutlet weak var mondayDateLabel: UILabel!
    @IBOutlet weak var tuesdayDateLabel: UILabel!
    @IBOutlet weak var wednesdayDateLabel: UILabel!
    @IBOutlet weak var thrusdayDateLabel: UILabel!
    @IBOutlet weak var fridayDateLabel: UILabel!
    @IBOutlet weak var saturdayDateLabel: UILabel!
    @IBOutlet weak var sundayDateLabel: UILabel!
    
    @IBOutlet weak var mondayView: UIView!
    @IBOutlet weak var tuesdayView: UIView!
    @IBOutlet weak var wednesdayView: UIView!
    @IBOutlet weak var thrusdayView: UIView!
    @IBOutlet weak var fridayView: UIView!
    @IBOutlet weak var saturdayView: UIView!
    @IBOutlet weak var sundayView: UIView!
    
    var clearDoneTag = 0
    var useAddRecipeBtnCell = 0
    
    var fromDate = Date()
    var toDate = Date()
    
    let loadWeeklyPlanCell = "LoadWeeklyPlanCell"
    let progressContainerCell = "ProgressContainerCell"
    let addRecipeBtnCell = "AddRecipeBtnCell"
    let addRecipeAdvanceUserBtnCell = "AddRecipeAdvanceUserBtnCell"
    let weeklyPlanTitleTableViewCell = "WeeklyPlanTitleTableViewCell"
    
    var brakfastArr = ["Cheesy Amish Breakfast Casserole","Cheesy Amish Breakfast Casserole","Cheesy Amish Breakfast Casserole","Cheesy Amish Breakfast Casserole"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
        
        self.showAlertWithOkButtonPopUpVC(setTitle: "PrepSmart Tip:", setMessage: "Try not to over scheduleyour week plan on making some leftovers or adding a new extra item to your shoping list to makeup the other meals.", setButtonTitle: "Ok", customDelegate: nil)
        
    }
    
    func initializer(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Weekly Plan")
        
        dateBackView.constant = 0
        let addBlogsNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "download_white_icon"), style: .done, target: self, action: #selector(self.downloadTapped))
        let addSaveOptionsButton = UIBarButtonItem(image: UIImage(named: "export"), style: .done, target: self, action: #selector(self.saveOptionsTapped))
        self.navigationItem.rightBarButtonItems = [addSaveOptionsButton,addBlogsNavButton,addNewWeelyPlanNavButton()]
        
        tableView.register(UINib.init(nibName: weeklyPlanTitleTableViewCell, bundle: nil), forCellReuseIdentifier: weeklyPlanTitleTableViewCell)
        tableView.register(UINib(nibName: loadWeeklyPlanCell, bundle: .none), forCellReuseIdentifier: loadWeeklyPlanCell)
        tableView.register(UINib(nibName: progressContainerCell, bundle: .none), forCellReuseIdentifier: progressContainerCell)
        tableView.register(UINib(nibName: addRecipeBtnCell, bundle: .none), forCellReuseIdentifier: addRecipeBtnCell)
        tableView.register(UINib(nibName: addRecipeAdvanceUserBtnCell, bundle: .none), forCellReuseIdentifier: addRecipeAdvanceUserBtnCell)
        
        clearAllBtn.layer.cornerRadius = clearAllBtn.frame.height/2
        clearAllBtn.layer.borderColor = UIColor.appOrangeColor().cgColor
        clearAllBtn.layer.borderWidth = 1.0
        doneBtn.layer.cornerRadius = doneBtn.frame.height/2
        loadWeeklyPlanTemplateBtn.layer.cornerRadius = loadWeeklyPlanTemplateBtn.frame.height/2
        okBtn.layer.cornerRadius = okBtn.frame.height/2
       
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(LoadWeeklyPlanTemplateVC.longPressGestureRecognized(_:)))
        tableView.addGestureRecognizer(longpress)
        
        print(self.isExpandable)
        
        
        
        fromDate = Date.today().previous(.monday, considerToday: true)
        toDate = Date.today().next(.sunday, considerToday: true)
        
        fromDateLabel.text = DateToString(date: fromDate, formate: "MMM d")
        toDateLabel.text = DateToString(date: toDate, formate: "MMM d")
        
        self.getDateWiseWeeklyPlanDetailsApi()
    }
    
    func setupDaysData() {
        self.mondayDateLabel.text = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?.first(where: { $0.dayName == "Monday" })?.dayDate
        self.tuesdayDateLabel.text = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?.first(where: { $0.dayName == "Tuesday" })?.dayDate
        self.wednesdayDateLabel.text = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?.first(where: { $0.dayName == "Wednesday" })?.dayDate
        self.thrusdayDateLabel.text = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?.first(where: { $0.dayName == "Thursday" })?.dayDate
        self.fridayDateLabel.text = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?.first(where: { $0.dayName == "Friday" })?.dayDate
        self.saturdayDateLabel.text = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?.first(where: { $0.dayName == "Saturday" })?.dayDate
        self.sundayDateLabel.text = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?.first(where: { $0.dayName == "Sunday" })?.dayDate
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let mode = UserDefaults.standard.value(forKey: "mode") as? Int{
            if mode == 1{
                let vc = UIStoryboard.DashboardStoryboard.instantiateViewController(withIdentifier : "AdvancedModeWeeklyPlanVC") as! AdvancedModeWeeklyPlanVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                //Do Nothing
            }
        }
    }
    
    @IBAction func onClickloadWeeklyPlanTemplate(_ sender: UIButton) {
        self.showAlertLoadPlanTempletVC()
    }
    
    func sendFlag(info: Int) {
        dateBackView.constant = 160
        useAddRecipeBtnCell = 1
    }
    
    func didDataAddedToList(at indexPath: IndexPath?, receipes: [Recipes]) {
        guard let indexPath = indexPath else { return }
        for receipe in receipes {
            var receipeList = RecipeListWeeklyPlan()
            receipeList.recipeID = receipe.recipe_id
            receipeList.recipeImg = receipe.recipe_image
            receipeList.recipeName = receipe.recipe_name
            receipeList.proteinsValue = receipe.protein
            filteredMealList?[indexPath.section].meal?.recipeList?.append(receipeList)
        }
        
        tableView.reloadData()
    }
    
    
    @IBAction func clearAllBtnTapped(_ sender: UIButton) {
        self.clearDoneTag = 1
        self.showLogOutPopUp(leftBtnTitle: "Cancel", rightBtnTitle: "Proceed", lblText: "Are you sure you want to start over with a new weekly plan? This will clear out all recipes in the current weekly plan and will also reset your shopping list and cook list.", isLogOut: false, customDelegate: self)
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        // SaveOptionsPopUpVC(customDelegate : self)
        //THis is not for logout
        self.clearDoneTag = 2
        self.showLogOutPopUp(leftBtnTitle: "Don't Save", rightBtnTitle: "Save", lblText: "You may have changes that won't be saved. Are you sure you want to leave without saving?.", isLogOut: false, customDelegate: self)
    }
    
    @IBAction func previousWeekButtonAction(_ sender: UIButton) {
        fromDate = fromDate.previous(.monday, considerToday: false)
        toDate = fromDate.next(.sunday, considerToday: false)
        
        fromDateLabel.text = DateToString(date: fromDate, formate: "MMM d")
        toDateLabel.text = DateToString(date: toDate, formate: "MMM d")
        getDateWiseWeeklyPlanDetailsApi()
    }
    
    @IBAction func nextWeekButtonAction(_ sender: UIButton) {
        fromDate = fromDate.next(.monday, considerToday: false)
        toDate = fromDate.next(.sunday, considerToday: false)
        
        fromDateLabel.text = DateToString(date: fromDate, formate: "MMM d")
        toDateLabel.text = DateToString(date: toDate, formate: "MMM d")
        getDateWiseWeeklyPlanDetailsApi()
    }
    
    @IBAction func btnMondayAction(_ sender: UIButton) {
        mondayView.backgroundColor = .appOrangeColor()
        tuesdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        wednesdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        thrusdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        fridayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        saturdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        sundayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        self.fiterDataAccordingToDay("Monday")
    }
    
    @IBAction func btnTuesdayAction(_ sender: UIButton) {
        mondayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        tuesdayView.backgroundColor = .appOrangeColor()
        wednesdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        thrusdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        fridayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        saturdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        sundayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        self.fiterDataAccordingToDay("Tuesday")
    }
    
    @IBAction func btnWednesdayAction(_ sender: UIButton) {
        mondayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        tuesdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        wednesdayView.backgroundColor = .appOrangeColor()
        thrusdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        fridayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        saturdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        sundayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        self.fiterDataAccordingToDay("Wednesday")
    }
    
    @IBAction func btnThrusdayAction(_ sender: UIButton) {
        mondayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        tuesdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        wednesdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        thrusdayView.backgroundColor = .appOrangeColor()
        fridayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        saturdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        sundayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        self.fiterDataAccordingToDay("Thursday")
    }
    
    @IBAction func btnFridayAction(_ sender: UIButton) {
        mondayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        tuesdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        wednesdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        thrusdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        fridayView.backgroundColor = .appOrangeColor()
        saturdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        sundayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        self.fiterDataAccordingToDay("Friday")
    }
    
    @IBAction func btnSaturdayAction(_ sender: UIButton) {
        mondayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        tuesdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        wednesdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        thrusdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        fridayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        saturdayView.backgroundColor = .appOrangeColor()
        sundayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        self.fiterDataAccordingToDay("Saturday")
    }
    
    @IBAction func btnSundayAction(_ sender: UIButton) {
        mondayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        tuesdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        wednesdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        thrusdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        fridayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        saturdayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
        sundayView.backgroundColor = .appOrangeColor()
        self.fiterDataAccordingToDay("Sunday")
    }
    
    func fiterDataAccordingToDay(_ day: String) {
        filteredMealList?.removeAll()
        self.selectedDay = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?.first(where: { $0.dayName == day })
        let mondayMealList = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?.first(where: { $0.dayName == day })?.mealList
        
        self.filteredMealList = mondayMealList?.map({ (meal) -> (meal: MealListData?, isExpandable: Bool) in
             (meal: meal, isExpandable: false)
        })
        
        self.tableView.reloadData()
    }
    
    
    @IBAction func okBtnTapped(_ sender: UIButton) {
        dateBackView.constant = 160
    }
    
    @objc func downloadTapped()
    {
        let lastMondayDate = DateToStringYYMMDD(date: Date.today().previous(.monday, considerToday: true))
        let nextSundayDate = DateToStringYYMMDD(date: Date.today().next(.sunday, considerToday: true))
        
        self.downloadWeeklyPlanApi(StartDate:lastMondayDate , EndDate: nextSundayDate)
    }
    
    @objc func saveOptionsTapped() {
        myStuffApi()
    }
    
    @objc func addTapped(sender: UIButton){
        let cell = sender.superview?.superview?.superview as? LoadWeeklyPlanCell
//        let indexPath = IndexPath(row: sender.tag, section: 0)
//        let cell = tableView.cellForRow(at: indexPath) as! LoadWeeklyPlanCell
        let totalCount = Int(cell?.servingsCountLbl.text! ?? "0")! + 1
        cell?.servingsCountLbl.text = "\(totalCount)"
    }
    
    @objc func subtractTapped(sender: UIButton){
        let cell = sender.superview?.superview?.superview as? LoadWeeklyPlanCell
//        let indexPath = IndexPath(row: sender.tag, section: 0)
//        let cell = tableView.cellForRow(at: indexPath) as! LoadWeeklyPlanCell
        let totalCount = Int(cell?.servingsCountLbl.text! ?? "0")! - 1
        if totalCount <= 0{
            print("don't subtract it.")
        }else{
            cell?.servingsCountLbl.text = "\(totalCount)"
        }
        
    }
    
    //MARK: OnClick Func
    
    @objc func onClickToggleButton(sender:UIButton) {
        let isExpandableCell = filteredMealList?[sender.tag].isExpandable ??  false
        filteredMealList?[sender.tag].isExpandable = !isExpandableCell
        isExpandable[sender.tag] = !isExpandable[sender.tag]
        tableView.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
        
    }
    
    //addRecipeTapped
    @objc func addRecipeTapped(sender: UIButton) {
        guard let cell = sender.superview?.superview?.superview?.superview as? AddRecipeAdvanceUserBtnCell else { return }
        let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AddRecipesToRecipePackViewController") as! AddRecipesToRecipePackViewController
        //        let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "AddRecipeViewController") as! AddRecipeViewController
        vc.indexPath = tableView.indexPath(for: cell)
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func deleteTapped(sender: UIButton){
        print("delete tapped")
    }
    
    @objc func longPressGestureRecognized(_ gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: locationInView)
        
        switch state {
        case UIGestureRecognizer.State.began:
            if indexPath != nil {
                Path.initialIndexPath = indexPath
                let cell = tableView.cellForRow(at: indexPath!) as? LoadWeeklyPlanCell
                My.cellSnapshot  = snapshotOfCell(cell!)
                var center = cell?.center
                My.cellSnapshot!.center = center!
                My.cellSnapshot!.alpha = 0.0
                tableView.addSubview(My.cellSnapshot!)
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    center?.y = locationInView.y
                    My.cellIsAnimating = true
                    My.cellSnapshot!.center = center!
                    My.cellSnapshot!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    My.cellSnapshot!.alpha = 0.98
                    cell?.alpha = 0.0
                }, completion: { (finished) -> Void in
                    if finished {
                        My.cellIsAnimating = false
                        if My.cellNeedToShow {
                            My.cellNeedToShow = false
                            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                                cell?.alpha = 1
                            })
                        } else {
                            cell?.isHidden = true
                        }
                    }
                })
            }
        case UIGestureRecognizer.State.changed:
            if My.cellSnapshot != nil {
                var center = My.cellSnapshot!.center
                center.y = locationInView.y
                My.cellSnapshot!.center = center
                if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                    brakfastArr.insert(brakfastArr.remove(at: Path.initialIndexPath!.row), at: indexPath!.row)
                    tableView.moveRow(at: Path.initialIndexPath!, to: indexPath!)
                    Path.initialIndexPath = indexPath
                    
                }
                
            }
        default:
            if Path.initialIndexPath != nil {
                let cell = tableView.cellForRow(at: Path.initialIndexPath!) as? LoadWeeklyPlanCell
                if My.cellIsAnimating {
                    My.cellNeedToShow = true
                } else {
                    cell?.isHidden = false
                    cell?.alpha = 0.0
                }
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    My.cellSnapshot!.center = (cell?.center)!
                    My.cellSnapshot!.transform = CGAffineTransform.identity
                    My.cellSnapshot!.alpha = 0.0
                    cell?.alpha = 1.0
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        My.cellSnapshot!.removeFromSuperview()
                        My.cellSnapshot = nil
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }
    
    
    func snapshotOfCell(_ inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
    @objc func showNutritionInfo()
    {
        let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "DetailedNutritionalInfoViewController") as! DetailedNutritionalInfoViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
@available(iOS 13.0, *)
extension LoadWeeklyPlanTemplateVC : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        filteredMealList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let filteredData = filteredMealList?[section], filteredData.isExpandable else { return 0 }
        return (filteredData.meal?.recipeList?.count ?? 0) + 1
        
//        switch section {
//        case 0:
//            if isExpandable[section]{
//                return filteredMealList?[section].recipeList?.count ?? 0
//            }
//        case 1:
//            if isExpandable[section]{
//                return 2
//            }
//        case 2:
//            if isExpandable[section]{
//                return 4
//            }
//        case 3:
//            if isExpandable[section] {
//                return 3
//            }
//        case 4:
//            if isExpandable[section] {
//                return 1
//            }
//        default:
//            return 0
//        }
//        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("indexpath = \(indexPath)")
        print("indexpath.section = \(indexPath.section)")
        let receipeCount = filteredMealList?[indexPath.section].meal?.recipeList?.count ?? 0
        if indexPath.row == receipeCount  {
            let cell = tableView.dequeueReusableCell(withIdentifier: addRecipeAdvanceUserBtnCell, for: indexPath) as! AddRecipeAdvanceUserBtnCell
            cell.btn_AddRecipes.tag = indexPath.row
            cell.btn_AddRecipes.addTarget(self, action: #selector(addRecipeTapped), for: .touchUpInside)
            cell.btn_showNutritionDetails.addTarget(self, action: #selector(showNutritionInfo), for: .touchUpInside)
            return cell
            
//            if useAddRecipeBtnCell == 0{
//                let cell = tableView.dequeueReusableCell(withIdentifier: addRecipeBtnCell, for: indexPath) as! AddRecipeBtnCell
//                cell.addRecipeBtn.tag = indexPath.row
//                cell.addRecipeBtn.addTarget(self, action: #selector(addRecipeTapped), for: .touchUpInside)
//                return cell
//            } else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: addRecipeAdvanceUserBtnCell, for: indexPath) as! AddRecipeAdvanceUserBtnCell
//                cell.btn_AddRecipes.tag = indexPath.row
//                cell.btn_AddRecipes.addTarget(self, action: #selector(addRecipeTapped), for: .touchUpInside)
//                cell.btn_showNutritionDetails.addTarget(self, action: #selector(showNutritionInfo), for: .touchUpInside)
//                return cell
//            }
            
        } else if indexPath.row == brakfastArr.count + 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: progressContainerCell, for: indexPath) as! ProgressContainerCell
            cell.lockBtn.isHidden = false
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: loadWeeklyPlanCell, for: indexPath) as! LoadWeeklyPlanCell
            
            let receipe = filteredMealList?[indexPath.section].meal?.recipeList?[indexPath.row]
            
            cell.addBtn.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
            cell.subtractBtn.addTarget(self, action: #selector(subtractTapped), for: .touchUpInside)
            cell.deleteBtn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
            cell.addBtn.tag = indexPath.row
            cell.subtractBtn.tag = indexPath.row
            cell.deleteBtn.tag = indexPath.row
            
            cell.recipeTitleLbl.text = receipe?.recipeName
            cell.vitaminLbl.text = "\(receipe?.calorificValue ?? "0") CALS. \(receipe?.proteinsValue ?? 0)). \(receipe?.carbsValue ?? 0)C \(receipe?.fatValue ?? 0)F."
            
            if indexPath.row == brakfastArr.count{
                cell.separatorView.isHidden = true
            }
            return cell
        }
        
        
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 10))
    //        view.backgroundColor = .groupTableViewBackground
    //        return view
    //    }
    //
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 20
    //    }
    //
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 20
    //    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: weeklyPlanTitleTableViewCell) as! WeeklyPlanTitleTableViewCell
        let dic = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?[section].mealList?[section]
        cell.contentView.backgroundColor = .groupTableViewBackground
        cell.btn_header.tag = section
        cell.arraowImageView.image = #imageLiteral(resourceName: "drop_arrow_white")
        cell.lbl_title.text = dic?.mealName?.rawValue
        //+cell.imgView_mealTime.image = sectionImageArray[section]
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
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? ProgressContainerCell else {
            print("cell is not found")
            
            return
        }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
@available(iOS 13.0, *)
extension LoadWeeklyPlanTemplateVC : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressViewCell", for: indexPath) as! ProgressViewCell
        return cell
    }
    
    
}
@available(iOS 13.0, *)
extension LoadWeeklyPlanTemplateVC : UnsubscribeRecipePopUpVCDelegate {
    func onClcikRightButton() {
        // clearDoneTag = 1 means clear button tapped & clearDoneTag = 1 means done button tapped
        if self.clearDoneTag == 1
        {
            self.clearWeeklyPlanRecipeApi()
        }
        else
        {
            self.addReceipeAPI()
        }
        
    }
    
    
    
}

extension LoadWeeklyPlanTemplateVC : SaveOptionsPopUpVCDelegate {
    
    func onClcikSubmitBtn() {
        self.updateOrCreate_WeeklyPlanTemplate_Api()
    }
    
    func SaveOptionsPopUpVC1(customDelegate : SaveOptionsPopUpVCDelegate?) {
        let vc = UIStoryboard.Alert_Module.instantiateViewController(withIdentifier: "SaveOptionsPopUpVC") as! SaveOptionsPopUpVC
        vc.customDelegate = customDelegate
        vc.weeklyPlanArr = self.weeklyPlanArr
        vc.view.frame = self.view.bounds;
        vc.willMove(toParent: self)
        self.view.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
}


extension LoadWeeklyPlanTemplateVC
{
    func myStuffApi()
    {
        let param:[String:Any] = ["start_index":"0",
                                  "type": "3",
                                  "display_type":"2",
                                  "record_count":"100"]
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.myStuff, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.myStuffObj = try JSONDecoder().decode(MyStuff_Struct.self, from: data)
                            for i in self.myStuffObj?.recipeList ?? []
                            {
                                self.weeklyPlanArr.append(i.item_title ?? "")
                            }
                            
                            self.SaveOptionsPopUpVC1(customDelegate : self)
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
    
    func addReceipeAPI() {
        let strFrom = DateToStringYYMMDD(date: fromDate)
        let strTo = DateToStringYYMMDD(date: toDate)
        
        let planData = [["dayId": selectedDay?.dayID ?? 0, "meals": mealsData]] as [[String : Any]]
        let param = ["weekly_plan_id": self.dateWiseWeeklyPlanObj?.weeklyPlanID ?? 0 , "plan_data": planData, "start_date": strFrom,                                         "end_date":strTo] as [String : Any]
        
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.addWeekPlanStep2, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.downloadWeeklyPlanObj = try JSONDecoder().decode(GetWeeklyPlan_Struct.self, from: data)
//                            DispatchQueue.main.async { [self] in
//                                savePdf(urlString: self.downloadWeeklyPlanObj.pdf_path, fileName: "\(StartDate)to\(EndDate)")
//                            }
                        }
                        catch( let error ){
                            print(error)
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
    
    var mealsData: [[String: Any]] {
        guard let mealList = selectedDay?.mealList else {  return [[:]] }
        var mealData = [[String: Any]]()
        for meal in mealList {
            let recipes = meal.recipeList?.map({ (recipe) -> [String : Any] in
                 ["recipe_id": recipe.recipeID ?? 0, "servings": 1]
            })
            let dict = ["meal_id": meal.mealID ?? 0, "recipe_list": recipes!] as [String : Any]
            mealData.append(dict)
        }
        
        return mealData
    }
    
    func downloadWeeklyPlanApi(StartDate:String , EndDate:String)
    {
        
        let param:[String:String] = ["start_date":StartDate,                                       "end_date":EndDate]
        
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.downloadWeeklyPlan, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.downloadWeeklyPlanObj = try JSONDecoder().decode(GetWeeklyPlan_Struct.self, from: data)
                            DispatchQueue.main.async { [self] in
                                savePdf(urlString: self.downloadWeeklyPlanObj.pdf_path, fileName: "\(StartDate)to\(EndDate)")
                            }
                        }
                        catch( let error ){
                            print(error)
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
    
    func updateOrCreate_WeeklyPlanTemplate_Api() {
        let param:[String: String] = ["name":"2021-11-22",                                         "plan_data":"2021-11-28",                                "save_as_new_weekly_plan_template":"",                        "weekly_plan_template_id":""]
        
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.updateOrCreateWeeklyPlanTemplate, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.updateOrCreateWeeklyPlanObj = try JSONDecoder().decode(Get_Status.self, from: data)
                            
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
    
    func clearWeeklyPlanRecipeApi() {
        
        let strFrom = DateToStringYYMMDD(date: fromDate)
        let strTo = DateToStringYYMMDD(date: toDate)
        
        let param:[String:String] = ["start_date":strFrom, "end_date":strTo]
        
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.clearWeeklyPlanRecipes, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        Loader.sharedInstance.hideIndicator()
                        do {
                            let clearPlanObj = try JSONDecoder().decode(Get_Status.self, from: data)
                            Alert.showMiddleToast(message: clearPlanObj.message, view_VC: self)
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
    
    func getDateWiseWeeklyPlanDetailsApi() {
        let strFrom = DateToStringYYMMDD(date: fromDate)
        let strTo = DateToStringYYMMDD(date: toDate)
        
        let param:[String:String] = ["start_date":strFrom, "end_date":strTo]
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getDateWiseWeeklyPlanDetails, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.dateWiseWeeklyPlanObj = try JSONDecoder().decode(DateWiseWeeklyPlan_Struct.self, from: data)
                            
                            self.selectedDay = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?.first(where: { $0.dayName == "Monday" })
                            
                            let mondayMealList = self.dateWiseWeeklyPlanObj?.weeklyPlanDetails?.days?.first(where: { $0.dayName == "Monday" })?.mealList
                            
                            self.filteredMealList = mondayMealList?.map({ (meal) -> (meal: MealListData?, isExpandable: Bool) in
                                 (meal: meal, isExpandable: false)
                            })
                            
                            self.tableView.reloadData()
                            self.setupDaysData()
                        }
                        catch (let error) {
                            print(error)
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



