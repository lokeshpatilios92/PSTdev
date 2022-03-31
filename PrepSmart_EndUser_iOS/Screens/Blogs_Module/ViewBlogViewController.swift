//
//  ViewBlogViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh Kulkarni on 31/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import JJFloatingActionButton

class ViewBlogViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var blogTitleHeaderLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var chifeNameLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDetailsLabel: UILabel!
    
    @IBOutlet weak var readMoreButton: UIButton!
    
    @IBOutlet weak var chifeProfileImageView: UIImageView!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var view_shareBG: UIView!
    @IBOutlet weak var view_bottom: UIView!
    @IBOutlet weak var view_share: UIView!
    @IBOutlet weak var view_pinterest: UIView!
    @IBOutlet weak var view_twitter: UIView!
    @IBOutlet weak var view_google: UIView!
    @IBOutlet weak var view_facebook: UIView!
    
    fileprivate let shareFloatingButton = JJFloatingActionButton()
    
    let previewBlogCollectionCell    = "PreviewBlogCollectionCell"
    let commentsTableViewCell        = "CommentsTableViewCell"
    let replyOnCommentsTableViewCell = "ReplyOnCommentsTableViewCell"
    
    var sectionArray : [String] = ["Section0","Section1","Section2","Section3","Section4"]
    var sectionToggleArray:[Bool] = [false,false,false,false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // super.viewWillAppear(animated)
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
    
    func initalize(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("View Blog")
//        self.navigationItem.rightBarButtonItems = [addDeleteBlogNavButton(),addEditBlogNavButton()]
        
        tableView.register(UINib.init(nibName: commentsTableViewCell, bundle: nil), forCellReuseIdentifier: commentsTableViewCell)
        tableView.register(UINib.init(nibName: replyOnCommentsTableViewCell, bundle: nil), forCellReuseIdentifier: replyOnCommentsTableViewCell)
        
        //configureshareFloatingButton()
        
        // Initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 270)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.isPagingEnabled = true
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: previewBlogCollectionCell, bundle: nil), forCellWithReuseIdentifier: previewBlogCollectionCell)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view_share.clipsToBounds = true
        view_share.layer.cornerRadius = view_share.frame.height / 2
        
        view_bottom.clipsToBounds = true
        view_bottom.layer.cornerRadius = 4.0
        
        view_pinterest.clipsToBounds = true
        view_pinterest.layer.cornerRadius = 4.0
        
        view_twitter.clipsToBounds = true
        view_twitter.layer.cornerRadius = 4.0
        
        view_google.clipsToBounds = true
        view_google.layer.cornerRadius = 4.0
        
        view_facebook.clipsToBounds = true
        view_facebook.layer.cornerRadius = 4.0
    }
    
