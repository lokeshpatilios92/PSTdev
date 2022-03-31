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
    let nutritionCollectionViewCell = "NutritionCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib.init(nibName: nutritionCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: nutritionCollectionViewCell)
    }
}

extension EditNutritionalInfoViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NutritionCollectionViewCell", for: indexPath) as! NutritionCollectionViewCell
        cell.progressView.maxValue = 1000.0
        cell.progressView.value = 500.0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 140.0)
    }
}
