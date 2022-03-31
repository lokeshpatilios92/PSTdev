//
//  ExploreRecipePackDetailsViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 08/11/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD038

import UIKit

class ExploreRecipePackDetailsViewController: BaseViewController {
    
    @IBOutlet weak var searchBar        : UISearchBar!
    @IBOutlet weak var collectionView   : UICollectionView!
// @IBOutlet weak var viewByBgView     : UIView!
//    @IBOutlet weak var viewByLabel: UILabel!
    @IBOutlet weak var totalItemsCountLabel: UILabel!
    @IBOutlet weak var view_height: NSLayoutConstraint!
    
    @IBOutlet weak var constraint_CollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBarView: UIView!
    
    @IBOutlet weak var lbl_Description  : UILabel!
    @IBOutlet weak var lbl_Category     : UILabel!
    @IBOutlet weak var lbl_DietType     : UILabel!
    @IBOutlet weak var lbl_Tags         : UILabel!
    @IBOutlet weak var lbl_Season       : UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var deatailsView: UIStackView!
    @IBOutlet weak var arrowImg: UIImageView!

    @IBOutlet weak var linkBtn: UIButton!
    @IBOutlet weak var Btn_readMore: UIButton!
    
    let recipe_BoxCollectionCell    = "Recipe_BoxCollectionCell"
    var recipyPackId = 0
    var recipyChefId = 0
    var RecipePackDetailsData:GetRecipePackDetailsStruct?
    var global_Var = GlobalClass.sharedManager
    var isComingFrom = 0 //0:Default 1:Coming from add Recipe pack
    
    var recipeArray : [UIImage] = [#imageLiteral(resourceName: "recipe-img-15"),#imageLiteral(resourceName: "recipe-img-7"),#imageLiteral(resourceName: "recipe-img-13"),#imageLiteral(resourceName: "recipe-img-17"), #imageLiteral(resourceName: "recipe-img-16"),#imageLiteral(resourceName: "recipe-img-9"),#imageLiteral(resourceName: "recipe-img-6"),#imageLiteral(resourceName: "recipe-img-18")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
    }
    
    func initializer(){
        
        if isComingFrom == 1{
            self.navigationItem.titleView = UtilityManager.getTitleLabel("View Recipe Pack")
            self.navigationItem.rightBarButtonItem = addViewRecipeEditButton()
        }else{
            self.navigationItem.titleView = UtilityManager.getTitleLabel("Explore Recipe Pack")
        }
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = .clear
        searchBar.isTranslucent = true
        searchBar.layer.borderColor = UIColor.black.cgColor
        searchBarView.layer.borderWidth = 0.50
        searchBarView.layer.cornerRadius = searchBarView.frame.height / 2
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: UISearchBar.Icon.search, state: .normal)
        // Initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (view.frame.width) / 2 - 15, height: view.frame.width / 2)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: recipe_BoxCollectionCell, bundle: nil), forCellWithReuseIdentifier: recipe_BoxCollectionCell)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        self.viewByBgView.layer.cornerRadius = viewByBgView.frame.height / 2
//        self.viewByBgView.layer.borderColor = UIColor.black.cgColor
//        self.viewByBgView.layer.borderWidth = 0.50
        
        let width = self.view.frame.width / 2
        let height : CGFloat = width * CGFloat((self.recipeArray.count / 2))
        self.constraint_CollectionViewHeight.constant = height + 50
        
