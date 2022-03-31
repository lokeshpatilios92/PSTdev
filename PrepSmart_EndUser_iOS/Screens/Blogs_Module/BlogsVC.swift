//
//  BlogsVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 07/11/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class BlogsVC: BaseViewController {
    
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    //        @IBOutlet weak var Lbl_resultCount: UILabel!
    //        @IBOutlet weak var downArrowBtn: UIButton!
    //        @IBOutlet weak var filterBtn: UIButton!
    //        @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    //        @IBOutlet weak var favView: UIView!
    //        @IBOutlet weak var cretedByMeView: UIView!
    //        @IBOutlet weak var allView: UIView!
    //        @IBOutlet weak var allBtn: UIButton!
    //        @IBOutlet weak var createdByMebtn: UIButton!
    //        @IBOutlet weak var favBtn: UIButton!
    //        @IBOutlet weak var Lbl_All: UILabel!
    //        @IBOutlet weak var Lbl_CreatedByMe: UILabel!
    //        @IBOutlet weak var Lbl_Fav: UILabel!
    //        @IBOutlet weak var tableView: UITableView!
    //        @IBOutlet weak var txt_dropDown: UITextField!
    
    var childNumber = ""
    let blogsCollectionCell = "BlogsCollectionCell"
    //        var chefsDropDown = DropDown()
    
    var screenSize: CGRect!
       var screenWidth: CGFloat!
       var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializer()
    }
    
    func initializer(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Blogs")
        self.navigationItem.rightBarButtonItems = [addSortNavButton(),addFilterNavButton()]
        
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = .white
        searchBar.isTranslucent = true
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.searchTextField.backgroundColor = .clear
        searchBarView.layer.borderWidth = 0.50
        searchBarView.layer.cornerRadius = searchBarView.frame.height / 2
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: UISearchBar.Icon.search, state: .normal)

        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: 250)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout

        collectionView.register(UINib(nibName: blogsCollectionCell, bundle: nil), forCellWithReuseIdentifier: blogsCollectionCell)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    

}

@available(iOS 13.0, *)
extension BlogsVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: blogsCollectionCell, for: indexPath) as! BlogsCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.Blogs_Module.instantiateViewController(withIdentifier: "ViewBlogViewController") as! ViewBlogViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
