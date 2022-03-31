//
//  HomeViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 06/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD015

import UIKit
import XLPagerTabStrip

class HomeViewController: BaseViewController {
    
    @IBOutlet var height_tableView: NSLayoutConstraint!
    @IBOutlet var height_headerView: NSLayoutConstraint!
    @IBOutlet var lbl_mode: UILabel!
    @IBOutlet var lbl_recipyInPlanCount: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var view_collection: UIView!
    @IBOutlet var tbl_receipes: UITableView!
    @IBOutlet var collectionView_Receipe: UICollectionView!
    @IBOutlet var height_viewCalendar: NSLayoutConstraint!
    @IBOutlet var height_viewCollection: NSLayoutConstraint!
    @IBOutlet var height_viewWelcome: NSLayoutConstraint!
    @IBOutlet var height_viewNoRecipe: NSLayoutConstraint!
    @IBOutlet var view_NoReceipes: UIView!
    @IBOutlet var lbl_noReceipe: UILabel!
    @IBOutlet var view_welcome: UIView!
    @IBOutlet var btn_GotIt: UIButton!
    @IBOutlet var lbl_welcomeString: UILabel!
    
    @IBOutlet var lbl_startDate: UILabel!
    @IBOutlet var lbl_endDate: UILabel!
    @IBOutlet var btn_mon: UIButton!
    @IBOutlet var btn_tue: UIButton!
    @IBOutlet var btn_wed: UIButton!
    @IBOutlet var btn_thu: UIButton!
    @IBOutlet var btn_fri: UIButton!
    @IBOutlet var btn_sat: UIButton!
    @IBOutlet var btn_sun: UIButton!
    
    var currentView = 1 // 1 = view_welcome, 2 = view_collection, 3 = view_noRecipe
    
    @IBOutlet var switch_mode: UISwitch!
    var childNumber: String = "DashBoard"
    var str_noReceipe : String = ""
    var str_welcome : String = ""
    
    var heightOfWelcomeText = CGFloat()
    var heightOfNoRecipeText = CGFloat()
    
    var arr_title = [String]()
    var arr_icon = [UIImage]()
    
    let screenSize = UIScreen.main.bounds
    var screenWidth = CGFloat()
    
