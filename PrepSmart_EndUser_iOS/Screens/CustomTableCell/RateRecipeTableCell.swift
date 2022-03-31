//
//  RateRecipeTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 20/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Cosmos
protocol addCommentProtocol{
    func addComment(comment:String,ratting:Double)
}
class RateRecipeTableCell: UITableViewCell {
    
    @IBOutlet var view_main: UIView!
    @IBOutlet var rateView: CosmosView!
    @IBOutlet var lbl_chefName: UILabel!
    @IBOutlet var btn_submit: UIButton!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var txtView_comment: UITextView!
    @IBOutlet var lbl_rateComment: UILabel!
    var del:addCommentProtocol? = nil
  
    @IBAction func SubmitAction(_ sender: Any) {
        del?.addComment(comment: txtView_comment.text, ratting: rateView.rating)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtView_comment.layer.borderWidth = 0.5
        txtView_comment.layer.borderColor = UIColor.lightGray.cgColor
        txtView_comment.layer.cornerRadius = 3.0
        
        view_main.layer.borderWidth = 0.3
        view_main.layer.borderColor = UIColor.lightGray.cgColor
        view_main.layer.cornerRadius = 3.0
        
        imgView.layer.cornerRadius = imgView.frame.size.height / 2
        btn_submit.layer.cornerRadius = btn_submit.frame.size.height / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        txtView_comment.text = ""
        rateView.rating = 0.0
    }
    
    func setUp(){
        let globalVar = GlobalClass.sharedManager.logindicObj?.userData
        imgView.sd_setImage(with: URL(string: globalVar?.profile_pic ?? ""), placeholderImage: UIImage(named: "dinner"))
        lbl_chefName.text = globalVar?.name?.capitalized
        imgView.layer.cornerRadius = imgView.frame.height/2
        imgView.layer.borderWidth = 0.5
        imgView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imgView.contentMode = .scaleAspectFit
    }
    
}
