//

//  ViewRecipeViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 19/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD125, PSTMOBSTD114, PSTMOBSTD115

import UIKit
import Tags
import UICircularProgressRing
import Cosmos
import DropDown

class ViewRecipeViewController: BaseViewController {
    
    @IBOutlet var btn_subscribedToPremiumUser: UIButton!
    @IBOutlet var btn_subscribedToChef: UIButton!
    @IBOutlet var btn_reportThisRecipe: UIButton!
    @IBOutlet var scroll_main: UIScrollView!
    @IBOutlet var height_viewButton: NSLayoutConstraint!
    @IBOutlet var height_tableView: NSLayoutConstraint!
    @IBOutlet var tbl_recipeDetails: UITableView!
    @IBOutlet var collection_recipe: UICollectionView!
    @IBOutlet var lbl_titleRecipe: UILabel!
    @IBOutlet var viewratting: CosmosView!
    @IBOutlet var page_recipe: UIPageControl!
    @IBOutlet var txtView_description: UILabel!
    
    var isCellCreated = false
    
    var currentNutritionCollectionCell = Int()
    var currentRecipeCollectionCell = Int()
    
    var arr_headerTitle = [String]()
    var isDropDownBtnClicked = [Bool]()
    var recipeId:String = ""
    var recipeOwnerId:String = ""
    var recipeDtails = RecipeDetailsStruct()
    var addCommentStatus = AppRating_Struct()
    var recipeCommentList = RecipeCommentStruct()
    
    var reviewsAndRatingsCell  = "ReviewsandRatingCell"
    var commentsSectionHeader  = "CommentsSectionHeader"
    var ratingCustomHeaderCell = "RatingCustomHeaderCell"
    var commentsCell           = "CommentsCell"
    var CommenttypeDropDown = DropDown()

    var startArray = ["5 Star","4 Star","3 Star","2 Star","1 Star"]
    var startPercentage = ["71 %","13 %","6 %","5 %","5 %"]
    var progressArray = [0.80,0.60,0.40,0.25,0.25]
    
