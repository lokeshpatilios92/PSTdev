//
//  ChefProfileViewController.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 13/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD046, PSTMOBSTD050
    

import UIKit
import Tags

class ChefProfileViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var chefNameLabel: UILabel!
    
    @IBOutlet weak var recipesCountLabel: UILabel!
    @IBOutlet weak var blogsCountLabel: UILabel!
    @IBOutlet weak var subscribCoutLabel: UILabel!
    @IBOutlet weak var descLable: UILabel!
    
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var consultationsButton: UIButton!
    @IBOutlet weak var readMoreButton: UIButton!
    
    @IBOutlet weak var usernameTextFiled: KKNEWTextFiled!
    
    @IBOutlet weak var tagsView: TagsView!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    var sectionArray : [String] = ["Top Premium Recipes", "Top Recipes", "Top Recipes Packs", "Top Blogs", "Amazon Products"]
    
    let myProfileTableViewCell = "MyProfileTableViewCell"
    let profileCollectionCell = "ProfileCollectionCell"
    var chefId = 0
    var chefProfileObj: ChefProfile_Struct?
    var global_Var = GlobalClass.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
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
    
    override func viewWillLayoutSubviews() {
        DispatchQueue.main.async {
            self.tableViewHeightConstraint.constant = 160 * 5
        }
    }
    
    func initialize() {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Chef Profile")
       // self.navigationItem.rightBarButtonItem = addSettingNavButton()
        
        tableView.register(UINib.init(nibName: myProfileTableViewCell, bundle: nil), forCellReuseIdentifier: myProfileTableViewCell)
        
        self.consultationsButton.layer.cornerRadius = 8
        
        self.editProfileButton.layer.cornerRadius = 8
        self.editProfileButton.layer.borderWidth = 1
        self.editProfileButton.layer.borderColor = UIColor.textColor().cgColor
        self.chefProfileApi()
    }
    
    func profileData()
    {
        let dic = chefProfileObj?.user_data
        chefNameLabel.text = dic?.user_name
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.sd_setImage(with: URL(string: dic?.user_pic ?? ""), placeholderImage: UIImage(named: "dinner"))
        recipesCountLabel.text = String(dic?.recipe_count ?? 0) + "\nRecipes"
        blogsCountLabel.text = String(dic?.blog_count ?? 0) + "\nBlocks"
        subscribCoutLabel.text = String(dic?.subscribers_count ?? 0) + "\nSubscribers"
        commentCountLabel.text = String(dic?.comments_count ?? 0)
        descLable.text = dic?.bio
        
    }
    
    @IBAction func onClickConsultationButton(_ sender: Any) {
        let vc = UIStoryboard.EndUser_AuxilaryStoryboard.instantiateViewController(withIdentifier: "ConsultationVC") as! ConsultationVC
        vc.chefId = self.chefProfileObj?.user_data?.user_id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickNextButton(_ sender : UIButton){
//        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "BlogsVC") as! BlogsVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickShowTagsBtn(_ sender: UIButton)
    {
        self.showTopTagsPopUp(customDelegate: self, chefTopTags:self.chefProfileObj?.user_data?.top_tags ?? [Top_tags]())
    }
    
    @IBAction func facebookClick(_ sender: UIButton)
    {
        guard let url = URL(string: self.chefProfileObj?.user_data?.fb_url ?? "") else { return }
        UIApplication.shared.open(url)

    }
    @IBAction func googleClick(_ sender: UIButton)
    {
        guard let url = URL(string: self.chefProfileObj?.user_data?.google_url ?? "") else { return }
        UIApplication.shared.open(url)

    }
    @IBAction func linkedinClick(_ sender: UIButton)
    {
        guard let url = URL(string: self.chefProfileObj?.user_data?.linkedin_url ?? "") else { return }
        UIApplication.shared.open(url)

    }
    @IBAction func pinterestClick(_ sender: UIButton)
    {
        guard let url = URL(string: self.chefProfileObj?.user_data?.pinterest_url ?? "") else { return }
        UIApplication.shared.open(url)

    }
    @IBAction func twitterkClick(_ sender: UIButton)
    {
        guard let url = URL(string: self.chefProfileObj?.user_data?.twitter_url ?? "") else { return }
        UIApplication.shared.open(url)

    }
    @IBAction func webClick(_ sender: UIButton)
    {
        guard let url = URL(string: self.chefProfileObj?.user_data?.site_url ?? "") else { return }
        UIApplication.shared.open(url)

    }
    @IBAction func amazonClick(_ sender: UIButton)
    {
        guard let url = URL(string: self.chefProfileObj?.user_data?.amazon_url ?? "") else { return }
        UIApplication.shared.open(url)

    }
}

//    MARK: UITableViewDelegate, UITableViewDataSource
extension ChefProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myProfileTableViewCell, for: indexPath) as! MyProfileTableViewCell
        cell.nextBtn.addTarget(self, action: #selector(self.onClickNextButton(_:)), for: .touchUpInside)
        cell.titleLabel.text = sectionArray[indexPath.row]
        cell.initializeCollectionView(nibName: profileCollectionCell, collectionViewDataSource: self, collectionViewDelegate: self, collectionViewTag: indexPath.row)
        cell.collectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
}