    var deviceSpecificExtraHeight = CGFloat()
    var global_Var = GlobalClass.sharedManager
    var homeDataObj: HomeStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializer()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializer()
    }
    
    func initializer()
    {
        UserDefaults.standard.set(0, forKey: "mode")
        UserDefaults.standard.synchronize()
        self.tbl_receipes.estimatedRowHeight = 100.0
        height_viewCalendar.constant = 0.0
        lbl_mode.text = "Basic"
        self.tbl_receipes.rowHeight = UITableView.automaticDimension
        tbl_receipes.register(UINib(nibName:
                                        "TodaysReceipeCell", bundle: .none), forCellReuseIdentifier: "cell")
        tbl_receipes.dataSource = self
        tbl_receipes.delegate = self
        collectionView_Receipe.delegate = self
        collectionView_Receipe.dataSource = self
        btn_GotIt.layer.borderWidth = 1.0
        btn_GotIt.layer.borderColor = UIColor.appGrayColor().cgColor
        btn_GotIt.layer.cornerRadius = btn_GotIt.frame.size.height / 2
        
        arr_title = ["Plan","Shop","Cook"]
        arr_icon = [UIImage.init(named: "breakfast_white"),
                    UIImage.init(named: "dinner_white"),
                    UIImage.init(named: "lunch_white"),
                    UIImage.init(named: "lunch_white")] as! [UIImage]
        
        screenWidth = screenSize.width
        deviceSpecificExtraHeight = 0.0
        if(screenWidth < 375.0)
        {
            deviceSpecificExtraHeight = 70.0
        }
        showViewWelcome()
        homeApi()
    }
    func setWelcomeText()
    {
        str_welcome = "Welcome to your home screen. Using the app is easy. Simply create your plan shop for what you need and cook delicious meals First, head over to the explore tab and subscribe to few brands or chefs to have their recipes to your My Reeipes tab Then, click plan to choose your meals for the upcoming week. Welcome to your home screen. Using the app is easy. Simply create your plan shop for what you need and cook delicious meals First, head over to the explore tab and subscribe to few brands or chefs to have their recipes to your My Reeipes tab Then, click plan to choose your meals for the upcoming week"
        
        lbl_welcomeString.text = str_welcome
        heightOfWelcomeText = lbl_welcomeString.text?.height(withConstrainedWidth: view_welcome.frame.size.width - 40.0, font: UIFont.init(name: "ENGCARNATION", size: 14.0)!) ?? 0.0
        
    }
    
    
    func setNoReceipeText()
    {
        str_noReceipe = "No recipes have been assigned to the selected week yet- head on over to the Plan screen to get started."
        lbl_noReceipe.text = str_noReceipe
        heightOfNoRecipeText = lbl_noReceipe.text?.height(withConstrainedWidth: view_welcome.frame.size.width - 40.0, font: UIFont.init(name: "ENGCARNATION", size: 14.0)!) ?? 0.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView == collectionView_Receipe)
        {
            let offSet = collectionView_Receipe.contentOffset.x
            let width = collectionView_Receipe.frame.width
            let horizontalCenter = width / 2
            
            pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
        }
    }
    
    @IBAction func onClickBtn_backCalendar(_ sender: UIButton) {
        showViewNoRecipe()
    }
    
    @IBAction func onClickBtn_forwardCalendar(_ sender: UIButton) {
        self.showCalendarViewController(setTopLabel: "", customDelegate: self)
    }
    
    @IBAction func onClickBtnGotIt(_ sender: UIButton) {
        showViewCollection()
    }
    
    func showViewNoRecipe()
    {
        currentView = 3
        setNoReceipeText()
        basicModeSetup()
        self.tbl_receipes.reloadData()
        self.view.layoutIfNeeded()
    }
    
    func showViewWelcome()
    {
        currentView = 1
        setWelcomeText()
        basicModeSetup()
        self.tbl_receipes.reloadData()
        self.view.layoutIfNeeded()
    }
    
    func showViewCollection()
    {
        currentView = 2
        basicModeSetup()
    }
    
    func basicModeSetup()
    {
        if(currentView == 1)
        {
            height_viewNoRecipe.constant = 0.0
            height_viewCollection.constant = 0.0
            
            height_viewWelcome.constant = heightOfWelcomeText + deviceSpecificExtraHeight + 90.0//200.0
            
            if(lbl_mode.text == "Basic")
            {
                height_headerView.constant = heightOfWelcomeText + 160.0 + deviceSpecificExtraHeight
            }
            else
            {
                height_headerView.constant = 310.0 + heightOfWelcomeText + deviceSpecificExtraHeight
            }
        }
        else if(currentView == 2)
        {
            height_viewNoRecipe.constant = 0.0
            height_viewWelcome.constant = 0.0
            height_viewCollection.constant = 137.0
            if(lbl_mode.text == "Basic")
            {
                height_headerView.constant = 220.0
            }
            else
            {
                height_headerView.constant = 380.0
            }
        }
        else
        {
            height_viewCollection.constant = 0.0
            height_viewWelcome.constant = 0.0
            height_viewNoRecipe.constant = heightOfNoRecipeText + 90.0
            if(lbl_mode.text == "Basic")
            {
                height_headerView.constant = heightOfNoRecipeText + 160.0
            }
            else
            {
                height_headerView.constant = 310.0 + heightOfNoRecipeText
            }
        }
    }
    
    
    @IBAction func onClickSwitchMode(_ sender: UISwitch) {
        if(sender.isOn == true)
        {
            showCustomKeyFeaturePopUp(customDelegate : self, DataDict: homeDataObj ?? HomeStruct())
        }
        else
        {
            lbl_mode.text = "Basic"
            height_viewCalendar.constant = 0.0
            UserDefaults.standard.set(0, forKey: "mode")
            UserDefaults.standard.synchronize()
            basicModeSetup()
            
        }
        self.tbl_receipes.reloadData()
        self.view.layoutIfNeeded()
    }
    
    //MARK:All Days Buttons Action
    @IBAction func onClickBtnMon(_ sender: UIButton) {
        setDaysButtonsColor()
        sender.backgroundColor = UIColor.appOrangeColor()
        showViewCollection()
        
        //Switch case for specific action to buttons
        /* switch sender.tag {
         case 1:
         setDaysButtonsColor()
         sender.backgroundColor = UIColor.appOrangeColor()
         break
         case 2:
         setDaysButtonsColor()
         sender.backgroundColor = UIColor.appOrangeColor()
         break
         case 3:
         setDaysButtonsColor()
         sender.backgroundColor = UIColor.appOrangeColor()
         break
         case 4:
         setDaysButtonsColor()
         sender.backgroundColor = UIColor.appOrangeColor()
         break
         case 5:
         setDaysButtonsColor()
         sender.backgroundColor = UIColor.appOrangeColor()
         break
         case 6:
         setDaysButtonsColor()
         sender.backgroundColor = UIColor.appOrangeColor()
         break
         case 7:
         setDaysButtonsColor()
         sender.backgroundColor = UIColor.appOrangeColor()
         break
         default:
         setDaysButtonsColor()
         sender.backgroundColor = UIColor.appOrangeColor()
         break
         }*/
        
    }
    
    func setDaysButtonsColor()
    {
        btn_mon.backgroundColor = UIColor.init(red: 234.0/255.0, green: 232.0/255.0, blue: 233.0/255.0, alpha: 0.15)
        btn_tue.backgroundColor = UIColor.init(red: 234.0/255.0, green: 232.0/255.0, blue: 233.0/255.0, alpha: 0.15)
        btn_wed.backgroundColor = UIColor.init(red: 234.0/255.0, green: 232.0/255.0, blue: 233.0/255.0, alpha: 0.15)
        btn_thu.backgroundColor = UIColor.init(red: 234.0/255.0, green: 232.0/255.0, blue: 233.0/255.0, alpha: 0.15)
        btn_fri.backgroundColor = UIColor.init(red: 234.0/255.0, green: 232.0/255.0, blue: 233.0/255.0, alpha: 0.15)
        btn_sat.backgroundColor = UIColor.init(red: 234.0/255.0, green: 232.0/255.0, blue: 233.0/255.0, alpha: 0.15)
        btn_sun.backgroundColor = UIColor.init(red: 234.0/255.0, green: 232.0/255.0, blue: 233.0/255.0, alpha: 0.15)
    }
}

