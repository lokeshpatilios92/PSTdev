//
//  RecipeHeaderView.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 08/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class RecipeHeaderView: UITableViewHeaderFooterView {

    @IBOutlet var lbl_mode: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var view_collection: UIView!
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
    
    
    
}
