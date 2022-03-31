//
//  ExploreVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 26/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD024

import UIKit
import XLPagerTabStrip
import Popover

class ExploreVC: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var childNumber: String = ""
    let exploreCell = "ExploreCell"
    let titleArray = ["Find New Weekly Plan Templates",
                      "Find New Chefs",
                      "Find New Recipes",
                      "Find Recipes Pack",
                      "Top Trending Recipes",
                      "Prepsmart's Choice",
                      "Best Selling Recipes",
                      "Seasonal"]
    var filteredData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = titleArray
        initialize()
    }
    
    func initialize() {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Explore")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("0"), object: nil)
        
        tableView.register(UINib(nibName: exploreCell, bundle: .none), forCellReuseIdentifier: exploreCell)
        self.navigationItem.rightBarButtonItem = addNotificationNavButton()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.placeholder = " Search"
        searchBar.sizeToFit()
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: .search, state: .normal)
        searchBar.layer.borderColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 0.5077373798)
        searchBar.layer.borderWidth = 1
        searchBar.layer.cornerRadius = 20.0
        searchBar.backgroundImage = UIImage()
        searchBar.clipsToBounds = true
        let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor.white
        searchBar.backgroundColor = UIColor.white
        bgImage.isHidden = true
    }
    
    @objc func buttonSelected(sender: UIButton){
        print(sender.tag)
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: aView.frame.width - 40, height: 300))
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.font = UIFont.REGULAR_FONT_SMALLEST()
        infoLabel.textColor = .textColor()
        infoLabel.text = "In order to complete this transaction, please ask the user to update this status to 'Complete' at conclusion of your call"
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
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! ExploreCell
        popover.show(aView, fromView: cell.popOverBtn)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreWeeklyPlanDetailsViewController") as! ExploreWeeklyPlanDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ExploreVC : UITableViewDelegate,UITableViewDataSource{
    
    //    MARK: UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: exploreCell, for: indexPath) as! ExploreCell
        cell.titleLbl.text = filteredData[indexPath.row]
        if indexPath.row == 3{
            cell.popOverBtn.isHidden = false
        }else{
            cell.popOverBtn.isHidden = true
        }
        cell.popOverBtn.tag = indexPath.row
        cell.popOverBtn.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = filteredData[indexPath.row]
        switch title {
        case "Find New Weekly Plan Templates":
            let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreRecipesViewController") as! ExploreRecipesViewController
            vc.exploreType = "2"
            self.navigationController?.pushViewController(vc, animated: true)
        case "Find New Chefs":
            // 8 che
            let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "ExploreChefsVC") as! ExploreChefsVC
            self.navigationController?.pushViewController(vc, animated: false)
        case "Find New Recipes":
            let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreRecipesViewController") as! ExploreRecipesViewController
            vc.exploreType = "1"
            self.navigationController?.pushViewController(vc, animated: true)
        case "Find Recipes Pack":
            let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreRecipesViewController") as! ExploreRecipesViewController
            vc.exploreType = "3"
            self.navigationController?.pushViewController(vc, animated: true)
        case "Top Trending Recipes":
            let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreRecipesViewController") as! ExploreRecipesViewController
            vc.exploreType = "4"
            self.navigationController?.pushViewController(vc, animated: true)
        case "Prepsmart's Choice":
            let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreRecipesViewController") as! ExploreRecipesViewController
            vc.exploreType = "5"
            self.navigationController?.pushViewController(vc, animated: true)
        case "Best Selling Recipes":
            let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreRecipesViewController") as! ExploreRecipesViewController
            vc.exploreType = "6"
            self.navigationController?.pushViewController(vc, animated: true)
        case "Seasonal":
            let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreRecipesViewController") as! ExploreRecipesViewController
            vc.exploreType = "7"
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = UIStoryboard.Explore_Module.instantiateViewController(withIdentifier: "ExploreRecipesViewController") as! ExploreRecipesViewController
            vc.exploreType = "3"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension ExploreVC : IndicatorInfoProvider{
    //    MARK: XLPagerTabStrip
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(childNumber)")
    }
}

extension ExploreVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
        filterContentForSearchText(searchText: searchText)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        if searchText != "" {
            filteredData = titleArray.filter {name in
                return   name.lowercased().contains(searchText.lowercased())
            }
        }
        else {
            self.filteredData = self.titleArray
        }
        print(filteredData)
        print(filteredData.count)
        tableView.reloadData()
    }
}
