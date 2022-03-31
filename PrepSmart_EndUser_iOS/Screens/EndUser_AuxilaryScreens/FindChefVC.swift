//
//  FindChefVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 17/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class FindChefVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var childNumber: String = ""
    var exploreChefCell = "ExploreChefCell"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializer()
    }
    
    func initializer(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Chefs")
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = .white
        searchBar.isTranslucent = true
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 0.50
        searchBar.layer.cornerRadius = searchBar.frame.height / 2
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: UISearchBar.Icon.search, state: .normal)
        tableView.register(UINib(nibName: exploreChefCell, bundle: .none), forCellReuseIdentifier: exploreChefCell)
   }
    
    @objc func onClickviewProfileBtn(_ sender : UIButton){
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "ChefProfileViewController") as! ChefProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension FindChefVC : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: exploreChefCell, for: indexPath) as! ExploreChefCell
        cell.viewProfileBtn.tag = indexPath.row
        cell.viewProfileBtn.addTarget(self, action: #selector(self.onClickviewProfileBtn(_:)), for: .touchUpInside)
        return cell
        
    }
    
    
    
}
