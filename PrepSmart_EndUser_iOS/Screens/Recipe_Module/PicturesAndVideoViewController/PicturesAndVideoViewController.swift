//
//  PicturesAndVideoViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 11/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

protocol PicturesAndVideoViewControllerDelegate {
    func onClickCreateButton()
    func onClickPicturesBackButton()
}

class PicturesAndVideoViewController: UIViewController {

    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var btn_create: UIButton!
    @IBOutlet weak var blogImage0: UIImageView!
    @IBOutlet weak var blogImage1: UIImageView!
    @IBOutlet weak var blogImage2: UIImageView!
    @IBOutlet weak var blogImage3: UIImageView!
    
    @IBOutlet weak var blogVideo0: UIImageView!
    @IBOutlet weak var blogVideo1: UIImageView!
    @IBOutlet weak var blogVideo2: UIImageView!
    @IBOutlet weak var blogVideo3: UIImageView!
    
    @IBOutlet weak var view_image: UIView!
    
    var customDelegate : PicturesAndVideoViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initialize()
    }

    func initialize()
    {
        btn_back.clipsToBounds = true
        btn_back.layer.cornerRadius = btn_back.frame.height/2
        btn_back.layer.borderWidth = 0.5
        btn_back.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
        
        btn_create.clipsToBounds = true
        btn_create.layer.cornerRadius = btn_create.frame.height/2
        
        
    }
    
    override func viewDidLayoutSubviews() {
        self.blogImage0.layer.cornerRadius = self.blogImage0.frame.height / 2
        self.blogImage1.layer.cornerRadius = self.blogImage1.frame.height / 2
        self.blogImage2.layer.cornerRadius = self.blogImage2.frame.height / 2
        self.blogImage3.layer.cornerRadius = self.blogImage3.frame.height / 2
        
        self.blogVideo0.layer.cornerRadius = self.blogVideo0.frame.height / 2
        self.blogVideo1.layer.cornerRadius = self.blogVideo1.frame.height / 2
        self.blogVideo2.layer.cornerRadius = self.blogVideo2.frame.height / 2
        self.blogVideo3.layer.cornerRadius = self.blogVideo3.frame.height / 2
        
        self.blogImage0.layer.borderWidth = 0.5
        self.blogImage1.layer.borderWidth = 0.5
        self.blogImage2.layer.borderWidth = 0.5
        self.blogImage3.layer.borderWidth = 0.5
        
        self.blogImage0.layer.borderColor = UIColor.white.cgColor
        self.blogImage1.layer.borderColor = UIColor.white.cgColor
        self.blogImage2.layer.borderColor = UIColor.white.cgColor
        self.blogImage3.layer.borderColor = UIColor.white.cgColor
        
        self.blogVideo0.layer.borderWidth = 0.5
        self.blogVideo1.layer.borderWidth = 0.5
        self.blogVideo2.layer.borderWidth = 0.5
        self.blogVideo3.layer.borderWidth = 0.5
        
        self.blogVideo0.layer.borderColor = UIColor.white.cgColor
        self.blogVideo1.layer.borderColor = UIColor.white.cgColor
        self.blogVideo2.layer.borderColor = UIColor.white.cgColor
        self.blogVideo3.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func onClickCreateRecipe(_ sender: Any) {
        if customDelegate != nil {
            self.customDelegate.onClickCreateButton()
        }
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        if customDelegate != nil {
            self.customDelegate.onClickPicturesBackButton()
        }
    }
}
