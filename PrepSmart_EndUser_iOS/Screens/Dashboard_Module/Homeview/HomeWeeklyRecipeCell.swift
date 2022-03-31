//
//  HomeWeeklyRecipeCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by apple on 17/03/22.
//  Copyright © 2022 Exceptionaire.co. All rights reserved.
//

import UIKit

class HomeWeeklyRecipeCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle1:UILabel!
    @IBOutlet weak var lblTitle2:UILabel!
    @IBOutlet weak var lblTitle3:UILabel!
    @IBOutlet weak var lblRecipeCount:UILabel!
    @IBOutlet weak var lblNoRecipy:UILabel!
    @IBOutlet weak var view:UIView!
    @IBOutlet weak var imgTitle1:UIImageView!
    @IBOutlet weak var imgTitle2:UIImageView!
    @IBOutlet weak var imgTitle3:UIImageView!
    
    func Configure(dayData:DaysList?){
        imgTitle1.layer.cornerRadius = 25
        imgTitle2.layer.cornerRadius = 25
        imgTitle3.layer.cornerRadius = 25

        if dayData?.todaysRecipeList?.count == 0 {
            lblNoRecipy.isHidden = false
            view.isHidden = true
        }
        else{
            lblNoRecipy.isHidden = true
            view.isHidden = false
            lblRecipeCount.text = "Today's Recipes (\(dayData?.todaysRecipeList?.count ?? 0))"
            switch dayData?.todaysRecipeList?.count {
        case 1 :
                lblTitle1.text = dayData?.todaysRecipeList?[0].recipeName
                imgTitle1.sd_setImage(with: URL(string: dayData?.todaysRecipeList?[0].recipeImg ?? ""), placeholderImage: UIImage(named: "dinner"))
                lblTitle2.isHidden = true
                lblTitle3.isHidden = true
                imgTitle2.isHidden = true
                imgTitle3.isHidden = true
        case 2 :
                lblTitle1.text = dayData?.todaysRecipeList?[0].recipeName
                lblTitle2.text = dayData?.todaysRecipeList?[1].recipeName
                imgTitle1.sd_setImage(with: URL(string: dayData?.todaysRecipeList?[0].recipeImg ?? ""), placeholderImage: UIImage(named: "dinner"))
                imgTitle2.sd_setImage(with: URL(string: dayData?.todaysRecipeList?[1].recipeImg ?? ""), placeholderImage: UIImage(named: "dinner"))
                lblTitle3.isHidden = true
                imgTitle3.isHidden = true
        case 3 :
                lblTitle1.text = dayData?.todaysRecipeList?[0].recipeName
                lblTitle2.text = dayData?.todaysRecipeList?[1].recipeName
                lblTitle3.text = dayData?.todaysRecipeList?[2].recipeName
                imgTitle1.sd_setImage(with: URL(string: dayData?.todaysRecipeList?[0].recipeImg ?? ""), placeholderImage: UIImage(named: "dinner"))
                imgTitle2.sd_setImage(with: URL(string: dayData?.todaysRecipeList?[1].recipeImg ?? ""), placeholderImage: UIImage(named: "dinner"))
                imgTitle3.sd_setImage(with: URL(string: dayData?.todaysRecipeList?[2].recipeImg ?? ""), placeholderImage: UIImage(named: "dinner"))
        default :
                print("3")
            }
        }
    }
}