        self.linkBtn.setTextUnderline(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), string: self.linkBtn.currentTitle ?? "")
        Btn_readMore.isHidden = false
        Api_getRecipePackDetails()
       
    }
    
    func calculateViewHeight(){
        let height = backView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = backView.frame
        frame.size.height = height
        backView.frame = frame
        self.view_height.constant = backView.frame.size.height
    }
    
    func setData() {
        if RecipePackDetailsData?.getRecipePackDetailsStructDescription?.count ?? 0 < 100 {
            Btn_readMore.isHidden = true
        }
        self.totalItemsCountLabel.text = "\(RecipePackDetailsData?.listOfRecipes?.count ?? 0) result found"

        self.lbl_Description.text = RecipePackDetailsData?.getRecipePackDetailsStructDescription
        let dietArray: [String] = self.RecipePackDetailsData?.dietType?.map{String($0.dietTypeName ?? "")} ?? []
        let diet = dietArray.joined(separator:" , ")
        
        let seasonArray: [String] = self.RecipePackDetailsData?.season?.map{String($0.seasonName ?? "")} ?? []
        let season = seasonArray.joined(separator:" , ")
        
        let catArray: [String] = self.RecipePackDetailsData?.category.map{String($0.cat_name ?? "")} ?? []
        let catogory = catArray.joined(separator:" , ")
        
        self.lbl_Category.text = catogory
        self.lbl_DietType.text = diet
        self.lbl_Tags.text =  self.RecipePackDetailsData?.tag
        self.lbl_Season.text = season

    }
    @IBAction func collapseClicked(_ sender: UIButton) {
        if deatailsView.isHidden == false{
            deatailsView.isHidden = true
            self.view_height.constant = 0
            arrowImg.image = UIImage(named: "arrow_down")
        }
        else {
            deatailsView.isHidden = false
            self.view_height.constant = 250
            arrowImg.image = UIImage(named: "arrow_up")
        }
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
        if self.lbl_Description.numberOfLines == 0{
            self.Btn_readMore.isHidden = false
        }
    }
    
    @IBAction func readMoreTapped(_ sender: UIButton) {
        self.lbl_Description.numberOfLines = 0
        Btn_readMore.isHidden = true
       // calculateViewHeight()
    }
    
    @IBAction func linkClicked(_ sender: UIButton) {
        guard let url = URL(string: linkBtn.currentTitle ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
    
}

extension ExploreRecipePackDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    //    MARK: UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RecipePackDetailsData?.listOfRecipes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipe_BoxCollectionCell, for: indexPath) as! Recipe_BoxCollectionCell
        
        let dict = RecipePackDetailsData?.listOfRecipes?[indexPath.row]
        
        cell.setCellImages(itemImage: dict?.recipeImage ?? "", label0Image: #imageLiteral(resourceName: "recipe-pack"), label1Image: nil, label2Image: nil, label3Image: nil, label4Image: nil, recipe0Image: #imageLiteral(resourceName: "recipe-img-20"), recipe1Image: #imageLiteral(resourceName: "recipe-img-7"), recipe2Image: #imageLiteral(resourceName: "recipe-img-24"))
        
        if dict?.recipeLabel == "Recipe Weekly Plan Template"
        {
            cell.freeTitleLbl.text = "Weekly Plan"
        } else {
            cell.freeTitleLbl.text = dict?.recipeLabel?.capitalized
        }
        cell.setContainData(itemTitle: dict?.recipeLabel ?? "",
                            amountString: "",
                            rating: "(\(dict?.ratting ?? 0))",
                            starValue: Double(dict?.ratting ?? 0))
        
        
        if dict?.prepsmartFlag == 1 {
            cell.lockImgView.image = UIImage(named : "lock_icon")
            cell.lockView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dict = RecipePackDetailsData?.listOfRecipes?[indexPath.row]
        if dict?.prepsmartFlag == 1 {
        showAlertWithOkButtonPopUpVC(setTitle: "", setMessage: "Subscribe now for immediate access to all content.", setButtonTitle: "Learn More", customDelegate: nil)
        }
        else {
            let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "ViewRecipeViewController") as! ViewRecipeViewController
            vc.recipeId = String(dict?.itemID ?? 0)
            vc.recipeOwnerId = String(dict?.chefID ?? 0)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ExploreRecipePackDetailsViewController {
    func Api_getRecipePackDetails(){
        let param:[String:Any] = ["recipe_pack_id": self.recipyPackId ,
                                  "user_id": self.recipyChefId]
                Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getRecipePackDetails, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):

                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.RecipePackDetailsData = try JSONDecoder().decode(GetRecipePackDetailsStruct.self, from: data)
                           // self.filterFindNewRecipeObj = self.findNewRecipeObj
                            self.collectionView.reloadData()
                            self.setData()
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



extension UILabel {

    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText

        let lengthForVisibleString: Int = self.vissibleTextLength
        let mutableString: String = self.text!
        let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.text?.count)! - lengthForVisibleString)), with: "")
        let readMoreLength: Int = (readMoreText.count)
        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: ((trimmedString?.count ?? 0) - readMoreLength), length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.attributedText = answerAttributed
    }

    var vissibleTextLength: Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)

        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedString.Key : Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)

        if boundingRect.size.height > labelHeight {
            var index: Int = 0
            var prev: Int = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
                }
            } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
            return prev
        }
        return self.text!.count
    }
}