//MARK:TableView Setup
extension HomeViewController : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_title.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodaysReceipeCell
        cell.lbl_title.text = arr_title[indexPath.row]
        cell.img_icon.image = arr_icon[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                self.height_tableView.constant = self.tbl_receipes.contentSize.height
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabBarController?.selectedIndex = indexPath.row + 1
    }
}

//MARK:CollectionView Setup
extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeDataObj?.dashbaordData?.daysList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReceipeCollection", for: indexPath) as! HomeWeeklyRecipeCell
        let dict = homeDataObj?.dashbaordData?.daysList?[indexPath.row]
        cell.Configure(dayData: dict)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size
                        .width, height: 150.0)
    }
}


extension HomeViewController : IndicatorInfoProvider{
    //    MARK: XLPagerTabStrip
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(childNumber)")
    }
}


extension HomeViewController : CustomKeyFeaturePopUpDelegate{
    func onClcikCancelButton() {
        switch_mode.isOn = false
    }
    func onClcikUpgradeButton() {
        print("Upgrade")
    let vc =  UIStoryboard.Login_Model_Storyboard.instantiateViewController(withIdentifier: "MembershipLevelViewController") as! MembershipLevelViewController
       // self.updateFoodInterestAPI()
        self.navigationController?.pushViewController(vc, animated: true)
//        lbl_mode.text = "Advanced"
//        UserDefaults.standard.set(1, forKey: "mode")
//        UserDefaults.standard.synchronize()
//        height_viewCalendar.constant = 160.0
//        basicModeSetup()
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}

extension HomeViewController : CustomCalendarViewController
{
    func onClickAddButton() {
        //self.dismiss(animated: true, completion: nil)
    }
}

extension HomeViewController
{
    func homeApi()
    {
        let lastMondayDate = DateToString(date: Date.today().previous(.monday, considerToday: true))
        let nextSundayDate = DateToString(date: Date.today().next(.sunday, considerToday: true))
        print("lastMondayDate ==> \(lastMondayDate)")
        print("nextSundayDate ==> \(nextSundayDate)")
        let param:[String:String] = ["userType":"2",                                                                   "start_date":lastMondayDate,
                                     "end_date":nextSundayDate]
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getDashboardData1, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.homeDataObj = try JSONDecoder().decode(HomeStruct.self, from: data)
                            self.collectionView_Receipe.reloadData()
                            self.pageControl.numberOfPages = self.homeDataObj?.dashbaordData?.daysList?.count ?? 0
                            self.pageControl.currentPage = 0
                            self.lbl_recipyInPlanCount.text = "Recipe in plan :  \(self.homeDataObj?.dashbaordData?.recipeCountInPlan ?? 0)"
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


