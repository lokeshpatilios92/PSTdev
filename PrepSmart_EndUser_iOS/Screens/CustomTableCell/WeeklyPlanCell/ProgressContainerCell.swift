//
//  ProgressContainerCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 09/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ProgressContainerCell: UITableViewCell {

   
    @IBOutlet var lockBtn: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var forwardArrowBtn: UIButton!
    
    var progressViewCell = "ProgressViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: progressViewCell, bundle: nil), forCellWithReuseIdentifier: progressViewCell)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: collectionView.frame.width, height: 110)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.isPagingEnabled = true
        collectionView.collectionViewLayout = layout
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate : UICollectionViewDelegate & UICollectionViewDataSource, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        
        collectionView.register(UINib.init(nibName: progressViewCell, bundle: nil), forCellWithReuseIdentifier: progressViewCell)
        collectionView.reloadData()
    }
    
}
