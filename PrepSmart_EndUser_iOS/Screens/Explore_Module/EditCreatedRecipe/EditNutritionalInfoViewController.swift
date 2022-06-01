//
//  EditNutritionalInfoViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 11/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class EditNutritionalInfoViewController: UIViewController {
    @IBOutlet weak var collectionView : UICollectionView!
    var parentVC: EditCreatedRecipeViewController?
    @IBOutlet var scrollView: UIScrollView!
    var recipeDtails: RecipeDetailsStruct?
    
    let nutritionCollectionViewCell = "NutritionCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "NutritionProgressCollectionCell", bundle: nil), forCellWithReuseIdentifier: "NutritionProgressCollectionCell")
    }
}

extension EditNutritionalInfoViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  recipeDtails?.recipeInfo?.nutritionalInformation?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NutritionProgressCollectionCell", for: indexPath) as! NutritionProgressCollectionCell
        let dict = recipeDtails?.recipeInfo?.nutritionalInformation?[indexPath.row]
        cell.viewProgress1.startProgress(to: CGFloat(dict?.calorificValue ?? 0), duration: 3)
        cell.viewProgress2.startProgress(to: CGFloat(dict?.totalCarbPercentage ?? 0), duration: 3)
        cell.viewProgress3.startProgress(to: CGFloat(dict?.totalProteinPercentage ?? 0), duration: 3)
        cell.viewProgress4.startProgress(to: CGFloat(dict?.totalFatPercentage ?? 0), duration: 3)
        cell.viewProgress4.startProgress(to: CGFloat(dict?.totalFatPercentage ?? 0), duration: 10.0) {
            print("Done animating!")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 140.0)
    }
}
