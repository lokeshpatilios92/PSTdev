//
//  RecipeInfoTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 20/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Tags

class RecipeInfoTableCell: UITableViewCell {
    
    @IBOutlet var view_main: UIView!
    @IBOutlet var tagsView: TagsView!
    @IBOutlet var lbl_type: UILabel!
    @IBOutlet var lbl_mainingridient: UILabel!
    @IBOutlet var lbl_diettype: UILabel!
    @IBOutlet var lbl_course: UILabel!
    @IBOutlet var lbl_season: UILabel!
    @IBOutlet var lbl_link: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view_main.layer.borderWidth = 0.3
        view_main.layer.borderColor = UIColor.lightGray.cgColor
        view_main.layer.cornerRadius = 3.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func config(dict:RecipeInfo?){
        tagsView.tags = dict?.tags ?? ""
        lbl_link.text = dict?.recipeLink ?? ""
        lbl_type.text = dict?.audience
        let mainingridientArr: [String] = dict?.mainIngredients?.map{String($0.mainIngredientName ?? "")} ?? []
        let MainIngridient = mainingridientArr.joined(separator:" , ")
        
        let dietarr: [String] = dict?.dietType?.map{String($0.dietTypeName ?? "")} ?? []
        let diet = dietarr.joined(separator:" , ")
        
        let coursearr: [String] = dict?.course?.map{String($0.courseTypeName ?? "")} ?? []
        let course = coursearr.joined(separator:" , ")
        
        let seasonarr: [String] = dict?.season?.map{String($0.seasonName ?? "")} ?? []
        let season = seasonarr.joined(separator:" , ")
    
        lbl_mainingridient.text = MainIngridient
        lbl_diettype.text = diet
        lbl_course.text = course
        lbl_season.text = season
    }
    
}
