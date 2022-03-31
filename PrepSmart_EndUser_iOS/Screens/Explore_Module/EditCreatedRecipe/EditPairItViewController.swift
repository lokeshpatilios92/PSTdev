//
//  EditPairItViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 11/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class EditPairItViewController: UIViewController {
    @IBOutlet weak var collectionView : UICollectionView!
    var parentVC: EditCreatedRecipeViewController?
    @IBOutlet var scrollView: UIScrollView!
    let nutritionalInfoCollectionCell = "NutritionalInfoCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

extension EditPairItViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nutritionalInfoCollectionCell, for: indexPath) as! NutritionalInfoCollectionCell
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100.0, height: 140.0)
//    }
}
