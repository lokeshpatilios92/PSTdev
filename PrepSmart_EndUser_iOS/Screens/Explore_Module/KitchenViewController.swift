//
//  KitchenViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 09/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD065

import UIKit

class KitchenViewController: BaseViewController {

    @IBOutlet weak var collectionView   : UICollectionView!
    
    let kitchenCollectionCell = "KitchenCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    func initialize() {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Ceasar Salad")

        // Initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 50, left: 10, bottom: 50, right: 10)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - 80 )
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 50
        
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: kitchenCollectionCell, bundle: nil), forCellWithReuseIdentifier: kitchenCollectionCell)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self

    }
}

extension KitchenViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    //    MARK: UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kitchenCollectionCell, for: indexPath) as! KitchenCollectionCell
        
        cell.stepCountLabel.text = "\(indexPath.item + 1)/8"
        if indexPath.row == 0 {
            cell.topButton.isHidden = true
        }
        if indexPath.row == 7 {
            cell.bottomButton.isHidden = true
        }
        
        return cell
    }
    
}
