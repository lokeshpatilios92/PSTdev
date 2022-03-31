//
//  MyProfileTableViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 14/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class MyProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var nextBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initializeCollectionView(nibName: String, collectionViewDataSource : UICollectionViewDataSource, collectionViewDelegate : UICollectionViewDelegate, collectionViewTag: Int) {
        // Initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        
        
       // collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.tag = collectionViewTag
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
       // collectionView.reloadData()
    }
}