//    MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ChefProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dic = self.chefProfileObj?.user_data
        
        
        if collectionView.tag == 0
        {
            if let count = dic?.top_premium_recipe?.count
            {
                return count
            }
        }
        else if collectionView.tag == 1
        {
            if let count = dic?.top_recipe?.count
            {
                return count
            }
        }
        else if collectionView.tag == 2
        {
            if let count = dic?.top_recipe_pack?.count
            {
                return count
            }
        }
        else if collectionView.tag == 3
        {
            if let count = dic?.top_blog?.count
            {
                return count
            }
        }
        else if collectionView.tag == 4
        {
            if let count = dic?.affiliate_prod_urls?.count
            {
                return count
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCollectionCell, for: indexPath) as! ProfileCollectionCell
        
        if collectionView.tag == 0
        {
            let dic = self.chefProfileObj?.user_data?.top_premium_recipe?[indexPath.row]
            //cell.itemImageView.sd_setImage(with: URL(string: dic?.product_image ?? ""), placeholderImage: UIImage(named: "dinner"))
            
        }
        else if collectionView.tag == 1
        {
            let dic = self.chefProfileObj?.user_data?.top_recipe?[indexPath.row]
            //cell.itemImageView.sd_setImage(with: URL(string: dic?.product_image ?? ""), placeholderImage: UIImage(named: "dinner"))
        }
        else if collectionView.tag == 2
        {
            let dic = self.chefProfileObj?.user_data?.top_recipe_pack?[indexPath.row]
            //cell.itemImageView.sd_setImage(with: URL(string: dic?.product_image ?? ""), placeholderImage: UIImage(named: "dinner"))
        }
        else if collectionView.tag == 3
        {
            let dic = self.chefProfileObj?.user_data?.top_blog?[indexPath.row]
            //cell.itemImageView.sd_setImage(with: URL(string: dic?.product_image ?? ""), placeholderImage: UIImage(named: "dinner"))
        }
        else if collectionView.tag == 4
        {
            let dic = self.chefProfileObj?.user_data?.affiliate_prod_urls?[indexPath.row]
            cell.itemImageView.sd_setImage(with: URL(string: dic?.product_image ?? ""), placeholderImage: UIImage(named: "dinner"))
        }
        
        cell.itemImageView.layer.cornerRadius = 5
        cell.itemTitle.text = ""
        return cell
    }
    
}


extension ChefProfileViewController : CustomTopTagsPopUpDelegate
{
    
}

extension ChefProfileViewController
{
    func chefProfileApi()
     {
         let param:[String:Any] = ["chef_id":self.chefId]
                 Loader.sharedInstance.showIndicator()

         Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getChefProfile, params: param , method: .post) { (result) in
             switch result
             {
             case .success(let data, let dictionary):

                 if let dict : NSDictionary = dictionary as? NSDictionary
                 {
                     if let status = dict["status"] as? Bool, status == true
                     {
                            Loader.sharedInstance.hideIndicator()
                         do {
                             self.chefProfileObj = try JSONDecoder().decode(ChefProfile_Struct.self, from: data)
                             self.profileData()
                             self.tableView.reloadData()
                           
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