//    // nav button added
//    func addDeleteBlogNavButton() -> UIBarButtonItem {
//        let addDeleteBlogNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "delete"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
//        addDeleteBlogNavButton.tag = 0
//        return addDeleteBlogNavButton
//    }
//    func addEditBlogNavButton() -> UIBarButtonItem {
//        let addEditBlogNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "edit_icon"), style: .done, target: self, action: #selector(self.onClickNavigationBarButton))
//        addEditBlogNavButton.tag = 1
//        return addEditBlogNavButton
//    }
//
//    //    MARK: Onclick Func
//    @objc override func onClickNavigationBarButton(sender:UIBarButtonItem) {
//        if sender.tag == 0
//        {
//            self.showCustomOkCancelPopUp(titleText: "Delete Blog", mesgText: "Are you sure, you want to delete this blog?", okButtonName: "Yes", cancelButtonName: "No", leftCornerImage: #imageLiteral(resourceName: "mixVag_image4"), customDelegate:self)
//        }
//        else if sender.tag == 1
//        {
//            let vc = UIStoryboard.BlogsStoryboard.instantiateViewController(withIdentifier: "EditBlogsViewController") as! EditBlogsViewController
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    @objc func toggle(_ sender: UIButton) {
        for (i,_) in self.sectionToggleArray.enumerated() {
            if i != sender.tag {
                self.sectionToggleArray[i] = false //!self.sectionToggleArray[sender.tag]
            }
        }
        self.sectionToggleArray[sender.tag] = !self.sectionToggleArray[sender.tag]
        //        UIView.performWithoutAnimation {
        
        tableView.reloadSections(IndexSet(integersIn: 0..<(sectionArray.count)), with: .automatic)
        let index = IndexPath.init(row: NSNotFound, section: sender.tag)
        tableView.scrollToRow(at: index, at: .top, animated: true)
    }
    
    @IBAction func onClickShare(_ sender: Any) {
        view_shareBG.isHidden = !view_shareBG.isHidden
        UIView.animate(withDuration: 0.5) {
            self.view_pinterest.isHidden = !self.view_pinterest.isHidden
            self.view_twitter.isHidden = !self.view_twitter.isHidden
            self.view_google.isHidden = !self.view_google.isHidden
            self.view_facebook.isHidden = !self.view_facebook.isHidden
        }
    }
    
    //    MARK: configure JJFloatingActionButton Button
    fileprivate func configureshareFloatingButton() {
        shareFloatingButton.buttonDiameter = 55
        //        shareFloatingButton.overlayView.backgroundColor = UIColor(hue: 0.31, saturation: 0.37, brightness: 0.10, alpha: 0.30)
        shareFloatingButton.buttonImage = #imageLiteral(resourceName: "share-normal")
        shareFloatingButton.buttonColor = .appOrangeColor()
        shareFloatingButton.buttonImageColor = .clear
        
        shareFloatingButton.buttonAnimationConfiguration = .transition(toImage: #imageLiteral(resourceName: "close"))
        shareFloatingButton.itemAnimationConfiguration = .slideIn(withInterItemSpacing: 14)
        
        //        shareFloatingButton.layer.shadowColor = UIColor.black.cgColor
        //        shareFloatingButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        //        shareFloatingButton.layer.shadowOpacity = Float(0.4)
        //        shareFloatingButton.layer.shadowRadius = CGFloat(2)
        //
        //        shareFloatingButton.itemSizeRatio = CGFloat(0.75)
        //        shareFloatingButton.configureDefaultItem { item in
        //            item.titlePosition = .leading
        //            item.titleSpacing = 16
        //
        //            item.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
        //            item.titleLabel.textColor = .white
        //            item.buttonColor = .white
        //            item.buttonImageColor = .red
        //
        //            item.layer.shadowColor = UIColor.black.cgColor
        //            item.layer.shadowOffset = CGSize(width: 0, height: 1)
        //            item.layer.shadowOpacity = Float(0.4)
        //            item.layer.shadowRadius = CGFloat(2)
        //        }
        
        shareFloatingButton.addItem(title: "", image: #imageLiteral(resourceName: "pinterest")) { item in
            print("hi")
        }
        shareFloatingButton.addItem(title: "", image: #imageLiteral(resourceName: "twitter")) { item in
        }
        shareFloatingButton.addItem(title: "", image: #imageLiteral(resourceName: "linkedin")) { item in
        }
        shareFloatingButton.addItem(title: "", image: #imageLiteral(resourceName: "googleplus")) { item in
        }
        
        shareFloatingButton.display(inViewController: self)
    }
}

extension ViewBlogViewController : CustomOkCancelPopUpViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    //    MARK: CustomOkCancelPopUpViewControllerDelegate
    func onClickOkButton() {
        print("ok button clicked")
    }
    
    func onClickCancelButton() {
        print("cancel button clicked")
    }
    
    //    MARK: UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewBlogCollectionCell, for: indexPath) as! PreviewBlogCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageController.currentPage = indexPath.item
    }
}

extension ViewBlogViewController : UITableViewDataSource, UITableViewDelegate {
    
    //    MARK: UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if section == 0 {
        //            return
        //        }
        //        if section == 1 {
        //            return 1
        //        }
        //        if section == 2 {
        //            return 3
        //        }
        if sectionToggleArray[section] {
            return 2
        }
        return 0
        //        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: commentsTableViewCell, for: indexPath) as! CommentsTableViewCell
            
            cell.bgViewLeadingConstraint.constant = 50
            cell.commentButton.isHidden = true
            cell.replayButton.isHidden = true
            cell.commentsView.isHidden = true
            cell.sepraterView.isHidden = true
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: replyOnCommentsTableViewCell, for: indexPath) as! ReplyOnCommentsTableViewCell
        //        cell.bgViewLeadingConstraint.constant = 40
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.viewForHeaderInSection(section: section).frame.height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func viewForHeaderInSection(section:Int) -> UIView {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentsTableViewCell) as! CommentsTableViewCell
        cell.bgViewLeadingConstraint.constant = 20
        
        if sectionToggleArray[section] {
            cell.dropDownImage.image = #imageLiteral(resourceName: "drop_arrow")
            cell.sepraterView.isHidden = true
        }
        else {
            cell.dropDownImage.image = #imageLiteral(resourceName: "forward_arrow")
            cell.sepraterView.isHidden = false
        }
        
        cell.commentButton.tag = section
        cell.commentButton.addTarget(self, action: #selector(self.toggle(_:)), for: .touchUpInside)
        
        return cell.contentView
    }
}
