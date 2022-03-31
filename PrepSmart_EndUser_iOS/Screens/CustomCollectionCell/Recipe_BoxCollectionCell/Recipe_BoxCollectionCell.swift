//
//  Recipe_BoxCollectionCell.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 31/05/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage

class Recipe_BoxCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView    : UIImageView!
    @IBOutlet weak var labelImageView0  : UIImageView!
    @IBOutlet weak var labelImageView1  : UIImageView!
    @IBOutlet weak var labelImageView2  : UIImageView!
    @IBOutlet weak var labelImageView3  : UIImageView!
    @IBOutlet weak var labelImageView4  : UIImageView!
    
    @IBOutlet weak var recipeImageView0 : UIImageView!
    @IBOutlet weak var recipeImageView1 : UIImageView!
    @IBOutlet weak var recipeImageView2 : UIImageView!
    
    @IBOutlet weak var cosmosStarView   : CosmosView!
    
    @IBOutlet weak var ratingLabel      : UILabel!
  //  @IBOutlet weak var amountLabel      : UILabel!
    @IBOutlet weak var itemTitleLabel   : UILabel!
   
    @IBOutlet weak var view_favorit : UIView!
    @IBOutlet weak var img_favorit : UIImageView!
    @IBOutlet weak var btn_favorit : UIButton!
    @IBOutlet weak var btn_addTo: UIButton!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var lockView: UIView!
    @IBOutlet weak var lockImgView: UIImageView!
    @IBOutlet weak var freeBackView: UIView!
    @IBOutlet weak var freeTitleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        cosmosStarView.isUserInteractionEnabled = false
        self.view_favorit.layer.cornerRadius = self.view_favorit.frame.height / 2
            self.freeBackView.layer.cornerRadius = self.freeBackView.frame.height / 2
    }
    
    func setCellImages(itemImage:String?, label0Image:UIImage?, label1Image:UIImage?, label2Image:UIImage?, label3Image:UIImage?, label4Image:UIImage?, recipe0Image:UIImage?, recipe1Image:UIImage?, recipe2Image:UIImage?) {
        
        itemImageView.sd_setImage(with: URL(string: itemImage ?? ""), placeholderImage: UIImage(named: "dinner"))

        if label0Image == nil {
            labelImageView0.isHidden = true
        } else {
            labelImageView0.image = label0Image
        }
        if label1Image == nil {
            labelImageView1.isHidden = true
        } else {
            labelImageView1.image = label1Image
        }
        if label2Image == nil {
            labelImageView2.isHidden = true
        } else {
            labelImageView2.image = label2Image
        }
        if label3Image == nil {
            labelImageView3.isHidden = true
        } else {
            labelImageView3.image = label3Image
        }
        if label4Image == nil {
            labelImageView4.isHidden = true
        } else {
            labelImageView4.image = label4Image
        }
        
        if recipe0Image == nil {
            recipeImageView0.isHidden = true
        } else {
            recipeImageView0.image = recipe0Image
        }
        if recipe1Image == nil {
            recipeImageView1.isHidden = true
        } else {
            recipeImageView1.image = recipe1Image
        }
        if recipe2Image == nil {
            recipeImageView2.isHidden = true
        } else {
            recipeImageView2.image = recipe2Image
        }
    }
    
    func setContainData(itemTitle:String, amountString:String, rating:String, starValue:Double) {
        ratingLabel.text    = rating
     // amountLabel.text    = "\(amountString)"
        itemTitleLabel.text = itemTitle
        cosmosStarView.rating = starValue
     // amountLabel.setFont(.REGULAR_FONT(), string: amountString)
    }
    
    func config(dict: RecipeList?){
        itemTitleLabel.text = dict?.item_title?.capitalized
        if let rating = dict?.ratting {
                    switch rating {
                    case .integer(let int):
                        cosmosStarView.rating = Double(int)
                        ratingLabel.text = "(\(int))"
                    case .string(let string):
                        cosmosStarView.rating = Double(string) ?? 0.0
                        ratingLabel.text = "(\(string))"
                    }
                }
        itemImageView.sd_setImage(with: URL(string: dict?.item_image ?? ""), placeholderImage: UIImage(named: "recipe-img-23"))
        if dict?.item_label == "Recipe Weekly Plan Template"
        {
            freeTitleLbl.text = "Weekly Plan"
        } else {
            freeTitleLbl.text = dict?.item_label?.capitalized
        }
    }
}
