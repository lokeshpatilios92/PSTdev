//
//  ReviewsandRatingsVC.swift
//  PrepSmart_ETPL
//
//  Created by Etpl-Mac on 21/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ReviewsandRatingsVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView_inner: UIScrollView!
    @IBOutlet weak var constraintTblViewHT: NSLayoutConstraint!
    
    var parentVC : UIViewController?
    var isRatingsHidden = false
    var reviewsAndRatingsCell  = "ReviewsandRatingCell"
    var commentsSectionHeader  = "CommentsSectionHeader"
    var ratingCustomHeaderCell = "RatingCustomHeaderCell"
    var commentsCell           = "CommentsCell"
    
    var startArray = ["5 Star","4 Star","3 Star","2 Star","1 Star"]
    var startPercentage = ["71 %","13 %","6 %","5 %","5 %"]
    var progressArray = [0.80,0.60,0.40,0.25,0.25]
    
    var isExpanded = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
            initializer()
    }
    
    
    func initializer(){
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Reviews and Comments")
      
        if parentVC != nil
        {
            self.scrollView_inner.delegate = parentVC as? UIScrollViewDelegate
            self.scrollView_inner.isScrollEnabled = false
        }
        
        tableView.register(UINib.init(nibName: reviewsAndRatingsCell, bundle: nil), forCellReuseIdentifier: reviewsAndRatingsCell)
        tableView.register(UINib.init(nibName: commentsSectionHeader, bundle: nil), forCellReuseIdentifier: commentsSectionHeader)
        tableView.register(UINib.init(nibName: ratingCustomHeaderCell, bundle: nil), forCellReuseIdentifier: ratingCustomHeaderCell)
        tableView.register(UINib.init(nibName: commentsCell, bundle: nil), forCellReuseIdentifier: commentsCell)
    }
    
    override func viewWillLayoutSubviews() {
        DispatchQueue.main.async {
            self.constraintTblViewHT.constant = self.tableView.contentSize.height
        }
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
    
    @objc func sectionButtonTapped(sender: UIButton){
            isExpanded = !isExpanded
            tableView.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
   }
}

extension ReviewsandRatingsVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = self.tableView.dequeueReusableCell(withIdentifier: ratingCustomHeaderCell) as! RatingCustomHeaderCell
            headerView.sectionButton.tag = section
            headerView.sectionButton.addTarget(self, action: #selector(sectionButtonTapped(sender:)), for: .touchUpInside)
            if isExpanded{
                headerView.dropDownImgView.image = #imageLiteral(resourceName: "up_arrow")
            }else{
                 headerView.dropDownImgView.image = #imageLiteral(resourceName: "drop_arrow")
            }
            return headerView.contentView
        }else{
           let headerView = self.tableView.dequeueReusableCell(withIdentifier: commentsSectionHeader) as! CommentsSectionHeader
            return headerView.contentView
            
        }
    
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if isExpanded {
                return 5
            }else{
                return 0
            }
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: reviewsAndRatingsCell, for: indexPath) as! ReviewsandRatingCell
            cell.starPercentageLabel.text = startPercentage[indexPath.row]
            cell.progressView.progress = CGFloat(progressArray[indexPath.row])
            cell.startLabel.text = startArray[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: commentsCell, for: indexPath) as! CommentsCell
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //117.5
//        let selectedIndexPath = IndexPath(row: indexPath.row, section: indexPath.section)
//        let cell = tableView.cellForRow(at: selectedIndexPath) as! ReviewsandRatingCell
//
//        if isRatingsHidden == false{
//            cell.progressBarContainerView.isHidden = true
//            cell.imageView?.image = #imageLiteral(resourceName: "up_arrow")
//            self.isRatingsHidden = true
//        }else{
//            cell.progressBarContainerView.isHidden = false
//            cell.imageView?.image = #imageLiteral(resourceName: "drop_arrow")
//            isRatingsHidden = false
//        }
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0
        {
            return 10.0
        }
        return 0.000001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        return footerView
    }

}