    var isExpanded = true
    var commentFillerString = "Most Helpful"
    var commentFillerType = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCollectionView()
        initializeTableView()
        initialize()
        getRecipeDetailsApi()
        getRecipecommentsApi(CommentType: commentFillerType)
    }
    
    func initialize()
    {
        btn_reportThisRecipe.layer.borderWidth = 1.0
        btn_reportThisRecipe.layer.borderColor = UIColor.appOrangeColor().cgColor
        btn_reportThisRecipe.layer.cornerRadius = btn_reportThisRecipe.frame.size.height / 2
        
        btn_subscribedToChef.layer.cornerRadius = btn_subscribedToChef.frame.height / 2
        btn_subscribedToPremiumUser.layer.cornerRadius = btn_subscribedToPremiumUser.frame.height / 2
    }
    
    func initializeCollectionView()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 270)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collection_recipe.isPagingEnabled = true
        collection_recipe.collectionViewLayout = layout
        collection_recipe.register(UINib(nibName: "PreviewBlogCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PreviewBlogCollectionCell")
        collection_recipe.showsVerticalScrollIndicator = false
        collection_recipe.backgroundColor = .white
        collection_recipe.dataSource = self
        collection_recipe.delegate = self
        
        page_recipe.numberOfPages = 4
        page_recipe.currentPage = 0
    }
    
    func initializeTableView()
    {
        arr_headerTitle = ["Recipe Info","Ingredients and Instructions","Nutritional Information","Rate this page","Reviews and Comments","Notes"]
        
        for i in arr_headerTitle
        {
            print(i)
            isDropDownBtnClicked.append(false)
        }
        print("first isDropDownBtnClicked ,\( isDropDownBtnClicked )")
        tbl_recipeDetails.register(UINib.init(nibName: "ViewRecipeReviewsAndCommentsTableCell", bundle: nil), forCellReuseIdentifier: "ViewRecipeReviewsAndCommentsTableCell")
        
        tbl_recipeDetails.register(UINib.init(nibName: "AddToTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "AddToTableHeaderView")
        
        tbl_recipeDetails.register(UINib.init(nibName: "RecipeInfoTableCell", bundle: nil), forCellReuseIdentifier: "RecipeInfo")
        
        tbl_recipeDetails.register(UINib.init(nibName: "IngredientsAndInstructionsCell", bundle: nil), forCellReuseIdentifier: "IngredientsAndInstructionsCell")
        
        tbl_recipeDetails.register(UINib.init(nibName: "NutritionalInformationTableCell", bundle: nil), forCellReuseIdentifier: "NutritionalInformationTableCell")
        
        tbl_recipeDetails.register(UINib.init(nibName: "RateRecipeTableCell", bundle: nil), forCellReuseIdentifier: "RateRecipeTableCell")
        
        tbl_recipeDetails.register(UINib.init(nibName: "ViewRecipeNotesTableCell", bundle: nil), forCellReuseIdentifier: "ViewRecipeNotesTableCell")
        
        tbl_recipeDetails.isScrollEnabled = false
        
        tbl_recipeDetails.delegate = self
        tbl_recipeDetails.dataSource = self
        
        self.tbl_recipeDetails.estimatedRowHeight = 100.0
        self.tbl_recipeDetails.rowHeight = UITableView.automaticDimension
        
        self.tbl_recipeDetails.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        DispatchQueue.main.async {
            self.height_tableView.constant = self.tbl_recipeDetails.contentSize.height//+ 150
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(scrollView != self.scroll_main)
        {
            let offSet = collection_recipe.contentOffset.x
            let width = collection_recipe.frame.width
            let horizontalCenter = width / 2
            
            page_recipe.currentPage = Int(offSet + horizontalCenter) / Int(width)
            
            if(scrollView != collection_recipe)
            {
                
                //To Get Current Cell of collection_nutritionalInfo
                let indexPathOfCollection = IndexPath(row: 0, section: 2)
                let tableCell = tbl_recipeDetails.cellForRow(at: indexPathOfCollection) as! NutritionalInformationTableCell
                
                let offSet1 = tableCell.collection_nutritionalInfo.contentOffset.x
                let width1 = tableCell.collection_nutritionalInfo.frame.width
                let horizontalCenter1 = width1 / 2
                
                currentNutritionCollectionCell = Int(offSet1 + horizontalCenter1) / Int(width1)
                
                if(currentNutritionCollectionCell == 0)
                {
                    tableCell.btn_previous.isHidden = true
                }
                else
                {
                    tableCell.btn_previous.isHidden = false
                }
                
                
                if(currentNutritionCollectionCell == 3)
                {
                    tableCell.btn_next.isHidden = true
                }
                else
                {
                    tableCell.btn_next.isHidden = false
                }
                
                //To Get Current Cell of collection_recipe in tableView Cell
                let indexPathOfCollection1 = IndexPath(row: 0, section: 2)
                let tableCell1 = tbl_recipeDetails.cellForRow(at: indexPathOfCollection1) as! NutritionalInformationTableCell
                
                let offSet2 = tableCell1.collection_recipe.contentOffset.x
                let width2 = tableCell1.collection_recipe.frame.width
                let horizontalCenter2 = width2 / 2
                
                currentRecipeCollectionCell = Int(offSet2 + horizontalCenter2) / Int(width2)
                
                if(currentRecipeCollectionCell == 0)
                {
                    tableCell.btn_pairItPrevious.isHidden = true
                }
                else
                {
                    tableCell.btn_pairItPrevious.isHidden = false
                }
                
                if(currentRecipeCollectionCell == 3)
                {
                    tableCell.btn_pairItNext.isHidden = true
                }
                else
                {
                    tableCell.btn_pairItNext.isHidden = false
                }
            }
        }
    }
    
    @IBAction func onClickBtnSubscribedToChef(_ sender: UIButton) {
        print("subscribe")
    }
    
    @IBAction func onClickBtnSubscribedToPremiumUser(_ sender: UIButton) {
        print("SubscribedToPremiumUser")
    }
    
    @IBAction func onClickBtnReportThisRecipe(_ sender: UIButton) {
        print("ReportThisRecipe")
    }
    
    @IBAction func onClickBtnNext(_ sender: UIButton) {
        let indexPathOfCollection = IndexPath(row: 0, section: 2)
        let tableCell = tbl_recipeDetails.cellForRow(at: indexPathOfCollection) as! NutritionalInformationTableCell
        let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "DetailedNutritionalInfoViewController") as! DetailedNutritionalInfoViewController
        vc.recipeID = recipeId
        self.navigationController?.pushViewController(vc, animated: true)
//        if(currentNutritionCollectionCell != 3)
//        {
//            
//            let indexPathForCollection = IndexPath(item: currentNutritionCollectionCell + 1, section: 0)
//            tableCell.collection_nutritionalInfo.scrollToItem(at: indexPathForCollection, at: .left, animated: true)
//        }
    }
    
    @IBAction func onClickBtnPrevious(_ sender: UIButton) {
        let indexPathOfCollection = IndexPath(row: 0, section: 2)
        let tableCell = tbl_recipeDetails.cellForRow(at: indexPathOfCollection) as! NutritionalInformationTableCell
        
        if(currentNutritionCollectionCell != 0)
        {
            let indexPathForCollection = IndexPath(item: currentNutritionCollectionCell - 1, section: 0)
            tableCell.collection_nutritionalInfo.scrollToItem(at: indexPathForCollection, at: .left, animated: true)
        }
    }
    
    @IBAction func onClickBtnPairitPrevious(_ sender: UIButton) {
        let indexPathOfCollection = IndexPath(row: 0, section: 2)
        let tableCell = tbl_recipeDetails.cellForRow(at: indexPathOfCollection) as! NutritionalInformationTableCell
        
        if(currentRecipeCollectionCell != 0)
        {
            let indexPathForCollection = IndexPath(item: currentRecipeCollectionCell - 1, section: 0)
            tableCell.collection_recipe.scrollToItem(at: indexPathForCollection, at: .left, animated: true)
        }
    }
    
    @IBAction func onClickBtnPairItNext(_ sender: UIButton) {
        let indexPathOfCollection = IndexPath(row: 0, section: 2)
        let tableCell = tbl_recipeDetails.cellForRow(at: indexPathOfCollection) as! NutritionalInformationTableCell
        
//        if(currentRecipeCollectionCell != 3)
//        {
//            let indexPathForCollection = IndexPath(item: currentRecipeCollectionCell + 1, section: 0)
//            tableCell.collection_recipe.scrollToItem(at: indexPathForCollection, at: .left, animated: true)
//        }
    }
    
    @IBAction func onClickBtnDropDown(_ sender: UIButton) {
        print("tag ,\( sender.tag )")
        
        if(isDropDownBtnClicked[sender.tag] == false)
        {
            isDropDownBtnClicked[sender.tag] = true
        }
        else
        {
            isDropDownBtnClicked[sender.tag] = false
        }
        print("after click isDropDownBtnClicked ,\( isDropDownBtnClicked )")
        
        self.tbl_recipeDetails.reloadData()
        self.tbl_recipeDetails.layoutIfNeeded()
       self.height_tableView.constant = self.tbl_recipeDetails.contentSize.height
    }
    
    @IBAction func onClickBtnViewFullText(_ sender: UIButton) {
        // txtView_description.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        height_viewButton.constant = 0.0
        initialize()
    }
}

extension ViewRecipeViewController : UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.tag == 100)
        {
            return recipeDtails.imageList?.count ?? 0
            
        }
        if(collectionView.tag == 200)
        {
            return recipeDtails.recipeInfo?.nutritionalInformation?.count ?? 0
        }
        else
        {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView.tag == 100)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewBlogCollectionCell", for: indexPath) as! PreviewBlogCollectionCell
            cell.itemImageView.sd_setImage(with: URL(string: recipeDtails.imageList?[indexPath.row].imagePath ?? ""), placeholderImage: UIImage(named: "dinner"))
            return cell
        }
        else if(collectionView.tag == 200)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NutritionProgressCollectionCell", for: indexPath) as! NutritionProgressCollectionCell
            let dict = recipeDtails.recipeInfo?.nutritionalInformation?[indexPath.row]
            cell.viewProgress1.startProgress(to: CGFloat(dict?.calorificValue ?? 0), duration: 3)
            cell.viewProgress2.startProgress(to: CGFloat(dict?.totalCarbPercentage ?? 0), duration: 3)
            cell.viewProgress3.startProgress(to: CGFloat(dict?.totalProteinPercentage ?? 0), duration: 3)
            cell.viewProgress4.startProgress(to: CGFloat(dict?.totalFatPercentage ?? 0), duration: 3)
            cell.viewProgress4.startProgress(to: CGFloat(dict?.totalFatPercentage ?? 0), duration: 10.0) {
                print("Done animating!")
            }
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NutritionalInfoCollectionCell", for: indexPath) as! NutritionalInfoCollectionCell
            cell.lblTitle.text = "asdads"
            cell.imgTitle.sd_setImage(with: URL(string: ""),placeholderImage: UIImage(named: "dinner"))
            return cell
        }
    }
}


