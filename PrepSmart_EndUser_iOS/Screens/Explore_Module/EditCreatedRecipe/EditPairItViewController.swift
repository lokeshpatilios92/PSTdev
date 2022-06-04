//
//  EditPairItViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 11/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class EditPairItViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var txtFieldReceipes : UITextField!
    var parentVC: EditCreatedRecipeViewController?
    @IBOutlet var scrollView: UIScrollView!
    let nutritionalInfoCollectionCell = "NutritionalInfoCollectionCell"
    
    var recipeDtails: RecipeDetailsStruct?
    private var recepies = [Recipes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getReceipeList()
        self.setCollectionViewLayout()
    }
    
    func setCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width - 80, height: 170)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.register(UINib.init(nibName: nutritionalInfoCollectionCell, bundle: nil), forCellWithReuseIdentifier: nutritionalInfoCollectionCell)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let vc = self.storyboard?.instantiateViewController(identifier: "MultiPickerController") as! MultiPickerController
        let mainIngredients = recepies.map { $0.recipe_name } as! [String]
        vc.items = mainIngredients
        vc.modalPresentationStyle = .overCurrentContext
        vc.allItems = { item in
            self.txtFieldReceipes.text = item.joined(separator: ",")
        }
        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController?.present(vc, animated: true, completion: nil)
        self.txtFieldReceipes.resignFirstResponder()
    }
}

extension EditPairItViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recipeDtails?.recipeInfo?.pairWithList?.count ?? 0
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nutritionalInfoCollectionCell, for: indexPath) as! NutritionalInfoCollectionCell
        let pairItWith = self.recipeDtails?.recipeInfo?.pairWithList?[indexPath.row]
        cell.lblTitle.text = pairItWith?.recipeName
        cell.imgTitle.sd_setImage(with: URL(string: pairItWith?.image ?? ""), placeholderImage: UIImage(named: "dinner"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 140.0)
    }
    
    
    
    func getReceipeList() {
        Loader.sharedInstance.showIndicator()
        
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.getRecipeList, params: nil , method: .get) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            if let receipeList = dict["recipe_list"] as? [[String: Any]], let data = try? JSONSerialization.data(withJSONObject: receipeList, options: [.prettyPrinted]) {
                                self.recepies = try JSONDecoder().decode([Recipes].self, from: data)
                            }

                        }
                        catch (let error){
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                        }
                    }
                    else
                    {
                        Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: "")
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: "")
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