extension ViewRecipeViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(tableView == self.tbl_recipeDetails)
        {
            if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
                if indexPath == lastVisibleIndexPath {
                    self.height_tableView.constant = self.tbl_recipeDetails.contentSize.height
                }
            }
        }
        //        else
        //        {
        //            let indexPath1 = IndexPath.init(row: 0, section: 4)
        //            let cell = self.tbl_recipeDetails.cellForRow(at: indexPath1) as! ViewRecipeReviewsAndCommentsTableCell
        //            if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
        //                if indexPath == lastVisibleIndexPath {
        //                    cell.height_innerTableView.constant = cell.tbl_ratingsAndComments.contentSize.height
        //                }
        //            }
        //        }
    }
    
    
    @objc func sectionButtonTapped(sender: UIButton){
        isExpanded = !isExpanded
        let indexPath1 = IndexPath.init(row: 0, section: 4)
        let cell = self.tbl_recipeDetails.cellForRow(at: indexPath1) as! ViewRecipeReviewsAndCommentsTableCell
        cell.tbl_ratingsAndComments.reloadSections(IndexSet.init(integer: sender.tag), with: .automatic)
        self.tbl_recipeDetails.reloadData()
       // self.height_tableView.constant = self.tbl_recipeDetails.contentSize.height
    }
    
    @objc func commentFilterTapped(sender: UIButton){
     print("Select Filter")
       CommenttypeDropDown.show()
       CommenttypeDropDown.anchorView = sender.superview
       CommenttypeDropDown.textFont = UIFont.REGULAR_FONT()
       CommenttypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            switch item {
            case "Most Helpful" :
                commentFillerString = "Most Helpful"
                commentFillerType = "1"
                print("1")
            case "Least Helpful " :
                commentFillerString = "Least Helpful "
                commentFillerType = "2"
                
                print("2")
            case "Newest - Oldest" :
                commentFillerString = "Newest - Oldest"
                commentFillerType = "3"
                print("3")
            case "Oldest - Newest" :
                commentFillerString = "Oldest - Newest"
                commentFillerType = "4"
                print("4")
            default:
                print("1")
            }
           print("commentFillerType \(commentFillerType)")
            getRecipecommentsApi(CommentType: commentFillerType)
            CommenttypeDropDown.resignFirstResponder()
           
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(tableView == self.tbl_recipeDetails)
        {
            let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AddToTableHeaderView") as? AddToTableHeaderView
            
            headerCell?.btn_dropDown.tag = section
            headerCell?.btn_info.tag = section
            headerCell?.lbl_title.tag = section
            headerCell?.btn_info.isHidden = true
            
            if isDropDownBtnClicked[section]
            {
                headerCell?.btn_dropDown.setImage(#imageLiteral(resourceName: "arrow_up"), for: .normal)
            }
            else
            {
                headerCell?.btn_dropDown.setImage(#imageLiteral(resourceName: "arrow_down"), for: .normal)
            }
            
            headerCell?.lbl_title.text! = arr_headerTitle[section]
            headerCell?.lbl_title.textColor = UIColor.white
            
            return headerCell
        }
        else
        {
            if(section == 0)
            {
                let headerCell = tableView.dequeueReusableCell(withIdentifier: ratingCustomHeaderCell) as! RatingCustomHeaderCell
                headerCell.starRatingView.rating = Double(recipeDtails.recipeInfo?.reviewAndComment?.avgRating ?? 0)
                headerCell.ratingcountLbl.text = String(recipeDtails.recipeInfo?.reviewAndComment?.totalRating ?? 0)
                if isExpanded{
                    headerCell.dropDownImgView.image = #imageLiteral(resourceName: "up_arrow")
                }else{
                    headerCell.dropDownImgView.image = #imageLiteral(resourceName: "drop_arrow")
                }
                
                headerCell.sectionButton.tag = section
                headerCell.sectionButton.addTarget(self, action: #selector(sectionButtonTapped(sender:)), for: .touchUpInside)
                return headerCell.contentView
            }
            else
            {
                let headerCell = tableView.dequeueReusableCell(withIdentifier: commentsSectionHeader) as! CommentsSectionHeader
                headerCell.sectionButton.addTarget(self, action: #selector(commentFilterTapped(sender:)), for: .touchUpInside)
                headerCell.titleLabel.text = commentFillerString
                return headerCell.contentView
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView == self.tbl_recipeDetails)
        {
            return arr_headerTitle.count
        }
        else
        {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.tbl_recipeDetails)
        {
            if(isDropDownBtnClicked[section] == true)
            {
                return 0
            }
            return 1
        }
        else
        {
            if(section == 0)
            {
                if isExpanded {
                    return 5
                }else{
                    return 0
                }
            }
            else
            {
                return recipeCommentList.commentedUserList?.count ?? 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tbl_recipeDetails)
        {
            if(indexPath.section == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeInfo", for: indexPath) as! RecipeInfoTableCell
                cell.config(dict:recipeDtails.recipeInfo ?? RecipeInfo())
                return cell
            }
            else if(indexPath.section == 1)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsAndInstructionsCell", for: indexPath) as! IngredientsAndInstructionsCell
                cell.config(dictdata: recipeDtails.recipeInfo ?? RecipeInfo())
                return cell
            }
            else if(indexPath.section == 2)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionalInformationTableCell", for: indexPath) as! NutritionalInformationTableCell
                isCellCreated = true
                
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                layout.itemSize = CGSize(width: cell.collection_recipe.frame.width, height: 110)
                layout.scrollDirection = .horizontal
                layout.minimumLineSpacing = 0
                layout.minimumInteritemSpacing = 0
                
                cell.collection_nutritionalInfo.isPagingEnabled = true
                cell.collection_nutritionalInfo.collectionViewLayout = layout
                cell.collection_nutritionalInfo.register(UINib(nibName: "NutritionProgressCollectionCell", bundle: nil), forCellWithReuseIdentifier: "NutritionProgressCollectionCell")
                cell.collection_nutritionalInfo.showsVerticalScrollIndicator = false
                cell.collection_nutritionalInfo.backgroundColor = .white
                cell.collection_nutritionalInfo.dataSource = self
                cell.collection_nutritionalInfo.delegate = self
                
                cell.collection_recipe.isPagingEnabled = true
                cell.collection_recipe.collectionViewLayout = layout
                cell.collection_recipe.register(UINib(nibName: "NutritionalInfoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "NutritionalInfoCollectionCell")
                cell.collection_recipe.showsVerticalScrollIndicator = false
                cell.collection_recipe.backgroundColor = .white
                cell.collection_recipe.dataSource = self
                cell.collection_recipe.delegate = self
                
                return cell
            }
            else if(indexPath.section == 4)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ViewRecipeReviewsAndCommentsTableCell", for: indexPath) as! ViewRecipeReviewsAndCommentsTableCell
                
                cell.tbl_ratingsAndComments.register(UINib.init(nibName: reviewsAndRatingsCell, bundle: nil), forCellReuseIdentifier: reviewsAndRatingsCell)
                cell.tbl_ratingsAndComments.register(UINib.init(nibName: commentsSectionHeader, bundle: nil), forCellReuseIdentifier: commentsSectionHeader)
                cell.tbl_ratingsAndComments.register(UINib.init(nibName: ratingCustomHeaderCell, bundle: nil), forCellReuseIdentifier: ratingCustomHeaderCell)
                cell.tbl_ratingsAndComments.register(UINib.init(nibName: commentsCell, bundle: nil), forCellReuseIdentifier: commentsCell)
                
                cell.tbl_ratingsAndComments.delegate = self
                cell.tbl_ratingsAndComments.dataSource = self
                
                cell.tbl_ratingsAndComments.estimatedRowHeight = 100.0
                cell.tbl_ratingsAndComments.rowHeight = UITableView.automaticDimension
                cell.tbl_ratingsAndComments.reloadData()
                cell.tbl_ratingsAndComments.layoutIfNeeded()
                cell.height_innerTableView.constant = cell.tbl_ratingsAndComments.contentSize.height// + 50.0
                return cell
            }
            //            else if(indexPath.section == 5)
            //            {
            //                let cell = tableView.dequeueReusableCell(withIdentifier: "ViewRecipeNotesTableCell", for: indexPath) as! ViewRecipeNotesTableCell
            ////                cell.lbl_myNotes.text =
            //                cell.lbl_recipeNotes.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
            //
            //                return cell
            //            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RateRecipeTableCell", for: indexPath) as! RateRecipeTableCell
                cell.setUp()
                cell.del = self
                return cell
            }
        }
        else
        {
            if(indexPath.section == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsandRatingCell", for: indexPath) as! ReviewsandRatingCell
                let dict = recipeDtails.recipeInfo?.reviewAndComment
                startPercentage.removeAll()
                startPercentage.append(String(dict?.oneStarPercentage ?? 0))
                startPercentage.append(String(dict?.twoStarPercentage ?? 0))
                startPercentage.append(String(dict?.threeStarPercentage ?? 0))
                startPercentage.append(String(dict?.fourStarPercentage ?? 0))
                startPercentage.append(String(dict?.fiveStarPercentage ?? 0))
                cell.starPercentageLabel.text = startPercentage[indexPath.row]
                progressArray.removeAll()
                progressArray.append(Double(dict?.oneStarPercentage ?? 0))
                progressArray.append(Double(dict?.twoStarPercentage ?? 0))
                progressArray.append(Double(dict?.threeStarPercentage ?? 0))
                progressArray.append(Double(dict?.fourStarPercentage ?? 0))
                progressArray.append(Double(dict?.fiveStarPercentage ?? 0))
                cell.progressView.progress = CGFloat(progressArray[indexPath.row])
                cell.startLabel.text = startArray[indexPath.row]
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
                let dict = recipeCommentList.commentedUserList?[indexPath.row]
                cell.nameLabel.text = dict?.userName?.capitalized
                cell.ratingView.rating = Double(dict?.rating ?? 0)
                cell.dateAndTimeLabel.text = dict?.dateAndTime
                cell.commentLabel.text = dict?.userComment?.capitalized
                cell.helfulLabel.text = "Helpful (" + String(dict?.helpfulCount ?? 0) + " )"
                cell.notHelfulLabel.text = "Not Helpful (" + String(dict?.notHelpfulCount ?? 0) + " )"
                cell.reportLabel.text = "Report (" + String(dict?.reportCount ?? 0) + " )"
                cell.profilePic.sd_setImage(with: URL(string: dict?.profilePic ?? "" ), placeholderImage: UIImage(named: "dinner"))
                
                return cell
            }
        }
    }
}

extension ViewRecipeViewController {
    func getRecipeDetailsApi()
    {
        let param:[String:Any] = ["recipe_id": recipeId,
                                  "recipe_owner_id": recipeOwnerId]
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getRecipeDetails, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.recipeDtails = try JSONDecoder().decode(RecipeDetailsStruct.self, from: data)
                            DispatchQueue.main.async {
                                self.dataParshing()
                            }
                        }
                        catch
                        {
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                        }
                    }
                    else
                    {
                        Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: GlobalClass.sharedManager.get_status.message)
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: GlobalClass.sharedManager.get_status.message)
                }
                // SVProgressHUD.dismiss()
                Loader.sharedInstance.hideIndicator()
                break
                
            case .failer(let error):
                
                Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                Loader.sharedInstance.hideIndicator()
                break
            }
        }
    }
    
    func getRecipecommentsApi(CommentType:String)
    {
        let param:[String:Any] = ["recipe_id": recipeId,
                                  "comment_filter": commentFillerType]
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getRecipeComments, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.recipeCommentList = try JSONDecoder().decode(RecipeCommentStruct.self, from: data)
                            //  DispatchQueue.main.async {
                            //     self.tableView.reloadData()
                            //     self.dataParshing()
                            //   }
                        }
                        catch
                        {
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                        }
                    }
                    else
                    {
                        Alert.showToast(message: GlobalClass.sharedManager.get_status.message, view_VC: self)
                    
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: GlobalClass.sharedManager.get_status.message)
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
    
    func dataParshing(){
        self.lbl_titleRecipe.text = recipeDtails.recipeInfo?.recipeName
        txtView_description.text = recipeDtails.recipeInfo?.recipeDescription
        self.viewratting.rating = Double(recipeDtails.recipeInfo?.ratting ?? 0)
        collection_recipe.reloadData()
        tbl_recipeDetails.reloadData()
        page_recipe.numberOfPages = recipeDtails.imageList?.count ?? 0
        let arrayCommenttype: [String] = self.recipeDtails.recipeInfo?.commentedUserFilterType?.map{String($0.name ?? "")} ?? []
        CommenttypeDropDown.dataSource = arrayCommenttype
    }
}

extension ViewRecipeViewController:addCommentProtocol {
    func addComment(comment: String, ratting: Double) {
        Addcommentapi(comment: comment, ratting: ratting)
    }

    func Addcommentapi(comment: String, ratting: Double){
        let param:[String:Any] = ["recipe_id": recipeId,
                                  "recipe_type":1,
                                  "rate_star":ratting,
                                  "comment":comment]
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.recipeRating, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.addCommentStatus = try JSONDecoder().decode(AppRating_Struct.self, from: data)
                            Alert.show(vc: self, titleStr: Alert.kTitle, messageStr: self.addCommentStatus.message)
                            self.getRecipeDetailsApi()
                            self.getRecipecommentsApi(CommentType: self.commentFillerType)
                        }
                        catch
                        {
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                        }
                    }
                    else
                    {
                        Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: GlobalClass.sharedManager.get_status.message)
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: GlobalClass.sharedManager.get_status.message)
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
